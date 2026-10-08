#!/usr/bin/env bash
# 生成测试程序 + Verilator 端到端仿真（34 个用例，黄金模型对拍）。
# 注意: 必须在【无空格】的路径下运行（Verilator 限制）。
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# 路径含空格会导致 Verilator/Quartus 失败，提前报错
case "${REPO_ROOT}" in
  *" "*)
    echo "错误: 仓库路径含空格「${REPO_ROOT}」，请 clone 到无空格路径（如 ~/riscv-int4-simd）" >&2
    exit 1
    ;;
esac
VEXRISCV_DIR="${REPO_ROOT}/VexRiscv"
SIM_DIR="${REPO_ROOT}/sim"
BUILD_DIR="$(mktemp -d /tmp/xpulpnn_sim.XXXXXX)"

echo "==> 构建目录: ${BUILD_DIR}"

# 1. 生成测试程序（黄金模型 → 汇编）
cd "${SIM_DIR}"
python3 gen_program.py
cp program.S link.ld expected.json n_cases.txt "${BUILD_DIR}/"

# 2. 生成 expected.hex
python3 - "${BUILD_DIR}" <<'PY'
import json, sys
d = sys.argv[1]
exp = json.load(open(f"{d}/expected.json"))
with open(f"{d}/expected.hex", "w") as f:
    for e in exp:
        f.write(f"{e['exp']:08x}\n")
print(f"expected.hex: {len(exp)} 项")
PY

# 3. 汇编 → hex
cd "${BUILD_DIR}"
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib -nostartfiles \
    -T link.ld program.S -o program.elf
riscv64-unknown-elf-objcopy -O binary --only-section=.text program.elf t.bin
python3 - <<'PY'
d = open('t.bin','rb').read()
w = [int.from_bytes(d[i:i+4],'little') for i in range(0,len(d),4)]
while w and w[-1] == 0: w.pop()
open('program.hex','w').write('\n'.join(f"{x:08x}" for x in w) + '\n')
print(f"program.hex: {len(w)} 条指令")
PY

# 4. 复制 Verilog + 测试台
cp "${VEXRISCV_DIR}/VexRiscv.v" "${BUILD_DIR}/"
cp "${SIM_DIR}/tb_full.v" "${BUILD_DIR}/"

# 5. Verilator 仿真
cd "${BUILD_DIR}"
verilator --binary -j 8 -Wno-fatal --top-module tb_full -o sim_full \
    tb_full.v VexRiscv.v --Mdir obj_full
./obj_full/sim_full

echo ""
echo "仿真完成。构建目录保留在: ${BUILD_DIR}"
