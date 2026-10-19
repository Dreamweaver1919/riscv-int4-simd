package vexriscv.plugin

import spinal.core._
import vexriscv.{VexRiscv, Stageable, DecoderService}

/**
 * XpulpNN 风格 INT4 打包 SIMD 扩展 —— VexRiscv 插件实现
 *
 * 指令编码（占用 RISC-V 保留的 custom-1 opcode 0x2B = 0b0101011）:
 *
 *   31      25 24   20 19   15 14  12 11    7 6      0
 *  ┌──────────┬───────┬───────┬──────┬───────┬────────┐
 *  │  funct7  │  rs2  │  rs1  │funct3│  rd   │ 0101011│
 *  └──────────┴───────┴───────┴──────┴───────┴────────┘
 *
 *  funct3 = 000  →  有符号模式 (元素按 4 位补码解释, 范围 [-8, 7])
 *  funct3 = 001  →  无符号模式 (元素按 4 位无符号解释, 范围 [0, 15])
 *
 *  funct7 选择运算:
 *    0x00 = 逐元素加      0x01 = 逐元素减
 *    0x03 = 逐元素取大    0x04 = 逐元素取小
 *
 *  加减法结果【饱和】到元素可表示范围（QNN 推理需要，防止符号翻转）。
 *  溢出行为在 ISA 规范中明确规定，并在 sw/golden_int4.py 里独立实现。
 *
 * 数据布局: 元素 i 位于 bit [4i+3 : 4i]，元素 0 在最低位。
 */
class SimdPlugin extends Plugin[VexRiscv] {
  import SimdPlugin._

  /** 该指令是否属于本插件 */
  object IS_ALU_INT4 extends Stageable(Bool)
  /** 4 位模式: 0=有符号 (funct3=000), 1=无符号 (funct3=001) */
  object INT4_UNSIGNED extends Stageable(Bool)
  /** 具体运算 */
  object INT4_OP extends Stageable(Int4OpEnum())

  /** 该指令是否是点积（funct3=010）*/
  object IS_DOT_INT4 extends Stageable(Bool)
  /** 点积 rs1 是否按无符号解释 */
  object DOT_UNSIGNED_RS1 extends Stageable(Bool)
  /** 点积 rs2 是否按无符号解释 */
  object DOT_UNSIGNED_RS2 extends Stageable(Bool)

  override def setup(pipeline: VexRiscv): Unit = {
    import pipeline.config._

    val decoderService = pipeline.service(classOf[DecoderService])

    // 默认值：非本插件指令时全部为 False
    decoderService.addDefault(IS_ALU_INT4, False)
    decoderService.addDefault(INT4_UNSIGNED, False)
    decoderService.addDefault(INT4_OP, Int4OpEnum.ADD)
    decoderService.addDefault(IS_DOT_INT4, False)
    decoderService.addDefault(DOT_UNSIGNED_RS1, False)
    decoderService.addDefault(DOT_UNSIGNED_RS2, False)

    // 公共的译码动作 —— 写了一处，四种运算共用
    def actions(op: Int4OpEnum.C, unsig: Boolean)
        : List[(Stageable[_ <: BaseType], Any)] = List(
      IS_ALU_INT4              -> True,
      INT4_OP                  -> op,
      INT4_UNSIGNED            -> Bool(unsig),
      REGFILE_WRITE_VALID      -> True,
      // 结果在执行级组合产生，与参考 SimdAddPlugin 一致启用两级旁路。
      // （关闭 EXECUTE 旁路会导致紧跟的 sw 读不到结果 —— 实测教训）
      BYPASSABLE_EXECUTE_STAGE -> True,
      BYPASSABLE_MEMORY_STAGE  -> True,
      RS1_USE                  -> True,
      RS2_USE                  -> True
    )

    // ---- 指令模式构造 ----
    // ⚠️ 关键教训: SpinalHDL 的 M"..." 是**位串拼接**语义，每一位都必须用
    //    '-'（不关心）/ '0' / '1' 明确写出来。若模式总长度不足 32 位，
    //    funct7 的区分位就不会进掩码 —— 译码器会把 funct7 完全忽略，
    //    四条指令被 Quine-McCluskey 合并成同一条（实测: ADD 被译成 MIN，
    //    生成代码里变成 (decode_INSTRUCTION & 32'h0000001c)，只剩 funct3）。
    //    因此这里用具名位域显式拼出 32 位，保证 funct7 参与译码。
    val OPCODE = "0101011"                       // custom-1
    // Scala 的 f"" 插值器不支持 %b，用 toBinaryString 手动补零
    def bits(value: Int, width: Int): String = {
      val s = Integer.toBinaryString(value)
      "0" * (width - s.length) + s
    }
    def pattern(funct7: Int, funct3: Int): MaskedLiteral = {
      // 按 RISC-V R-type 位域精确拼装，每段宽度固定，避免手工数横线出错。
      //   [31:25] funct7 (7) | [24:20] rs2 (5) | [19:15] rs1 (5)
      //   [14:12] funct3 (3) | [11:7]  rd  (5) | [6:0]   opcode (7)
      val s = bits(funct7, 7) +                        // 区分位：显式写出
        bits(0, 5).replace('0', '-') +                 // rs2   不关心
        bits(0, 5).replace('0', '-') +                 // rs1   不关心
        bits(funct3, 3) +                              // 区分位：funct3
        bits(0, 5).replace('0', '-') +                 // rd    不关心
        OPCODE                                         // custom-1
      assert(s.length == 32, s"模式串必须是 32 位，实际 ${s.length} 位: $s")
      MaskedLiteral(s)
    }

    // 注册时用 Seq(...) 一次传入；各模式的 funct7/funct3 组合互不相同，
    // 因此会被识别为独立的译码项。
    decoderService.add(Seq(
      // 有符号模式: funct3 = 000
      pattern(0x00, 0) -> actions(Int4OpEnum.ADD, unsig = false),
      pattern(0x01, 0) -> actions(Int4OpEnum.SUB, unsig = false),
      pattern(0x03, 0) -> actions(Int4OpEnum.MAX, unsig = false),
      pattern(0x04, 0) -> actions(Int4OpEnum.MIN, unsig = false),
      // 无符号模式: funct3 = 001
      pattern(0x00, 1) -> actions(Int4OpEnum.ADD, unsig = true),
      pattern(0x01, 1) -> actions(Int4OpEnum.SUB, unsig = true),
      pattern(0x03, 1) -> actions(Int4OpEnum.MAX, unsig = true),
      pattern(0x04, 1) -> actions(Int4OpEnum.MIN, unsig = true)
    ))

    // ---- 点积指令 (funct3 = 010) ----
    // 结果 32 位标量 = Σ rs1[i]*rs2[i]，8 项乘积求和。
    // 符号组合由 funct7 编码（论文 pv.dotup / pv.dotusp / pv.dotsp）:
    //   0x10 = dotup  : 无符号 × 无符号
    //   0x11 = dotusp : 有符号 × 无符号  (非对称量化常用)
    //   0x12 = dotsp  : 有符号 × 有符号
    def dotActions(u1: Boolean, u2: Boolean)
        : List[(Stageable[_ <: BaseType], Any)] = List(
      IS_DOT_INT4              -> True,
      DOT_UNSIGNED_RS1         -> Bool(u1),
      DOT_UNSIGNED_RS2         -> Bool(u2),
      REGFILE_WRITE_VALID      -> True,
      BYPASSABLE_EXECUTE_STAGE -> True,
      BYPASSABLE_MEMORY_STAGE  -> True,
      RS1_USE                  -> True,
      RS2_USE                  -> True
    )
    decoderService.add(Seq(
      pattern(0x10, 2) -> dotActions(u1 = true,  u2 = true),   // dotup
      pattern(0x11, 2) -> dotActions(u1 = false, u2 = true),   // dotusp
      pattern(0x12, 2) -> dotActions(u1 = false, u2 = false)   // dotsp
    ))
  }

  override def build(pipeline: VexRiscv): Unit = {
    import pipeline._
    import pipeline.config._

    execute plug new Area {
      import execute._

      val rs1 = input(RS1).asUInt
      val rs2 = input(RS2).asUInt
      val unsig = input(INT4_UNSIGNED)
      val op = input(INT4_OP)

      val rd = UInt(32 bits)

      // ---- 饱和边界（在循环外定义一次）----
      // 有符号 4 位: [-8, 7] ; 无符号 4 位: [0, 15]
      // ⚠️ 有符号饱和必须全程用 SInt 比较：-8 的无符号表示是 24，
      //    若用 UInt 比较 (sumS < smin) 会把 3 < 24 判成真，错误饱和到 -8。
      val smax = S(7, 5 bits)
      val smin = S(-8, 5 bits)
      val umax = U(15, 5 bits)
      val uzero = U(0, 5 bits)

      for (i <- 0 until 8) {
        val e1 = rs1(4 * i, 4 bits)
        val e2 = rs2(4 * i, 4 bits)

        // 扩展成 5 位：有符号保留符号位，无符号零扩展。
        // 5 位足以容纳任意两元素加/减结果（有符号 [-16,14]，无符号 [0,30]）
        val s1s = e1.asSInt.resize(5)
        val s2s = e2.asSInt.resize(5)
        val s1u = e1.resize(5)
        val s2u = e2.resize(5)

        // 有符号/无符号各自的加与减（保持 SInt 做有符号算术）
        val sumS = s1s + s2s
        val difS = s1s - s2s
        val sumU = s1u + s2u
        val difU = s1u - s2u

        // ---- 各类候选结果，先无条件算出，再按运算选择（避免推断锁存器）----
        // 有符号饱和：全程 SInt 比较
        val addSatS = (sumS > smax) ? smax.asUInt | ((sumS < smin) ? smin.asUInt | sumS.asUInt)
        val addSatU = (sumU > umax) ? umax | sumU
        val addRes = unsig ? addSatU | addSatS

        // 有符号减法：difS 已是 SInt，饱和后低 4 位即正确补码，直接零扩展回 5 位
        val difSReinterp = U(difS(3 downto 0)).resize(5)
        val subSatS = (difS > smax) ? smax.asUInt |
                      ((difS < smin) ? smin.asUInt | difSReinterp)
        val subSatU = difU(4) ? uzero | ((difU > umax) ? umax | difU)
        val subRes = unsig ? subSatU | subSatS

        val maxRes = unsig ? ((e1 > e2) ? e1 | e2) |
                             ((e1.asSInt > e2.asSInt) ? e1 | e2)
        val minRes = unsig ? ((e1 < e2) ? e1 | e2) |
                             ((e1.asSInt < e2.asSInt) ? e1 | e2)

        val selected = UInt(5 bits)
        selected := addRes
        when(op === Int4OpEnum.SUB) { selected := subRes }
        when(op === Int4OpEnum.MAX) { selected := maxRes.resize(5) }
        when(op === Int4OpEnum.MIN) { selected := minRes.resize(5) }

        rd(4 * i, 4 bits) := selected(3 downto 0)
      }

      when(input(IS_ALU_INT4)) {
        output(REGFILE_WRITE_DATA) := rd.asBits
      }

      // ---- 点积数据通路（32 位标量结果）----
      // Σ rs1[i]*rs2[i]，8 个 4 位元素各自乘加。
      // 符号处理: 无符号元素零扩展（正数）、有符号元素符号扩展，
      // 统一用 8-bit SInt 相乘，保证三种符号组合都得到正确结果。
      // 8 项乘积最大幅度 8×225=1800，32 位 SInt 无溢出。
      //
      // ⚠️ 累加必须用【加法树】而非链式：链式 8 级串联会把关键路径拉长，
      //    实测导致 fmax 从 >100MHz 跌到 ~97MHz。树形 3 级（log2 8）显著缩短。
      val prods = (0 until 8).map { i =>
        val e1 = rs1(4 * i, 4 bits)
        val e2 = rs2(4 * i, 4 bits)
        val a = input(DOT_UNSIGNED_RS1) ? e1.resize(8).asSInt | e1.asSInt.resize(8)
        val b = input(DOT_UNSIGNED_RS2) ? e2.resize(8).asSInt | e2.asSInt.resize(8)
        (a * b).resize(32)
      }
      val lvl0 = prods(0) + prods(1)
      val lvl1 = prods(2) + prods(3)
      val lvl2 = prods(4) + prods(5)
      val lvl3 = prods(6) + prods(7)
      val lvl4 = lvl0 + lvl1
      val lvl5 = lvl2 + lvl3
      val dotSum = lvl4 + lvl5
      when(input(IS_DOT_INT4)) {
        output(REGFILE_WRITE_DATA) := dotSum.asUInt.asBits
      }
    }
  }
}

object SimdPlugin {
  object Int4OpEnum extends SpinalEnum(binarySequential) {
    val ADD, SUB, MAX, MIN = newElement()
  }
}
