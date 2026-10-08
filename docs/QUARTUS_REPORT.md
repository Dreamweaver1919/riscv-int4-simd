# VexRiscv + XpulpNN INT4 SIMD 扩展 — Quartus 综合报告

目标器件: **Altera Agilex 3 — A3CW135BM16AE6S**
工具: **Quartus Prime Pro 26.1.0** (Build 110)
顶层: **VexRiscv**（含 SimdPlugin：INT4 ALU SIMD + 点积）

## 资源占用

| 资源 | 用量 | 总数 | 占比 |
|---|---|---|---|
| Logic (ALM) | 751 | 45,800 | **2%** |
| 专用寄存器 | 571 | — | — |
| Block RAM | 2 | 353 | <1% |
| DSP Blocks | 2 | 368 | <1% |
| 引脚 | 177 | 254 | 70% |

> 注：DSP 2 个用于点积的 4×4-bit 乘法器（综合器把 8 个 nibble 乘法合并进 DSP 块）。
> 整核只占 Agilex 3 器件的 **2% 逻辑** —— 余量极大，可容纳更大的 SoC。

## 时序（fmax）

时钟约束：100 MHz（`create_clock -period 10.0 [get_ports clk]`）

| 版本 | Setup Slack | fmax | 状态 |
|---|---|---|---|
| 链式加法（初始） | **-0.330 ns** | ≈ 96.8 MHz | ❌ 违例 |
| **加法树（优化后）** | **+2.500 ns** | **≈ 133.3 MHz** | ✅ 满足 |

**关键优化**：点积的 8 项累加从「链式 8 级串联」改为「加法树 3 级（log2 8）」，
fmax 提升 **+37%**（96.8 → 133.3 MHz），且 100 MHz 目标下时序裕量充足。

这正是 XpulpNN 论文强调的设计点：
> "the amount of logic required to sum up the partial products is higher
>  than the 8-bit and 16-bit cases... sharing the multiplication resources
>  would be detrimental from a timing point of view"（论文 §III-B1）

## 完整编译流程

```
Quartus Prime Full Compilation: 0 errors, 12 warnings
  ├─ Analysis & Synthesis  ✅
  ├─ Fitter (Place&Route)  ✅
  ├─ Timing Analyzer       ✅ (setup +2.5ns @ 100MHz)
  └─ Assembler             ✅
```

## 复现命令

```bash
cd /tmp/qbuild   # 需无空格路径
export PATH=/opt/altera_pro/26.1/quartus/bin:$PATH
quartus_sh --flow compile xpulpnn -c xpulpnn
```

工程文件：`xpulpnn.qsf`（器件 + 源文件）、`xpulpnn.sdc`（时钟约束）。
生成 Verilog：`sbt "runMain vexriscv.demo.GenXpulpNN"`。

## 文件说明

| 文件 | 说明 |
|---|---|
| `fit.summary` | Fitter 资源报告（ALM/RAM/DSP/寄存器） |
| `sta.summary` | 时序报告（slack/fmax） |
| `syn.summary` | 综合摘要 |
| `VexRiscv_xpulpnn_opt.v` | 优化后（加法树）生成的 Verilog |
| `xpulpnn.qsf` / `xpulpnn.sdc` | Quartus 工程 + 约束 |

## 结论

- ✅ INT4 ALU SIMD（add/sub/max/min，有符号/无符号）+ 点积（dotup/dotusp/dotsp）
  全部通过端到端黄金模型对拍（34/34）
- ✅ Agilex 3 上完整综合布线通过，fmax 133.3 MHz，资源占用仅 2%
- ✅ 展示了「链式加法 → 加法树」微架构优化的量化收益（+37% fmax）
