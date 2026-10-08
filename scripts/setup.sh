#!/usr/bin/env bash
# 克隆上游 VexRiscv 并安装本项目的插件文件。
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# 路径含空格会导致 Verilator/Quartus 失败，提前报错
case "${REPO_ROOT}" in
  *" "*)
    echo "错误: 仓库路径含空格「${REPO_ROOT}」，请 clone 到无空格路径（如 ~/riscv-int4-simd）" >&2
    exit 1
    ;;
esac
VEXRISCV_URL="https://github.com/SpinalHDL/VexRiscv.git"
VEXRISCV_DIR="${REPO_ROOT}/VexRiscv"

echo "==> 克隆 VexRiscv（若已存在则跳过）"
if [ ! -d "${VEXRISCV_DIR}/.git" ]; then
  git clone "${VEXRISCV_URL}" "${VEXRISCV_DIR}"
else
  echo "    VexRiscv 已存在，跳过克隆"
fi

echo "==> 安装插件文件到 VexRiscv"
cp "${REPO_ROOT}/rtl/SimdPlugin.scala" "${VEXRISCV_DIR}/src/main/scala/vexriscv/plugin/"
cp "${REPO_ROOT}/rtl/GenXpulpNN.scala" "${VEXRISCV_DIR}/src/main/scala/vexriscv/demo/"
echo "    已复制:"
echo "      SimdPlugin.scala → src/main/scala/vexriscv/plugin/"
echo "      GenXpulpNN.scala → src/main/scala/vexriscv/demo/"

echo ""
echo "完成。下一步: ./scripts/build_verilog.sh"
