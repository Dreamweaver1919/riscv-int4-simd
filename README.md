# RISC-V INT4 SIMD + Dot-Product Extension (KV260)

XpulpNN 风格的**低精度 INT4 SIMD 加速器**，实现于 VexRiscv RISC-V 核，运行在 **AMD Kria KV260（XCK26）** 上。
面向 INT4 量化神经网络推理：单条指令完成 8 路 4-bit 并行运算或点积。

**状态：已在 KV260 实板上验证，34/34 测试用例与黄金模型逐位一致。**

---

## 1. 项目内容

| 部分 | 说明 |
|---|---|
| **INT4 SIMD 指令扩展** | `src/gen/SimdPlugin.scala` — 本项目核心贡献（243 行） |
| **CPU 微架构定义** | `src/gen/GenXpulpNN.scala` — 插件组合（RV32I + SIMD，无 cache/MMU/中断） |
| **生成的 RTL** | `src/rtl/VexRiscv.v` — 由上述 Scala 生成（3662 行） |
| **KV260 顶层** | `src/rtl/int4_top_safe.v` — CPU + 指令 ROM + 数据 RAM + AXI 从口 + 硬件自检 |
| **测试台** | `src/sim/tb_int4_safe.v` — 行为级仿真 |
| **Vivado 工程** | `int4_kv260/int4_kv260.xpr` — Block Design，XCK26 |

RTL 由 **SpinalHDL（Scala）生成**，不要直接手改 `VexRiscv.v`；改设计请改 Scala 后重新生成（见 §7）。

---

## 2. 指令集

全部使用 RISC-V 保留的 `custom-1` opcode（`0b0101011`），`funct3` 选模式，`funct7` 选运算。

```
31      25 24   20 19   15 14  12 11    7 6      0
┌──────────┬───────┬───────┬──────┬───────┬────────┐
│  funct7  │  rs2  │  rs1  │funct3│  rd   │ 0101011│
└──────────┴───────┴───────┴──────┴───────┴────────┘
```

| 类别 | 指令 | funct3 | funct7 | 说明 |
|---|---|---|---|---|
| ALU SIMD | `add.n` | `000`(有符号) / `001`(无符号) | `0x00` | 逐元素加，**饱和** |
| | `sub.n` | 同上 | `0x01` | 逐元素减，饱和 |
| | `max.n` | 同上 | `0x03` | 逐元素取大 |
| | `min.n` | 同上 | `0x04` | 逐元素取小 |
| 点积 | `dotup.n` | `010` | `0x10` | 无符号 × 无符号 |
| | `dotusp.n` | `010` | `0x11` | 有符号 × 无符号（非对称量化常用） |
| | `dotsp.n` | `010` | `0x12` | 有符号 × 有符号 |

**数据布局**：元素 `i` 位于 bit `[4i+3 : 4i]`，元素 0 在最低位（小端打包）。
有符号元素范围 `[-8, 7]`，无符号 `[0, 15]`；加减结果饱和到该范围，防止符号翻转。

---

## 3. 设计架构

```
+-------------------------------------------------------------+
|  Zynq UltraScale+ PS (xck26)                                |
|    pl_clk0  (100 MHz) --------+                             |
|    pl_resetn0 ----------------+--+                          |
|                               |  |                          |
|    所有 PS AXI 主/从口全部禁用（只提供时钟和复位）           |
+-------------------------------+--+--------------------------+
                                |  |
+-------------------------------+--+--------------------------+
|  PL                                                         |
|   int4_top_safe                                             |
|     +--------------+   iBus   +------------+                |
|     | VexRiscv     |--------->| 指令 ROM   |  512 words     |
|     | +SimdPlugin  |          +------------+                |
|     |              |  dBus    +------------+                |
|     | INT4 SIMD    |--------->| 数据 RAM   |  4096 words    |
|     | + dot-product|          +------------+                |
|     +--------------+                |                       |
|             +---- AXI4-Lite slave ---+                       |
|                      |                                      |
|             +--------+--------+                             |
|             | AXI Interconnect|                              |
|             +--------+--------+                             |
|             +--------+--------+                             |
|             | JTAG-to-AXI     |<-- FT4232H 下载线             |
|             +-----------------+                             |
+-------------------------------------------------------------+
```

### 为什么禁用 PS 的 AXI

这是本项目**最关键的设计决定**，来自实测教训：

早期版本启用 PS→PL 的 AXI 通路（`M_AXI_HPM0_LPD`）让 Linux 直接读写 PL 内存，结果**加载 bitstream 后 Linux 完全冻结** ——
A53 四核 PC 冻结不变、以太网中断停止、UART 无输出，但灯亮、JTAG 可访问、PL 配置状态全对。

**根因**：ZynqMP 上 PL 侧 AXI slave 只要有一次事务没返回 `RRESP`/`BRESP`，PS 对应 AXI 端口就**永久挂起**，
Cortex-A53 死等。这个故障极具欺骗性 —— 从硬件状态看一切正常。

**最终方案**：PS 只贡献时钟和复位，完全不参与数据通路；调试改走 **JTAG-to-AXI**（由 `xsdb` 从主机直接访问）。
这样 PL 侧无论怎么错都不会影响板子的 Linux。

---

## 4. 寄存器映射

### CPU 视角（与测试台一致）

| 地址 | 内容 |
|---|---|
| `0x8000_0000 + 4*i` | 指令 i（ROM，512 字，由 `imem_init.vh` 烧入） |
| `0x8000_1000 + 4*j` | 数据 j（RAM，4096 字） |
| `0x8000_1800` | 完成标志（程序写 `0xDEADBEEF`） |

### JTAG-to-AXI 观察窗口（主机视角）

| 偏移 | 名称 | 说明 |
|---|---|---|
| `0x0000..0x3FFC` | `dmem[n]` | 数据/结果内存镜像（只读） |
| `0x4000` | CTRL | `[0]` 1=运行 / 0=保持复位 |
| `0x4004` | **STATUS** | 自检结果，见下 |
| `0x4008` | ID | 固定 `0x1A7C0DE5` |
| `0x400C` | DBG | 最后一条 iBus PC |

### STATUS 位定义

| 位 | 含义 |
|---|---|
| `[0]` | `cpu_run` |
| `[1]` | `program done` — 程序执行完毕 |
| `[6]` | `check finished` — 硬件自检完成 |
| `[7]` | `check FAILED` |
| `[15:8]` | `mismatch count` — 不一致项数 |

**正常值 = `0x00000043`**（running + done + check_finished，0 不一致）。

---

## 5. 构建与烧录

### 环境

- Vivado 2026.1（已验证；旧版本应亦可）
- 器件 `xck26-sfvc784-2LV-c`
- KV260 板 + FT4232H JTAG 下载线

### 打开工程

```
int4_kv260/int4_kv260.xpr
```

Vivado GUI：`File → Project → Open`。

### 综合 / 实现

GUI：`Flow Navigator → SYNTHESIS → Run Synthesis`，再 `IMPLEMENTATION → Generate Bitstream`。

命令行（**需在无空格路径**，Vivado Tcl 批处理不支持含空格路径）：

```powershell
& 'E:\vivado\2026.1\Vivado\bin\vivado.bat' -mode batch -source build.tcl
```

其中 `build.tcl`：

```tcl
open_project int4_kv260/int4_kv260.xpr
launch_runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
```

产物：`int4_kv260/int4_kv260.runs/impl_1/int4_system_wrapper.bit`

### 烧录到 KV260（走 JTAG，不需要板子的 Linux / 网络）

```tcl
xsdb% connect
xsdb% targets 1
xsdb% fpga -file <路径>/int4_system_wrapper.bit
xsdb% targets 5
xsdb% mrd 0x00004004 1     # STATUS，正常 0x...43
xsdb% mrd 0x00004008 1     # ID，应为 0x1A7C0DE5
```

配套脚本 `flash.tcl`（`xsdb flash.tcl` 运行）：

```tcl
set BITFILE "int4_system_wrapper.bit"
connect
targets 1
fpga -file $BITFILE
after 800
targets 5
puts "STATUS = [mrd 0x00004004 1]"
puts "ID     = [mrd 0x00004008 1]"
disconnect
exit
```

> KV260 断电重启后 PL 会回到出厂架构，需重新烧录。

### 行为级仿真

GUI：`Flow Navigator → SIMULATION → Run Simulation → Run Behavioral Simulation`

预期输出：

```
[OK] program finished in 407 cycles, last PC = 0x80000318
   total 34 | PASS 34 | FAIL 0
   ALL PASS - simulation matches the golden model
```

---

## 6. 验证结果

### 仿真（Vivado xsim）

34/34 PASS，407 周期。

### KV260 实板（经 JTAG）

```
STATUS = 0x00000043
  cpu_run        = 1
  program done   = 1
  check finished = 1
  check FAILED   = 0
  mismatch count = 0
  ID             = 1A7C0DE5
*** 34/34 INT4 SIMD CASES PASS ON HARDWARE ***
```

覆盖范围：`add/sub/max/min.n` 有符号/无符号、饱和边界（`-8`/`7`/`0`/`15`）、
`dotup`/`dotusp`/`dotsp` 三种符号组合的点积、随机向量。

### 硬件自检机制

设计把 34 个期望值硬编码进 PL（`src/rtl/exp_values.vh`）。程序跑完后 PL 内部状态机自动逐项比对：

```verilog
2'd2: begin
    if (dmem[{6'd0, chk_idx}] != exp_mem(chk_idx)) begin
        chk_failed <= 1'b1;
        chk_errs   <= chk_errs + 8'd1;
    end
```

读一个 STATUS 寄存器即可知道 34 项对错，不依赖复杂的主机读回通路。

---

## 7. 资源与时序

| 项目 | 值 | 占 XCK26 |
|---|---|---|
| CLB LUTs | 16,262 | 13.88% |
| — LUT as Logic | 5,709 | 4.87% |
| — LUT as Memory（分布式 RAM） | 10,553 | 18.32% |
| CLB Registers | 4,109 | 1.75% |
| Block RAM | 2.5 | 1.74% |
| DSPs | 0 | 0.00% |

**时序 @ 100 MHz**

```
Setup : 0 failing endpoints,  worst slack 1.528 ns
Hold  : 0 failing endpoints,  worst slack 0.011 ns
All user specified timing constraints are met.
```

> `imem`/`dmem` 被综合成分布式 RAM 而非 BRAM —— 因为 VexRiscv 的 SimpleBus 是组合读、一拍响应，
> 而 BRAM 有固定一拍延迟。XCK26 余量充足，无需优化。

---

## 8. 修改设计

### 改 INT4 指令语义（核心贡献）

1. 编辑 `src/gen/SimdPlugin.scala`
2. 按下方流程重新生成 `VexRiscv.v` 并替换
3. 同步更新 `src/rtl/exp_values.vh`（若行为变了）

### 改 CPU 微架构（加乘法器 / cache / 中断等）

编辑 `src/gen/GenXpulpNN.scala` 的插件清单，然后重新生成。

**这颗核当前不具备的能力**（对应插件未启用）：

| 缺失 | 影响 |
|---|---|
| `IBusCachedPlugin` / `DBusCachedPlugin` | 无 cache，每次访存走总线 |
| `MulPlugin` / `DivPlugin` | 无 M 扩展（只有 SimdPlugin 自带的 4×4 位乘法器） |
| `CsrPlugin` | 无 CSR、无中断、无异常，不能跑 Linux |
| `MmuPlugin` | 无 MMU |
| `DebugPlugin` | 无 JTAG 调试口 |
| `compressedGen = false` | 不支持 RVC 压缩指令 |

### 重新生成 VexRiscv.v

```bash
# 依赖：JDK ≤17（sbt 1.6.0 依赖 Scala 2.12，不支持 JDK 21+）、sbt
git clone https://github.com/SpinalHDL/VexRiscv.git
cp src/gen/SimdPlugin.scala   VexRiscv/src/main/scala/vexriscv/plugin/
cp src/gen/GenXpulpNN.scala   VexRiscv/src/main/scala/vexriscv/demo/
cd VexRiscv
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64
sbt "runMain vexriscv.demo.GenXpulpNN"
# 产物 VexRiscv.v → 复制回 src/rtl/
```

### 改测试程序

`src/rtl/imem_init.vh` 是 199 条指令的 Verilog `case` 初始化。改程序需重新汇编并重新生成该文件。

---

## 9. 已知限制

| 限制 | 说明 |
|---|---|
| **程序烧在 ROM 里** | 换程序需重新综合生成 bitstream |
| **无运行时加载** | 要支持需加 PS AXI 通路，但会带回 §3 的死锁风险 |
| **Vivado 批处理不支持含空格路径** | GUI 无此限制 |
| **点积未推断 DSP** | 4×4 乘法被综合成 LUT 逻辑；要多路并行可手动实例化 DSP48 |
| **`sdotup` 未实现** | 累加型点积需要第 3 个寄存器堆读端口，VexRiscv 只有 2 个 |

---

## 10. 目录结构

```
.
├── README.md                          本文档（唯一）
├── int4_kv260/
│   └── int4_kv260.xpr                 Vivado 工程
│       └── int4_kv260.srcs/sources_1/bd/int4_system/
│           ├── int4_system.bd         Block Design
│           └── ip/*.xci               6 个 Xilinx IP
└── src/
    ├── rtl/
    │   ├── VexRiscv.v                 CPU 核（Scala 生成，含 INT4 SIMD）
    │   ├── int4_top_safe.v            KV260 顶层 + AXI 从口 + 自检
    │   ├── imem_init.vh               199 条指令（程序 ROM 初始化）
    │   └── exp_values.vh              34 个期望值（硬件自检用）
    ├── sim/
    │   └── tb_int4_safe.v             行为级测试台
    ├── gen/
    │   ├── SimdPlugin.scala           ★ INT4 SIMD 扩展（项目核心）
    │   └── GenXpulpNN.scala           CPU 微架构定义
    └── verify/
        ├── golden_int4.py             独立 Python 黄金模型（验证基准）
        └── gen_program.py             由黄金模型生成汇编测试向量
```

---

## 11. 参考

指令语义参考 Garofalo et al., *"XpulpNN: Accelerating Quantized Neural Networks on RISC-V
Processors Through ISA Extensions"*, DATE 2020.

核基于 [VexRiscv](https://github.com/SpinalHDL/VexRiscv)（MIT License）。
