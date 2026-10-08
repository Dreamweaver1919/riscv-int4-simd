# RISC-V INT4 SIMD + Dot-Product Extension for VexRiscv

XpulpNN-style low-precision SIMD extension for the [VexRiscv](https://github.com/SpinalHDL/VexRiscv) RISC-V core, targeting INT4 quantized neural-network inference.

Implemented as a single SpinalHDL plugin (`SimdPlugin.scala`), adding packed INT4 arithmetic **and** dot-product instructions to a standard RV32I core via the RISC-V `custom-1` opcode. Fully verified against an independent Python golden model (34/34 pass), and synthesized for **Altera Agilex 3** (fmax 133 MHz, 2% logic).

## Features

| Category | Instructions | Description |
|---|---|---|
| INT4 ALU SIMD | `add.n`, `sub.n`, `max.n`, `min.n` | 8× 4-bit elements per 32-bit register, signed/unsigned, saturating |
| INT4 Dot-product | `dotup.n`, `dotusp.n`, `dotsp.n` | Σ rs1[i]·rs2[i], 3 sign combinations, 32-bit result |

All instructions use `custom-1` (opcode `0b0101011`), with `funct3` selecting mode and `funct7` selecting operation:

```
31      25 24   20 19   15 14  12 11    7 6      0
┌──────────┬───────┬───────┬──────┬───────┬────────┐
│  funct7  │  rs2  │  rs1  │funct3│  rd   │ 0101011│
└──────────┴───────┴───────┴──────┴───────┴────────┘

funct3  funct7   instruction
  000   0x00/01/03/04   add/sub/max/min.n   (signed)
  001   0x00/01/03/04   add/sub/max/min.n   (unsigned)
  010   0x10           dotup.n   (u × u)
  010   0x11           dotusp.n  (s × u)
  010   0x12           dotsp.n   (s × s)
```

Data layout: element `i` lives in bits `[4i+3 : 4i]` (little-endian packing), element 0 in the LSBs.

## Results

### Verification (Verilator, end-to-end)
- 34 test cases: ALU SIMD boundaries + dot-product boundaries + random vectors
- Result compared against an independent Python golden model (`sw/golden_int4.py`)
- **34/34 PASS** — hardware matches the golden model exactly

### FPGA (Quartus Prime Pro 26.1, Agilex 3 — A3CW135BM16AE6S)
| Resource | Usage | Total |
|---|---|---|
| Logic (ALM) | 751 | 45,800 (**2%**) |
| Registers | 571 | — |
| RAM blocks | 2 | 353 |
| DSP blocks | 2 | 368 |

| Version | Setup slack @100MHz | fmax |
|---|---|---|
| Chained adder (initial) | −0.330 ns (violated) | ≈ 96.8 MHz |
| **Adder tree (final)** | **+2.500 ns** | **≈ 133.3 MHz** |

The adder-tree optimization (8→3 levels) is the exact point XpulpNN highlights as the timing-critical design decision (§III-B1). Full report: `docs/QUARTUS_REPORT.md`.

## Repository layout

```
├── rtl/            # Core contribution — SpinalHDL plugin + generator
│   ├── SimdPlugin.scala
│   └── GenXpulpNN.scala
├── sw/             # Software interface + independent golden model
│   ├── golden_int4.py
│   ├── xpulpnn_intrinsics.h
│   └── test_intrinsics.c
├── sim/            # Verification harness
│   ├── gen_program.py    # golden model → asm → hex test vectors
│   └── tb_full.v         # Verilator testbench
├── quartus/        # FPGA project
│   ├── xpulpnn.qsf
│   └── xpulpnn.sdc
├── docs/           # Reports + visualizations
│   └── results.png
└── scripts/        # One-command reproducibility
    ├── setup.sh
    ├── build_verilog.sh
    ├── simulate.sh
    └── quartus_compile.sh
```

## Prerequisites

- **JDK 11+** and **sbt** (Scala build, generates Verilog)
- **Verilator 5+** (simulation)
- **riscv64-unknown-elf-gcc** (test-program compilation)
- **Python 3** (golden model, no external deps)
- **Quartus Prime Pro 26.1** with Agilex 3 support (FPGA, optional)

## Quick start

```bash
# 1. Clone this repo and the upstream VexRiscv
git clone <this-repo>
cd <this-repo>
./scripts/setup.sh          # clones VexRiscv + installs plugin files

# 2. Generate Verilog
./scripts/build_verilog.sh  # → VexRiscv.v

# 3. Simulate (Verilator, 34 test cases)
./scripts/simulate.sh       # → all PASS

# 4. Synthesize (Quartus, optional)
./scripts/quartus_compile.sh
```

## How it works

The whole extension is **one file** — [`rtl/SimdPlugin.scala`](rtl/SimdPlugin.scala). It registers decode patterns against `DecoderService` and computes results in the `execute` stage. No modification to VexRiscv core files is needed.

The golden model in [`sw/golden_int4.py`](sw/golden_int4.py) is written **independently** from the RTL (from the ISA spec only), so cross-checking it against the hardware is meaningful verification, not a tautology.

## Notes / known limitations

- `sdotup` (accumulating dot-product, 3 operands) is **not implemented**: VexRiscv's register file has only 2 read ports, and reading the old `rd` value requires adding a third read port to `RegFilePlugin`. This is the natural next step.
- The design targets RV32I only (no compressed, no M extension in the demo config — add `MulPlugin` if needed).
- VexRiscv is MIT-licensed; check its LICENSE for your derivative's obligations.

## Acknowledgments

Instruction set semantics follow the XpulpNN extension described in:
Garofalo et al., *"XpulpNN: Accelerating Quantized Neural Networks on RISC-V Processors Through ISA Extensions"*, DATE 2020.
