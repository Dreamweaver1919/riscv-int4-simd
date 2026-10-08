#!/usr/bin/env bash
# 用 sbt 生成 Verilog（含 INT4 SIMD + 点积扩展）。
# 注意: 必须在【无空格】的路径下运行（Verilator/GNU Make 限制）。
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

if [ ! -d "${VEXRISCV_DIR}/src" ]; then
  echo "错误: 未找到 VexRiscv，请先运行 ./scripts/setup.sh" >&2
  exit 1
fi

cd "${VEXRISCV_DIR}"
echo "==> 生成 Verilog (GenXpulpNN)"
sbt "runMain vexriscv.demo.GenXpulpNN"

echo ""
echo "==> 输出: ${VEXRISCV_DIR}/VexRiscv.v"
ls -la VexRiscv.v
