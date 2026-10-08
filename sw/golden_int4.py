"""
INT4 SIMD 指令的独立黄金模型（Golden Model）
============================================
用途：与 RTL 仿真逐元素对拍，验证硬件语义正确性。

设计原则（很重要）：
  本文件【只依据 RISC-V 规范和 XpulpNN 论文 Table II 的语义定义编写】，
  不参考任何 Verilog/SpinalHDL 实现。否则同一 bug 会在两边同时存在，
  对拍永远查不出来 —— 这是验证工作最常见的致命错误。

用法：
  python3 golden_int4.py            # 自检 + 随机向量生成
"""

MASK32 = 0xFFFFFFFF

def unpack_int4(w, signed=True):
    """把 32 位字拆成 8 个 INT4 元素，元素 i 位于 bit [4i+3 : 4i]"""
    out = []
    for i in range(8):
        v = (w >> (4 * i)) & 0xF
        if signed and (v & 0x8):      # 4 位补码：最高位是符号位
            v -= 16
        out.append(v)
    return out

def pack_int4(elems):
    """8 个 INT4 元素打包回 32 位（低 4 位截断）"""
    w = 0
    for i, e in enumerate(elems):
        w |= (e & 0xF) << (4 * i)
    return w & MASK32

def _clip(v, signed):
    """把标量结果限制到 INT4 可表示范围。
    这是【必须由 ISA 明确规定】的行为 —— 见文件末尾"规范决策"一节。"""
    lo, hi = (-8, 7) if signed else (0, 15)
    return max(lo, min(hi, v))

def _apply(vals, signed, sat):
    """统一处理溢出：sat=True 饱和，sat=False 按位截断（wrap）"""
    if sat:
        return [_clip(v, signed) for v in vals]
    return vals

def add_n(a, b, signed=True, sat=True):
    """pv.add.n : rD[i] = rs1[i] + rs2[i]

    sat=True  → 饱和到 INT4 范围（QNN 推理的正确选择，防止符号翻转）
    sat=False → 2 的补码截断（wrap），7+7 会变成 -2
    """
    x, y = unpack_int4(a, signed), unpack_int4(b, signed)
    return pack_int4(_apply([xi + yi for xi, yi in zip(x, y)], signed, sat))

def sub_n(a, b, signed=True, sat=True):
    x, y = unpack_int4(a, signed), unpack_int4(b, signed)
    return pack_int4(_apply([xi - yi for xi, yi in zip(x, y)], signed, sat))

def max_n(a, b, signed=True, sat=True):
    """pv.max.n : 逐元素取大（signed=False 时按无符号比较）
    sat 参数被接受但忽略 —— 比较运算的结果必定是某个输入，不可能溢出。
    保留该参数只为让所有 SIMD 指令的签名一致，便于统一对拍。"""
    x, y = unpack_int4(a, signed), unpack_int4(b, signed)
    return pack_int4([max(xi, yi) for xi, yi in zip(x, y)])

def min_n(a, b, signed=True, sat=True):
    """pv.min.n : 逐元素取小。sat 参数同 max_n，被接受但忽略。"""
    x, y = unpack_int4(a, signed), unpack_int4(b, signed)
    return pack_int4([min(xi, yi) for xi, yi in zip(x, y)])

def dotup_n(a, b):
    """pv.dotup.n : rD = Σ rs1[i]*rs2[i]，两操作数均按【无符号】4 位解释
       8 项乘积求和，结果满 32 位（无溢出风险：最大 8*15*15=1800）"""
    x, y = unpack_int4(a, False), unpack_int4(b, False)
    return sum(xi * yi for xi, yi in zip(x, y)) & MASK32

def dotusp_n(a, b):
    """pv.dotusp.n : rs1 按【有符号】、rs2 按【无符号】解释
       这是非对称量化（权重有符号、激活无符号）的常用组合"""
    x, y = unpack_int4(a, True), unpack_int4(b, False)
    return sum(xi * yi for xi, yi in zip(x, y)) & MASK32

def dotsp_n(a, b):
    """pv.dotsp.n : rs1、rs2 均按【有符号】解释（signed×signed）"""
    x, y = unpack_int4(a, True), unpack_int4(b, True)
    return sum(xi * yi for xi, yi in zip(x, y)) & MASK32

def sdotup_n(acc, a, b):
    """pv.sdotup.n : 带累加。注意是【3 输入】运算，rd 既作输入又作输出"""
    return (acc + dotup_n(a, b)) & MASK32


# ---------------- 自检 ----------------
def self_test():
    ok = True
    def chk(cond, msg):
        nonlocal ok
        print(("  ✅ " if cond else "  ❌ ") + msg)
        ok = ok and cond

    print("【自检 1】打包/解包往返一致性")
    for w in [0x00000000, 0xFFFFFFFF, 0x12345678, 0x89ABCDEF, 0x0F0F0F0F]:
        chk(pack_int4(unpack_int4(w)) == w, f"roundtrip 0x{w:08X}")

    print("\n【自检 2】符号解释正确性")
    chk(unpack_int4(0x0000000F)[0] == -1, "0xF 按有符号解释为 -1")
    chk(unpack_int4(0x0000000F, signed=False)[0] == 15, "0xF 按无符号解释为 15")
    chk(unpack_int4(0x00000008)[0] == -8, "0x8 有符号 = -8 (最小 INT4)")

    print("\n【自检 3】已知答案的加法（全元素独立，互不干扰）")
    chk(add_n(0x00000000, 0x00000000) == 0x00000000, "0 + 0 = 0")
    chk(add_n(0x11111111, 0x11111111) == 0x22222222, "每元素 1+1=2")
    # 元素 7 单独测试，确认没有跨元素进位污染
    # 注意这里必须 sat=False：7+1=8 在有符号 INT4 里溢出，饱和模式下会变 7，
    # 那样就掩盖了本测试真正要查的"跨元素污染"问题。
    r = add_n(0x70000000, 0x10000000, sat=False)
    chk((r >> 28) & 0xF == 8, "最高元素 7+1=8（截断模式，隔离测试跨元素污染）")
    chk((r & 0x0FFFFFFF) == 0, "低 7 个元素仍为 0（无跨元素污染）")

    print("\n【自检 4】有符号 vs 无符号在减法上的区别")
    # 0x0F = 有符号 -1 / 无符号 15
    r = sub_n(0x00000000, 0x0000000F)
    chk(unpack_int4(r)[0] == 1, "0-(-1)=1 (有符号)")
    chk(dotup_n(0x0000000F, 0x0000000F) == 225, "无符号 15*15=225")
    chk(dotusp_n(0x0000000F, 0x0000000F) == -15 & MASK32, "有符号(-1)*无符号15=-15")
    chk(dotusp_n(0x0000000F, 0x0000000F) == 0xFFFFFFF1, "-15 的补码表示 = 0xFFFFFFF1")

    print("\n【自检 5】溢出行为：饱和(sat) vs 截断(wrap) —— 规范必须二选一")
    # 7+7=14: 无符号 4 位装得下(14<=15), 有符号 4 位装不下(>7)
    # 必须显式传 signed=False，否则有符号模式下 14 溢出会被饱和成 7
    chk(unpack_int4(add_n(0x00000007, 0x00000007, signed=False), signed=False)[0] == 14,
        "无符号模式: 7+7=14 (4 位可表示)")
    chk(unpack_int4(add_n(0x00000007, 0x00000007, sat=True))[0] == 7,
        "有符号+饱和: 7+7=14 溢出 → 饱和到最大值 7")
    chk(unpack_int4(add_n(0x00000007, 0x00000007, sat=False))[0] == -2,
        "有符号+截断: 7+7=14 → 0xE → 解释为 -2 (符号翻转!)")
    # 负向溢出
    chk(unpack_int4(add_n(0x00000009, 0x00000009, sat=True))[0] == -8,
        "有符号+饱和: (-7)+(-7)=-14 溢出 → 饱和到最小值 -8")
    chk(unpack_int4(sub_n(0x00000000, 0x0000000F, sat=True))[0] == 1,
        "有符号+饱和: 0-(-1)=1 不溢出，保持 1")
    r = sub_n(0x00000007, 0x00000009, sat=True)
    chk(unpack_int4(r)[0] == 7, "有符号+饱和: 7-(-7)=14 溢出 → 饱和到 7")

    print("\n【自检 6】点积的 3 输入形式")
    chk(sdotup_n(100, 0x00000001, 0x00000002) == 102, "acc=100 + 1*2 = 102")
    # 全 0xF：8 * 15 * 15 = 1800
    chk(dotup_n(0xFFFFFFFF, 0xFFFFFFFF) == 1800, "8 * 15 * 15 = 1800")

    print("\n" + ("=" * 60))
    print("全部自检通过 ✅" if ok else "存在失败项 ❌")
    print("=" * 60)
    return ok


if __name__ == "__main__":
    import random
    good = self_test()

    print("\n【随机向量生成示例】用于与 RTL 对拍")
    print(f"{'rs1':>10} {'rs2':>10} | {'add_n':>10} {'dotup_n':>12} {'dotusp_n':>12}")
    print("-" * 62)
    random.seed(42)
    for _ in range(6):
        a = random.getrandbits(32)
        b = random.getrandbits(32)
        print(f"0x{a:08X} 0x{b:08X} | 0x{add_n(a,b):08X} {dotup_n(a,b):>12} {dotusp_n(a,b):>12}")

    print("\n对拍脚本骨架：")
    print("""
    # 1) 用随机向量生成 C 测试程序（内嵌 rs1/rs2 和期望结果）
    # 2) 在 DUT（Verilator 或 FPGA）上运行，读回 rd
    # 3) 与上面的黄金值逐元素比较，任何不一致立即定位到元素下标
    #
    # 关键：黄金模型在此 Python 文件里，DUT 是 RTL —— 两者完全独立
    """)


# =====================================================================
# 规范决策（SPEC DECISIONS）—— 写 RTL 之前必须逐条确定
# =====================================================================
# 下面每一条都是 ISA 定义里【必须明确写出】的行为。留空 = 硬件和软件
# 各自假设，最终表现为"仿真过了但芯片行为不对"。
#
# D1. 元素内数据布局
#     决定: 元素 i 位于 bit [4i+3 : 4i]，元素 0 在最低位（小端打包）
#     待定: 是否支持字节序切换？
#
# D2. 元素符号解释
#     决定: 由指令的 .u 后缀区分，无后缀 = 有符号（与论文 pv.max/pv.maxu 一致）
#     注意: pv.dotup/dotusp/dotsp 的符号组合由指令本身编码，不靠后缀
#
# D3. 算术溢出行为  ← 本文件自检 5 暴露的问题，最容易漏
#     候选 A: 饱和 (saturate)  结果夹到 [-8,7]
#     候选 B: 截断 (wrap)      保留低 4 位，符号会翻转
#     建议: 加法/减法用饱和（QNN 推理防止符号翻转毁掉结果）
#           点积不涉及此问题（结果是 32 位，不可能溢出）
#     必须做: 提供 sat 控制位或单独指令，且【明确写进 ISA 文档】
#
# D4. 点积的中间精度
#     决定: 8 个 4 位乘积各自 8 位，加法树用 32 位累加，无舍入
#     最大正值 = 8 * 15 * 15 = 1800，32 位绰绰有余
#
# D5. 累加指令的 rd 语义
#     决定: pv.sdotup 的 rd 既是输入（原有累加值）又是输出
#     后果: 无法用 CfuPlugin 实现（其上限为 2 输入 1 输出），必须自己写 datapath
#
# D6. 非对齐 / 非法指令
#     决定: 未定义的 funct3/funct7 组合必须触发 illegal instruction 异常
#     必须做: 写负向测试验证异常真的被触发，而不是静默执行
#
# D7. 跨通道操作
#     决定: 本子集【不支持】跨通道（如通道间求和、洗牌）
#     理由: 会显著增加数据通路复杂度和布线压力，FYP 范围外

