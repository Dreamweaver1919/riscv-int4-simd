#!/usr/bin/env python3
"""
生成 RISC-V 测试程序（汇编），用真实的自定义指令驱动 VexRiscv。

关键点:
  - 指令编码直接按 ISA 规范构造，不经过编译器机器描述
  - 期望值由独立的 Python 黄金模型算出
  - 程序把结果写入内存固定区域，供 Verilog testbench 读回比对

指令字构造:
  bits[6:0]   = 0x2B          custom-1 opcode
  bits[11:7]  = rd
  bits[14:12] = funct3        ALU: 0=有符号 1=无符号 ; 点积: 2
  bits[19:15] = rs1
  bits[24:20] = rs2
  bits[31:25] = funct7        ALU: 0=ADD 1=SUB 3=MAX 4=MIN
                              点积: 0x10=dotup 0x11=dotusp 0x12=dotsp
"""
import sys, os, random

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'sw'))
from golden_int4 import add_n, sub_n, max_n, min_n, dotup_n, dotusp_n, dotsp_n

CUSTOM1 = 0x2B
FUNCT7 = {
    "add": 0x00, "sub": 0x01, "max": 0x03, "min": 0x04,
    "dotup": 0x10, "dotusp": 0x11, "dotsp": 0x12,
}
FUNCT3 = {"dotup": 2, "dotusp": 2, "dotsp": 2}   # ALU 用 0/1（见 encode）
GOLDEN = {
    "add": add_n, "sub": sub_n, "max": max_n, "min": min_n,
    "dotup": dotup_n, "dotusp": dotusp_n, "dotsp": dotsp_n,
}
DOT_OPS = ("dotup", "dotusp", "dotsp")

# 测试用例: (op, signed, rs1, rs2)
#   ALU 指令 signed 有意义；点积指令 signed 传 None（符号组合由 funct7 编码）
CASES = [
    # --- ALU 边界: 零、全 F、符号位边界、交替模式 ---
    ("add", True,  0x00000000, 0x00000000),
    ("add", True,  0x77777777, 0x11111111),   # 7+1=8 溢出 → 饱和到 7
    ("add", True,  0x88888888, 0x88888888),   # -8 + -8 = -16 → 饱和到 -8
    ("add", False, 0x77777777, 0x11111111),   # 无符号 7+1=8 不溢出
    ("add", False, 0xFFFFFFFF, 0x11111111),   # 15+1=16 → 饱和到 15
    ("sub", True,  0x00000000, 0x11111111),   # 0-1 = -1
    ("sub", True,  0x77777777, 0x88888888),   # 7-(-8)=15 → 饱和到 7
    ("sub", False, 0x00000000, 0x11111111),   # 无符号 0-1 → 饱和到 0
    ("max", True,  0x12345678, 0x9ABCDEF0),   # 有符号比较
    ("max", False, 0x12345678, 0x9ABCDEF0),   # 无符号比较（结果不同!）
    ("min", True,  0x12345678, 0x9ABCDEF0),
    ("min", False, 0x12345678, 0x9ABCDEF0),
    ("add", True,  0x0F0F0F0F, 0x00FF00FF),   # 交替模式
    # --- 点积边界 ---
    ("dotup",  None, 0x00000000, 0x00000000), # 0
    ("dotup",  None, 0xFFFFFFFF, 0xFFFFFFFF), # 1800 (8×15×15)
    ("dotusp", None, 0xFFFFFFFF, 0xFFFFFFFF), # -120 (8×(-1)×15)
    ("dotsp",  None, 0xFFFFFFFF, 0xFFFFFFFF), # 8   (8×(-1)×(-1))
    ("dotsp",  None, 0x0F0F0F0F, 0x00FF00FF), # 混合符号
    ("dotup",  None, 0x11111111, 0x22222222), # 8×(1×2)=16
]
# 补随机（固定种子，可复现）
random.seed(7)
for _ in range(3):
    CASES.append(("add", True, random.getrandbits(32), random.getrandbits(32)))
    CASES.append(("min", True, random.getrandbits(32), random.getrandbits(32)))
    CASES.append(("dotup",  None, random.getrandbits(32), random.getrandbits(32)))
    CASES.append(("dotusp", None, random.getrandbits(32), random.getrandbits(32)))
    CASES.append(("dotsp",  None, random.getrandbits(32), random.getrandbits(32)))

DATA_BASE = 0x80001000


def encode(op, signed, rs1, rs2, rd):
    if op in DOT_OPS:
        funct3 = 2
    else:
        funct3 = 0 if signed else 1
    return (CUSTOM1
            | (rd << 7)
            | (funct3 << 12)
            | (rs1 << 15)
            | (rs2 << 20)
            | (FUNCT7[op] << 25))


def golden(op, signed, a, b):
    if op in DOT_OPS:
        return GOLDEN[op](a, b)
    return GOLDEN[op](a, b, signed=signed, sat=True)


def li_seq(rd, value):
    """把 32 位常量装入寄存器的指令序列（lui + addi）"""
    value &= 0xFFFFFFFF
    hi = (value + 0x800) >> 12
    lo = value - (hi << 12)
    hi &= 0xFFFFF
    out = []
    if hi:
        out.append(f"  lui x{rd}, 0x{hi:x}")
        if lo:
            out.append(f"  addi x{rd}, x{rd}, {lo}")
    else:
        out.append(f"  addi x{rd}, x0, {lo & 0xFFF if lo >= 0 else lo}")
    return out


def main():
    lines = []
    a = lines.append
    a("# 自动生成 —— 请勿手工修改；重新生成请运行 gen_program.py")
    a("# 测试 VexRiscv + SimdPlugin 的 INT4 SIMD + 点积扩展（custom-1 编码）")
    a("")
    a('.section .text')
    a('.globl _start')
    a('.org 0x0')
    a('_start:')
    a("  lui  sp, 0x80002            # 栈指针 = 0x80002000（避开数据区）")
    a(f"  lui  x28, 0x{DATA_BASE >> 12:x}          # x28 = 结果写入基址")

    for idx, (op, signed, v1, v2) in enumerate(CASES):
        a("")
        sign_str = {True: 'signed', False: 'unsigned', None: 'dot'}[signed]
        a(f"  # ---- case {idx}: {op} / {sign_str} "
          f"rs1=0x{v1:08x} rs2=0x{v2:08x} ----")
        lines.extend(li_seq(5, v1))          # x5 = rs1
        lines.extend(li_seq(6, v2))          # x6 = rs2
        word = encode(op, signed, 5, 6, 7)   # x7 = 结果
        a(f"  .word 0x{word:08x}                # {op}.n")
        a(f"  sw   x7, {idx * 4}(x28)          # 存结果到 mem[{idx}]")

    a("")
    a("  # ---- 完成标志 ----")
    a(f"  li   x9, 0x{(DATA_BASE + 0x800) & 0xFFFFFFFF:x}")
    a("  li   x10, 0xDEADBEEF")
    a("  sw   x10, 0(x9)             # 写完成标志，testbench 轮询此地址")
    a("done:")
    a("  j    done                   # 停机")

    with open("program.S", "w") as f:
        f.write("\n".join(lines) + "\n")

    with open("link.ld", "w") as f:
        f.write(f"""OUTPUT_ARCH( "riscv" )
ENTRY(_start)
SECTIONS {{
  . = 0x80000000;
  .text : {{ *(.text) }}
  . = 0x{DATA_BASE:x};
  .data : {{ *(.data) }}
}}
""")

    expected = []
    for (op, signed, v1, v2) in CASES:
        exp = golden(op, signed, v1, v2)
        expected.append({"op": op, "signed": signed, "rs1": v1, "rs2": v2, "exp": exp})

    import json
    with open("expected.json", "w") as f:
        json.dump(expected, f, indent=1)
    with open("n_cases.txt", "w") as f:
        f.write(str(len(expected)) + "\n")
    with open("n_cases.hex", "w") as f:
        f.write(f"{len(expected):x}\n")   # $readmemh 用 hex

    print(f"生成 program.S: {len(CASES)} 个测试用例")
    print(f"生成 link.ld, expected.json")
    print()
    print(f"{'#':>3} {'运算':>7} {'符号':>8} {'rs1':>10} {'rs2':>10} {'期望结果':>10}")
    print("-" * 58)
    for i, e in enumerate(expected):
        s = {True: 'signed', False: 'unsign', None: 'dot'}[e['signed']]
        print(f"{i:>3} {e['op']:>7} {s:>8} "
              f"0x{e['rs1']:08x} 0x{e['rs2']:08x} 0x{e['exp']:08x}")


if __name__ == "__main__":
    main()
