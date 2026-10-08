#!/usr/bin/env bash
# Quartus Prime 综合布线（Agilex 3）。
# 前提: Quartus Prime Pro 26.1 已安装，且 Agilex 3 器件支持已安装。
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
Q_DIR="${REPO_ROOT}/quartus"

# Quartus 安装路径（按需修改）
QUARTUS_BIN="${QUARTUS_BIN:-/opt/altera_pro/26.1/quartus/bin}"

if [ ! -x "${QUARTUS_BIN}/quartus_sh" ]; then
  echo "错误: 未找到 quartus_sh，请设置 QUARTUS_BIN 环境变量" >&2
  exit 1
fi

echo "==> 复制生成的 Verilog 到 quartus/"
cp "${VEXRISCV_DIR}/VexRiscv.v" "${Q_DIR}/VexRiscv.v"

cd "${Q_DIR}"
export PATH="${QUARTUS_BIN}:${PATH}"

echo "==> 运行完整综合流程"
quartus_sh --flow compile xpulpnn -c xpulpnn

echo ""
echo "==> 结果摘要"
echo "--- 资源 ---"
cat output_files/xpulpnn.fit.summary 2>/dev/null | grep -E "Logic|registers|RAM|DSP|pins"
echo "--- 时序 ---"
cat output_files/xpulpnn.sta.summary 2>/dev/null | grep -E "Slack|Type"
