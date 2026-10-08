package vexriscv.demo

import spinal.core._
import vexriscv.plugin._
import vexriscv.{VexRiscv, VexRiscvConfig, plugin}

/**
 * XpulpNN 风格 INT4 SIMD 核的生成器
 *
 * 这个文件就是 FYP 的"架构定义" —— 微架构选型固化在这里，可版本控制、可复现。
 *
 * 微架构选型说明:
 *   - IBusSimplePlugin / DBusSimplePlugin : 简单总线，无 cache
 *     （先用最小配置把语义验证通过，再考虑加 cache 提性能）
 *   - 无 MMU、无 CSR : 减少一次性引入的复杂度
 *   - HazardSimplePlugin : 标准冒险处理
 *   - SimdPlugin : 本项目的 INT4 SIMD 扩展
 *
 * 运行: sbt "runMain vexriscv.demo.GenXpulpNN"
 */
object GenXpulpNN extends App {
  def cpu() = new VexRiscv(
    config = VexRiscvConfig(
      plugins = List(
        new SimdPlugin,                          // ← 本项目核心扩展
        new IBusSimplePlugin(
          resetVector = 0x80000000l,
          cmdForkOnSecondStage = false,
          cmdForkPersistence = false,
          prediction = NONE,
          catchAccessFault = false,
          compressedGen = false
        ),
        new DBusSimplePlugin(
          catchAddressMisaligned = false,
          catchAccessFault = false
        ),
        new DecoderSimplePlugin(
          catchIllegalInstruction = false
        ),
        new RegFilePlugin(
          regFileReadyKind = plugin.SYNC,
          zeroBoot = false
        ),
        new IntAluPlugin,
        new SrcPlugin(
          separatedAddSub = false,
          executeInsertion = false
        ),
        new FullBarrelShifterPlugin,
        new HazardSimplePlugin(
          bypassExecute           = true,
          bypassMemory            = true,
          bypassWriteBack         = true,
          bypassWriteBackBuffer   = true,
          pessimisticUseSrc       = false,
          pessimisticWriteRegFile = false,
          pessimisticAddressMatch = false
        ),
        new BranchPlugin(
          earlyBranch = false,
          catchAddressMisaligned = false
        ),
        new YamlPlugin("xpulpnn.yaml")
      )
    )
  )
  SpinalVerilog(cpu())
}
