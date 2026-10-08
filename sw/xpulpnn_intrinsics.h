#ifndef XPULPNN_INTRINSICS_H
#define XPULPNN_INTRINSICS_H

/*
 * XpulpNN 子集 intrinsics —— 手写 SIMD 头文件（GCC/Clang 通用，无需改编译器）
 *
 * 编码约定（RV32 自定义指令，使用完全空闲的 custom-1 opcode）:
 *   opcode = 0x2B (0101011) = custom-1
 *   指令长度 = 32 位
 *   字段位置与 RISC-V 规范一致:  rs1[19:15]  rs2[24:20]  rd[11:7]
 *
 *   funct3 选子操作类别:
 *     000 = 8-bit  打包 SIMD (4 元素/寄存器)
 *     001 = 4-bit  打包 SIMD (8 元素/寄存器)   <- INT4, FYP 核心
 *     010 = 点积/乘加 (dotp/sdotp)
 *     011 = 跨通道规约 (max/min/avg 归约)
 *     100 = 量化 (pv.qnt)
 *
 *   funct7 选具体运算 (配合 funct3)
 */

/* 用 __asm__ 生成 R-type 自定义指令（标准做法）*/
#define _XPULPNN_R(funct7, funct3, rd, rs1, rs2)                            \
  __asm__ volatile(".insn r 0x2B, " #funct3 ", " #funct7 ", %0, %1, %2"      \
                   : "=r"(rd)                                                 \
                   : "r"(rs1), "r"(rs2))

/* ===== 4-bit (nibble) ALU SIMD : 8 个 INT4 元素并行 ===== */
/* funct3=001, funct7 编码各个运算 */
static inline unsigned xp_add_n (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x00,1,r,a,b); return r; }
static inline unsigned xp_sub_n (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x01,1,r,a,b); return r; }
static inline unsigned xp_avg_n (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x02,1,r,a,b); return r; }
static inline unsigned xp_max_n (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x03,1,r,a,b); return r; }
static inline unsigned xp_min_n (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x04,1,r,a,b); return r; }

/* ===== 8-bit (byte) ALU SIMD : 4 个 INT8 元素并行 ===== */
static inline unsigned xp_add_b (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x00,0,r,a,b); return r; }
static inline unsigned xp_sub_b (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x01,0,r,a,b); return r; }
static inline unsigned xp_max_b (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x03,0,r,a,b); return r; }
static inline unsigned xp_min_b (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x04,0,r,a,b); return r; }

/* ===== 点积 / 乘累加 : funct3=010 =====
 * rD = rs1[0]*rs2[0] + ... + rs1[7]*rs2[7]   (INT4, 8 项)
 * 变体按符号解释方式区分（对应论文 Table II 的 dotup/dotusp/dotsp）
 *   unsig=0: 两个操作数都当无符号
 *   unsig=1: rs1 有符号 / rs2 无符号   (非对称量化的常见组合)
 */
static inline unsigned xp_dotup_n (unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x10,2,r,a,b); return r; }
static inline unsigned xp_dotusp_n(unsigned a, unsigned b){ unsigned r; _XPULPNN_R(0x11,2,r,a,b); return r; }

/* sdotp: 带累加，累加值放在 rd（对应论文 pv.sdotup）
 * 注意: 这是 3 输入运算，需自己写 datapath，不能用 CfuPlugin（上限 2 输入）*/
static inline unsigned xp_sdotup_n (unsigned acc, unsigned a, unsigned b){
  unsigned r = acc; _XPULPNN_R(0x12,2,r,a,b); return r;
}

#endif /* XPULPNN_INTRINSICS_H */
