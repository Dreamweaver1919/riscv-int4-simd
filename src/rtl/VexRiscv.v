// Generator : SpinalHDL v1.13.0    git head : d9d72474863badf47d8585d187f3e04ae4749c59
// Component : VexRiscv
// Git hash  : baf7dc82f855eddaf5b0a20a6802c526f127e38a

`timescale 1ns/1ps

module VexRiscv (
  output wire          iBus_cmd_valid,
  input  wire          iBus_cmd_ready,
  output wire [31:0]   iBus_cmd_payload_pc,
  input  wire          iBus_rsp_valid,
  input  wire          iBus_rsp_payload_error,
  input  wire [31:0]   iBus_rsp_payload_inst,
  output wire          dBus_cmd_valid,
  input  wire          dBus_cmd_ready,
  output wire          dBus_cmd_payload_wr,
  output wire [3:0]    dBus_cmd_payload_mask,
  output wire [31:0]   dBus_cmd_payload_address,
  output wire [31:0]   dBus_cmd_payload_data,
  output wire [1:0]    dBus_cmd_payload_size,
  input  wire          dBus_rsp_ready,
  input  wire          dBus_rsp_error,
  input  wire [31:0]   dBus_rsp_data,
  input  wire          clk,
  input  wire          reset
);
  localparam ShiftCtrlEnum_DISABLE_1 = 2'd0;
  localparam ShiftCtrlEnum_SLL_1 = 2'd1;
  localparam ShiftCtrlEnum_SRL_1 = 2'd2;
  localparam ShiftCtrlEnum_SRA_1 = 2'd3;
  localparam BranchCtrlEnum_INC = 2'd0;
  localparam BranchCtrlEnum_B = 2'd1;
  localparam BranchCtrlEnum_JAL = 2'd2;
  localparam BranchCtrlEnum_JALR = 2'd3;
  localparam AluBitwiseCtrlEnum_XOR_1 = 2'd0;
  localparam AluBitwiseCtrlEnum_OR_1 = 2'd1;
  localparam AluBitwiseCtrlEnum_AND_1 = 2'd2;
  localparam AluCtrlEnum_ADD_SUB = 2'd0;
  localparam AluCtrlEnum_SLT_SLTU = 2'd1;
  localparam AluCtrlEnum_BITWISE = 2'd2;
  localparam Int4OpEnum_ADD = 2'd0;
  localparam Int4OpEnum_SUB = 2'd1;
  localparam Int4OpEnum_MAX = 2'd2;
  localparam Int4OpEnum_MIN = 2'd3;
  localparam Src2CtrlEnum_RS = 2'd0;
  localparam Src2CtrlEnum_IMI = 2'd1;
  localparam Src2CtrlEnum_IMS = 2'd2;
  localparam Src2CtrlEnum_PC = 2'd3;
  localparam Src1CtrlEnum_RS = 2'd0;
  localparam Src1CtrlEnum_IMU = 2'd1;
  localparam Src1CtrlEnum_PC_INCREMENT = 2'd2;
  localparam Src1CtrlEnum_URS1 = 2'd3;

  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready;
  reg        [31:0]   RegFilePlugin_regFile_spinal_port0;
  reg        [31:0]   RegFilePlugin_regFile_spinal_port1;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  wire       [0:0]    IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy;
  wire       [0:0]    IBusSimplePlugin_rspJoin_rspBuffer_c_io_availability;
  wire       [31:0]   _zz_execute_SHIFT_RIGHT;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_1;
  wire       [32:0]   _zz_execute_SHIFT_RIGHT_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_3;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_10;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_10_8;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_13;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_14;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_21;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_21_8;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_24;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_25;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_32;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_32_8;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_35;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_36;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_43;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_43_8;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_46;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_47;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_54;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_54_8;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_57;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_58;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_65;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_65_8;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_68;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_69;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_76;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_76_8;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_79;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_80;
  wire       [4:0]    _zz__zz_execute_SimdPlugin_rd_87;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_1;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_2;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_3;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_4;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_5;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_6;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_7;
  wire       [3:0]    _zz__zz_execute_SimdPlugin_rd_87_8;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_0_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_0_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_0_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_0_12;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_1_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_1_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_1_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_1_12;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_2_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_2_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_2_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_2_12;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_3_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_3_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_3_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_3_12;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_4_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_4_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_4_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_4_12;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_5_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_5_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_5_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_5_12;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_6_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_6_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_6_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_6_12;
  wire       [15:0]   _zz_execute_SimdPlugin_prods_7_2;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_3;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_4;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_5;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_7_7;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_8;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_9;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_10;
  wire       [7:0]    _zz_execute_SimdPlugin_prods_7_11;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_7_12;
  wire       [31:0]   _zz_IBusSimplePlugin_fetchPc_pc;
  wire       [2:0]    _zz_IBusSimplePlugin_fetchPc_pc_1;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next_1;
  wire       [0:0]    _zz_IBusSimplePlugin_pending_next_2;
  wire       [2:0]    _zz_IBusSimplePlugin_pending_next_3;
  wire       [0:0]    _zz_IBusSimplePlugin_pending_next_4;
  wire       [2:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire       [0:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1;
  wire       [2:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2;
  wire       [0:0]    _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_1;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_2;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_3;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_4;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_5;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_6;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_7;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_8;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_9;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_10;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_11;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_12;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_13;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_14;
  wire       [23:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_15;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_16;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_17;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_18;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_19;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_20;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_21;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_22;
  wire       [20:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_23;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_24;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_25;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_26;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_27;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_28;
  wire       [17:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_29;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_30;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_31;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_32;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_33;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_34;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_35;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_36;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_37;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_38;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_39;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_40;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_41;
  wire       [13:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_42;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_43;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_44;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_45;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_46;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_47;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_48;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_49;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_50;
  wire       [9:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_51;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_52;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_53;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_54;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_55;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_56;
  wire       [6:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_57;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_58;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_59;
  wire       [3:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_60;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_61;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_62;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_63;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_64;
  wire                _zz__zz_decode_SRC_LESS_UNSIGNED_65;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_66;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_67;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_68;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_69;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_70;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_71;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_72;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_73;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_74;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_75;
  wire       [2:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_76;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_77;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_78;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_79;
  wire       [1:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_80;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_81;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_82;
  wire       [0:0]    _zz__zz_decode_SRC_LESS_UNSIGNED_83;
  wire       [31:0]   _zz__zz_decode_SRC_LESS_UNSIGNED_84;
  wire                _zz_RegFilePlugin_regFile_port;
  wire                _zz_decode_RegFilePlugin_rs1Data;
  wire                _zz_RegFilePlugin_regFile_port_1;
  wire                _zz_decode_RegFilePlugin_rs2Data;
  wire       [0:0]    _zz__zz_execute_REGFILE_WRITE_DATA;
  wire       [2:0]    _zz__zz_decode_SRC1;
  wire       [4:0]    _zz__zz_decode_SRC1_1;
  wire       [11:0]   _zz__zz_decode_SRC2_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_1;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_2;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_3;
  wire       [31:0]   _zz_execute_SrcPlugin_addSub_4;
  wire       [19:0]   _zz__zz_execute_BranchPlugin_branch_src2;
  wire       [11:0]   _zz__zz_execute_BranchPlugin_branch_src2_4;
  wire       [31:0]   memory_MEMORY_READ_DATA;
  wire       [31:0]   execute_BRANCH_CALC;
  wire                execute_BRANCH_DO;
  wire       [31:0]   execute_SHIFT_RIGHT;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [1:0]    memory_MEMORY_ADDRESS_LOW;
  wire       [1:0]    execute_MEMORY_ADDRESS_LOW;
  wire       [31:0]   decode_SRC2;
  wire       [31:0]   decode_SRC1;
  wire                decode_SRC2_FORCE_ZERO;
  wire       [1:0]    decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL;
  wire       [1:0]    _zz_decode_to_execute_BRANCH_CTRL_1;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_to_memory_SHIFT_CTRL_1;
  wire       [1:0]    decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL;
  wire       [1:0]    _zz_decode_to_execute_SHIFT_CTRL_1;
  wire       [1:0]    decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  wire                decode_SRC_LESS_UNSIGNED;
  wire       [1:0]    decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL;
  wire       [1:0]    _zz_decode_to_execute_ALU_CTRL_1;
  wire                decode_MEMORY_STORE;
  wire                decode_MEMORY_ENABLE;
  wire                decode_DOT_UNSIGNED_RS2;
  wire                decode_DOT_UNSIGNED_RS1;
  wire                decode_IS_DOT_INT4;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire                decode_INT4_UNSIGNED;
  wire       [1:0]    decode_INT4_OP;
  wire       [1:0]    _zz_decode_INT4_OP;
  wire       [1:0]    _zz_decode_to_execute_INT4_OP;
  wire       [1:0]    _zz_decode_to_execute_INT4_OP_1;
  wire                decode_IS_ALU_INT4;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire       [31:0]   memory_BRANCH_CALC;
  wire                memory_BRANCH_DO;
  wire       [31:0]   execute_PC;
  wire       [1:0]    execute_BRANCH_CTRL;
  wire       [1:0]    _zz_execute_BRANCH_CTRL;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire                memory_REGFILE_WRITE_VALID;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  reg        [31:0]   decode_RS2;
  reg        [31:0]   decode_RS1;
  wire       [31:0]   memory_SHIFT_RIGHT;
  reg        [31:0]   _zz_decode_RS2;
  wire       [1:0]    memory_SHIFT_CTRL;
  wire       [1:0]    _zz_memory_SHIFT_CTRL;
  wire       [1:0]    execute_SHIFT_CTRL;
  wire       [1:0]    _zz_execute_SHIFT_CTRL;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_decode_to_execute_PC;
  wire       [31:0]   _zz_decode_to_execute_RS2;
  wire       [1:0]    decode_SRC2_CTRL;
  wire       [1:0]    _zz_decode_SRC2_CTRL;
  wire       [31:0]   _zz_decode_to_execute_RS1;
  wire       [1:0]    decode_SRC1_CTRL;
  wire       [1:0]    _zz_decode_SRC1_CTRL;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       [1:0]    execute_ALU_CTRL;
  wire       [1:0]    _zz_execute_ALU_CTRL;
  wire       [31:0]   execute_SRC2;
  wire       [31:0]   execute_SRC1;
  wire       [1:0]    execute_ALU_BITWISE_CTRL;
  wire       [1:0]    _zz_execute_ALU_BITWISE_CTRL;
  wire       [31:0]   _zz_lastStageRegFileWrite_payload_address;
  wire                _zz_lastStageRegFileWrite_valid;
  reg                 _zz_1;
  wire       [31:0]   decode_INSTRUCTION_ANTICIPATED;
  reg                 decode_REGFILE_WRITE_VALID;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_1;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_1;
  wire       [1:0]    _zz_decode_ALU_CTRL_1;
  wire       [1:0]    _zz_decode_SRC2_CTRL_1;
  wire       [1:0]    _zz_decode_SRC1_CTRL_1;
  wire       [1:0]    _zz_decode_INT4_OP_1;
  reg        [31:0]   _zz_decode_RS2_1;
  wire                writeBack_MEMORY_ENABLE;
  wire       [1:0]    writeBack_MEMORY_ADDRESS_LOW;
  wire       [31:0]   writeBack_MEMORY_READ_DATA;
  wire                memory_MEMORY_STORE;
  wire                memory_MEMORY_ENABLE;
  wire       [31:0]   execute_SRC_ADD;
  wire       [31:0]   execute_INSTRUCTION;
  wire                execute_MEMORY_STORE;
  wire                execute_MEMORY_ENABLE;
  wire                execute_ALIGNEMENT_FAULT;
  wire       [31:0]   decode_PC;
  wire       [31:0]   decode_INSTRUCTION;
  wire                execute_IS_DOT_INT4;
  wire                execute_DOT_UNSIGNED_RS2;
  wire                execute_DOT_UNSIGNED_RS1;
  reg        [31:0]   _zz_decode_RS2_2;
  wire                execute_IS_ALU_INT4;
  wire       [1:0]    execute_INT4_OP;
  wire       [1:0]    _zz_execute_INT4_OP;
  wire                execute_INT4_UNSIGNED;
  wire       [31:0]   execute_RS2;
  wire       [31:0]   execute_RS1;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  wire                decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  wire                decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  wire                execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  wire                execute_arbitration_flushIt;
  wire                execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  reg                 memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  reg                 memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  wire                writeBack_arbitration_haltItself;
  wire                writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  wire                writeBack_arbitration_flushIt;
  wire                writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  wire                IBusSimplePlugin_fetcherHalt;
  wire                IBusSimplePlugin_forceNoDecodeCond;
  reg                 IBusSimplePlugin_incomingInstruction;
  wire                IBusSimplePlugin_pcValids_0;
  wire                IBusSimplePlugin_pcValids_1;
  wire                IBusSimplePlugin_pcValids_2;
  wire                IBusSimplePlugin_pcValids_3;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  wire                BranchPlugin_inDebugNoFetchFlag;
  wire       [31:0]   execute_SimdPlugin_rs1;
  wire       [31:0]   execute_SimdPlugin_rs2;
  reg        [31:0]   execute_SimdPlugin_rd;
  wire       [4:0]    execute_SimdPlugin_smax;
  wire       [4:0]    execute_SimdPlugin_smin;
  wire       [4:0]    execute_SimdPlugin_umax;
  wire       [4:0]    execute_SimdPlugin_uzero;
  wire       [3:0]    _zz_execute_SimdPlugin_rd;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_1;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_2;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_3;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_4;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_5;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_6;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_7;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_8;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_9;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_10;
  wire                when_SimdPlugin_l199;
  wire                when_SimdPlugin_l200;
  wire                when_SimdPlugin_l201;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_11;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_12;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_13;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_14;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_15;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_16;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_17;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_18;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_19;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_20;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_21;
  wire                when_SimdPlugin_l199_1;
  wire                when_SimdPlugin_l200_1;
  wire                when_SimdPlugin_l201_1;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_22;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_23;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_24;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_25;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_26;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_27;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_28;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_29;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_30;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_31;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_32;
  wire                when_SimdPlugin_l199_2;
  wire                when_SimdPlugin_l200_2;
  wire                when_SimdPlugin_l201_2;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_33;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_34;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_35;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_36;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_37;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_38;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_39;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_40;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_41;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_42;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_43;
  wire                when_SimdPlugin_l199_3;
  wire                when_SimdPlugin_l200_3;
  wire                when_SimdPlugin_l201_3;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_44;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_45;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_46;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_47;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_48;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_49;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_50;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_51;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_52;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_53;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_54;
  wire                when_SimdPlugin_l199_4;
  wire                when_SimdPlugin_l200_4;
  wire                when_SimdPlugin_l201_4;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_55;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_56;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_57;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_58;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_59;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_60;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_61;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_62;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_63;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_64;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_65;
  wire                when_SimdPlugin_l199_5;
  wire                when_SimdPlugin_l200_5;
  wire                when_SimdPlugin_l201_5;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_66;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_67;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_68;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_69;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_70;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_71;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_72;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_73;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_74;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_75;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_76;
  wire                when_SimdPlugin_l199_6;
  wire                when_SimdPlugin_l200_6;
  wire                when_SimdPlugin_l201_6;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_77;
  wire       [3:0]    _zz_execute_SimdPlugin_rd_78;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_79;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_80;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_81;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_82;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_83;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_84;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_85;
  wire       [4:0]    _zz_execute_SimdPlugin_rd_86;
  reg        [4:0]    _zz_execute_SimdPlugin_rd_87;
  wire                when_SimdPlugin_l199_7;
  wire                when_SimdPlugin_l200_7;
  wire                when_SimdPlugin_l201_7;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_0;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_0_1;
  wire       [31:0]   execute_SimdPlugin_prods_0;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_1;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_1_1;
  wire       [31:0]   execute_SimdPlugin_prods_1;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_2;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_2_1;
  wire       [31:0]   execute_SimdPlugin_prods_2;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_3;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_3_1;
  wire       [31:0]   execute_SimdPlugin_prods_3;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_4;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_4_1;
  wire       [31:0]   execute_SimdPlugin_prods_4;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_5;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_5_1;
  wire       [31:0]   execute_SimdPlugin_prods_5;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_6_1;
  wire       [31:0]   execute_SimdPlugin_prods_6;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_7;
  wire       [3:0]    _zz_execute_SimdPlugin_prods_7_1;
  wire       [31:0]   execute_SimdPlugin_prods_7;
  wire       [31:0]   execute_SimdPlugin_lvl0;
  wire       [31:0]   execute_SimdPlugin_lvl1;
  wire       [31:0]   execute_SimdPlugin_lvl2;
  wire       [31:0]   execute_SimdPlugin_lvl3;
  wire       [31:0]   execute_SimdPlugin_lvl4;
  wire       [31:0]   execute_SimdPlugin_lvl5;
  wire       [31:0]   execute_SimdPlugin_dotSum;
  wire                IBusSimplePlugin_externalFlush;
  wire                IBusSimplePlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusSimplePlugin_jump_pcLoad_payload;
  wire                IBusSimplePlugin_fetchPc_output_valid;
  wire                IBusSimplePlugin_fetchPc_output_ready;
  wire       [31:0]   IBusSimplePlugin_fetchPc_output_payload;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusSimplePlugin_fetchPc_correction;
  reg                 IBusSimplePlugin_fetchPc_correctionReg;
  wire                IBusSimplePlugin_fetchPc_output_fire;
  wire                IBusSimplePlugin_fetchPc_corrected;
  reg                 IBusSimplePlugin_fetchPc_pcRegPropagate;
  reg                 IBusSimplePlugin_fetchPc_booted;
  reg                 IBusSimplePlugin_fetchPc_inc;
  wire                when_Fetcher_l133;
  wire                when_Fetcher_l133_1;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pc;
  reg                 IBusSimplePlugin_fetchPc_flushed;
  wire                when_Fetcher_l160;
  wire                IBusSimplePlugin_iBusRsp_redoFetch;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_output_payload;
  reg                 IBusSimplePlugin_iBusRsp_stages_0_halt;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_halt;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_payload;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_payload;
  wire                IBusSimplePlugin_iBusRsp_flush;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_ready;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_ready;
  reg                 _zz_IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  reg                 IBusSimplePlugin_iBusRsp_readyForError;
  wire                IBusSimplePlugin_iBusRsp_output_valid;
  wire                IBusSimplePlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire                IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire                IBusSimplePlugin_injector_decodeInput_valid;
  wire                IBusSimplePlugin_injector_decodeInput_ready;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire                IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire                IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_valid;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  wire                when_Fetcher_l322;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_0;
  wire                when_Fetcher_l331;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_1;
  wire                when_Fetcher_l331_1;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_2;
  wire                when_Fetcher_l331_2;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_3;
  wire                when_Fetcher_l331_3;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_4;
  wire                when_Fetcher_l331_4;
  reg        [31:0]   IBusSimplePlugin_injector_formal_rawInDecode;
  wire                IBusSimplePlugin_cmd_valid;
  wire                IBusSimplePlugin_cmd_ready;
  wire       [31:0]   IBusSimplePlugin_cmd_payload_pc;
  wire                IBusSimplePlugin_pending_inc;
  wire                IBusSimplePlugin_pending_dec;
  reg        [2:0]    IBusSimplePlugin_pending_value;
  wire       [2:0]    IBusSimplePlugin_pending_next;
  wire                IBusSimplePlugin_cmdFork_canEmit;
  wire                when_IBusSimplePlugin_l306;
  wire                IBusSimplePlugin_cmd_fire;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  reg        [2:0]    IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire                iBus_rsp_toStream_valid;
  wire                iBus_rsp_toStream_ready;
  wire                iBus_rsp_toStream_payload_error;
  wire       [31:0]   iBus_rsp_toStream_payload_inst;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_flush;
  wire                io_pop_fire;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_pc;
  reg                 IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  wire                when_IBusSimplePlugin_l378;
  wire                IBusSimplePlugin_rspJoin_join_valid;
  wire                IBusSimplePlugin_rspJoin_join_ready;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_pc;
  wire                IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_join_payload_isRvc;
  wire                IBusSimplePlugin_rspJoin_exceptionDetected;
  wire                IBusSimplePlugin_rspJoin_join_fire;
  wire                _zz_IBusSimplePlugin_rspJoin_join_ready;
  wire                IBusSimplePlugin_rspJoin_join_haltWhen_valid;
  wire                IBusSimplePlugin_rspJoin_join_haltWhen_ready;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_haltWhen_payload_pc;
  wire                IBusSimplePlugin_rspJoin_join_haltWhen_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_haltWhen_payload_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_join_haltWhen_payload_isRvc;
  wire                _zz_dBus_cmd_valid;
  reg                 execute_DBusSimplePlugin_skipCmd;
  reg        [31:0]   _zz_dBus_cmd_payload_data;
  wire                when_DBusSimplePlugin_l435;
  reg        [3:0]    _zz_execute_DBusSimplePlugin_formalMask;
  wire       [3:0]    execute_DBusSimplePlugin_formalMask;
  wire                when_DBusSimplePlugin_l490;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspShifted;
  wire       [1:0]    switch_Misc_l245;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_1;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated_2;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_3;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspFormated;
  wire                when_DBusSimplePlugin_l566;
  wire       [29:0]   _zz_decode_SRC_LESS_UNSIGNED;
  wire                _zz_decode_SRC_LESS_UNSIGNED_1;
  wire                _zz_decode_SRC_LESS_UNSIGNED_2;
  wire                _zz_decode_SRC_LESS_UNSIGNED_3;
  wire                _zz_decode_SRC_LESS_UNSIGNED_4;
  wire                _zz_decode_SRC_LESS_UNSIGNED_5;
  wire                _zz_decode_SRC_LESS_UNSIGNED_6;
  wire       [1:0]    _zz_decode_INT4_OP_2;
  wire       [1:0]    _zz_decode_SRC1_CTRL_2;
  wire       [1:0]    _zz_decode_SRC2_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_CTRL_2;
  wire       [1:0]    _zz_decode_ALU_BITWISE_CTRL_2;
  wire       [1:0]    _zz_decode_SHIFT_CTRL_2;
  wire       [1:0]    _zz_decode_BRANCH_CTRL_2;
  wire                when_RegFilePlugin_l63;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  reg        [4:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  reg        [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_5;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_execute_REGFILE_WRITE_DATA;
  reg        [31:0]   _zz_decode_SRC1;
  wire                _zz_decode_SRC2;
  reg        [19:0]   _zz_decode_SRC2_1;
  wire                _zz_decode_SRC2_2;
  reg        [19:0]   _zz_decode_SRC2_3;
  reg        [31:0]   _zz_decode_SRC2_4;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  wire       [4:0]    execute_FullBarrelShifterPlugin_amplitude;
  reg        [31:0]   _zz_execute_FullBarrelShifterPlugin_reversed;
  wire       [31:0]   execute_FullBarrelShifterPlugin_reversed;
  reg        [31:0]   _zz_decode_RS2_3;
  reg                 HazardSimplePlugin_src0Hazard;
  reg                 HazardSimplePlugin_src1Hazard;
  wire                HazardSimplePlugin_writeBackWrites_valid;
  wire       [4:0]    HazardSimplePlugin_writeBackWrites_payload_address;
  wire       [31:0]   HazardSimplePlugin_writeBackWrites_payload_data;
  reg                 HazardSimplePlugin_writeBackBuffer_valid;
  reg        [4:0]    HazardSimplePlugin_writeBackBuffer_payload_address;
  reg        [31:0]   HazardSimplePlugin_writeBackBuffer_payload_data;
  wire                HazardSimplePlugin_addr0Match;
  wire                HazardSimplePlugin_addr1Match;
  wire                when_HazardSimplePlugin_l47;
  wire                when_HazardSimplePlugin_l48;
  wire                when_HazardSimplePlugin_l51;
  wire                when_HazardSimplePlugin_l45;
  wire                when_HazardSimplePlugin_l57;
  wire                when_HazardSimplePlugin_l58;
  wire                when_HazardSimplePlugin_l48_1;
  wire                when_HazardSimplePlugin_l51_1;
  wire                when_HazardSimplePlugin_l45_1;
  wire                when_HazardSimplePlugin_l57_1;
  wire                when_HazardSimplePlugin_l58_1;
  wire                when_HazardSimplePlugin_l48_2;
  wire                when_HazardSimplePlugin_l51_2;
  wire                when_HazardSimplePlugin_l45_2;
  wire                when_HazardSimplePlugin_l57_2;
  wire                when_HazardSimplePlugin_l58_2;
  wire                when_HazardSimplePlugin_l105;
  wire                when_HazardSimplePlugin_l108;
  wire                when_HazardSimplePlugin_l113;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    switch_Misc_l245_1;
  reg                 _zz_execute_BRANCH_DO;
  reg                 _zz_execute_BRANCH_DO_1;
  wire       [31:0]   execute_BranchPlugin_branch_src1;
  wire                _zz_execute_BranchPlugin_branch_src2;
  reg        [10:0]   _zz_execute_BranchPlugin_branch_src2_1;
  wire                _zz_execute_BranchPlugin_branch_src2_2;
  reg        [19:0]   _zz_execute_BranchPlugin_branch_src2_3;
  wire                _zz_execute_BranchPlugin_branch_src2_4;
  reg        [18:0]   _zz_execute_BranchPlugin_branch_src2_5;
  reg        [31:0]   _zz_execute_BranchPlugin_branch_src2_6;
  wire       [31:0]   execute_BranchPlugin_branch_src2;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  wire                when_Pipeline_l124;
  reg        [31:0]   decode_to_execute_PC;
  wire                when_Pipeline_l124_1;
  reg        [31:0]   execute_to_memory_PC;
  wire                when_Pipeline_l124_2;
  reg        [31:0]   memory_to_writeBack_PC;
  wire                when_Pipeline_l124_3;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  wire                when_Pipeline_l124_4;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  wire                when_Pipeline_l124_5;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  wire                when_Pipeline_l124_6;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_7;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_8;
  reg                 decode_to_execute_IS_ALU_INT4;
  wire                when_Pipeline_l124_9;
  reg        [1:0]    decode_to_execute_INT4_OP;
  wire                when_Pipeline_l124_10;
  reg                 decode_to_execute_INT4_UNSIGNED;
  wire                when_Pipeline_l124_11;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_12;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_13;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_14;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  wire                when_Pipeline_l124_15;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_16;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_17;
  reg                 decode_to_execute_IS_DOT_INT4;
  wire                when_Pipeline_l124_18;
  reg                 decode_to_execute_DOT_UNSIGNED_RS1;
  wire                when_Pipeline_l124_19;
  reg                 decode_to_execute_DOT_UNSIGNED_RS2;
  wire                when_Pipeline_l124_20;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  wire                when_Pipeline_l124_21;
  reg                 decode_to_execute_MEMORY_ENABLE;
  wire                when_Pipeline_l124_22;
  reg                 execute_to_memory_MEMORY_ENABLE;
  wire                when_Pipeline_l124_23;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  wire                when_Pipeline_l124_24;
  reg                 decode_to_execute_MEMORY_STORE;
  wire                when_Pipeline_l124_25;
  reg                 execute_to_memory_MEMORY_STORE;
  wire                when_Pipeline_l124_26;
  reg        [1:0]    decode_to_execute_ALU_CTRL;
  wire                when_Pipeline_l124_27;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  wire                when_Pipeline_l124_28;
  reg        [1:0]    decode_to_execute_ALU_BITWISE_CTRL;
  wire                when_Pipeline_l124_29;
  reg        [1:0]    decode_to_execute_SHIFT_CTRL;
  wire                when_Pipeline_l124_30;
  reg        [1:0]    execute_to_memory_SHIFT_CTRL;
  wire                when_Pipeline_l124_31;
  reg        [1:0]    decode_to_execute_BRANCH_CTRL;
  wire                when_Pipeline_l124_32;
  reg        [31:0]   decode_to_execute_RS1;
  wire                when_Pipeline_l124_33;
  reg        [31:0]   decode_to_execute_RS2;
  wire                when_Pipeline_l124_34;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  wire                when_Pipeline_l124_35;
  reg        [31:0]   decode_to_execute_SRC1;
  wire                when_Pipeline_l124_36;
  reg        [31:0]   decode_to_execute_SRC2;
  wire                when_Pipeline_l124_37;
  reg        [1:0]    execute_to_memory_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_38;
  reg        [1:0]    memory_to_writeBack_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_39;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_40;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_41;
  reg        [31:0]   execute_to_memory_SHIFT_RIGHT;
  wire                when_Pipeline_l124_42;
  reg                 execute_to_memory_BRANCH_DO;
  wire                when_Pipeline_l124_43;
  reg        [31:0]   execute_to_memory_BRANCH_CALC;
  wire                when_Pipeline_l124_44;
  reg        [31:0]   memory_to_writeBack_MEMORY_READ_DATA;
  wire                when_Pipeline_l151;
  wire                when_Pipeline_l154;
  wire                when_Pipeline_l151_1;
  wire                when_Pipeline_l154_1;
  wire                when_Pipeline_l151_2;
  wire                when_Pipeline_l154_2;
  `ifndef SYNTHESIS
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_1_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_to_memory_SHIFT_CTRL_1_string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] _zz_decode_to_execute_SHIFT_CTRL_1_string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_1_string;
  reg [23:0] decode_INT4_OP_string;
  reg [23:0] _zz_decode_INT4_OP_string;
  reg [23:0] _zz_decode_to_execute_INT4_OP_string;
  reg [23:0] _zz_decode_to_execute_INT4_OP_1_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_execute_BRANCH_CTRL_string;
  reg [71:0] memory_SHIFT_CTRL_string;
  reg [71:0] _zz_memory_SHIFT_CTRL_string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_execute_SHIFT_CTRL_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_SRC2_CTRL_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_SRC1_CTRL_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_execute_ALU_CTRL_string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_execute_ALU_BITWISE_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_1_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_1_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_1_string;
  reg [63:0] _zz_decode_ALU_CTRL_1_string;
  reg [23:0] _zz_decode_SRC2_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_1_string;
  reg [23:0] _zz_decode_INT4_OP_1_string;
  reg [23:0] execute_INT4_OP_string;
  reg [23:0] _zz_execute_INT4_OP_string;
  reg [23:0] _zz_decode_INT4_OP_2_string;
  reg [95:0] _zz_decode_SRC1_CTRL_2_string;
  reg [23:0] _zz_decode_SRC2_CTRL_2_string;
  reg [63:0] _zz_decode_ALU_CTRL_2_string;
  reg [39:0] _zz_decode_ALU_BITWISE_CTRL_2_string;
  reg [71:0] _zz_decode_SHIFT_CTRL_2_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_2_string;
  reg [23:0] decode_to_execute_INT4_OP_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [71:0] execute_to_memory_SHIFT_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;

  assign _zz_execute_SHIFT_RIGHT_1 = ($signed(_zz_execute_SHIFT_RIGHT_2) >>> execute_FullBarrelShifterPlugin_amplitude);
  assign _zz_execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT_1[31 : 0];
  assign _zz_execute_SHIFT_RIGHT_2 = {((execute_SHIFT_CTRL == ShiftCtrlEnum_SRA_1) && execute_FullBarrelShifterPlugin_reversed[31]),execute_FullBarrelShifterPlugin_reversed};
  assign _zz__zz_execute_SimdPlugin_rd_2 = _zz_execute_SimdPlugin_rd;
  assign _zz__zz_execute_SimdPlugin_rd_3 = _zz_execute_SimdPlugin_rd_1;
  assign _zz__zz_execute_SimdPlugin_rd_10_1 = _zz__zz_execute_SimdPlugin_rd_10_2;
  assign _zz__zz_execute_SimdPlugin_rd_10 = {1'd0, _zz__zz_execute_SimdPlugin_rd_10_1};
  assign _zz__zz_execute_SimdPlugin_rd_10_2 = _zz_execute_SimdPlugin_rd_7[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_10_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_1 < _zz_execute_SimdPlugin_rd) ? _zz_execute_SimdPlugin_rd : _zz_execute_SimdPlugin_rd_1) : (($signed(_zz__zz_execute_SimdPlugin_rd_10_4) < $signed(_zz__zz_execute_SimdPlugin_rd_10_5)) ? _zz_execute_SimdPlugin_rd : _zz_execute_SimdPlugin_rd_1));
  assign _zz__zz_execute_SimdPlugin_rd_10_4 = _zz_execute_SimdPlugin_rd_1;
  assign _zz__zz_execute_SimdPlugin_rd_10_5 = _zz_execute_SimdPlugin_rd;
  assign _zz__zz_execute_SimdPlugin_rd_10_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd < _zz_execute_SimdPlugin_rd_1) ? _zz_execute_SimdPlugin_rd : _zz_execute_SimdPlugin_rd_1) : (($signed(_zz__zz_execute_SimdPlugin_rd_10_7) < $signed(_zz__zz_execute_SimdPlugin_rd_10_8)) ? _zz_execute_SimdPlugin_rd : _zz_execute_SimdPlugin_rd_1));
  assign _zz__zz_execute_SimdPlugin_rd_10_7 = _zz_execute_SimdPlugin_rd;
  assign _zz__zz_execute_SimdPlugin_rd_10_8 = _zz_execute_SimdPlugin_rd_1;
  assign _zz__zz_execute_SimdPlugin_rd_13 = _zz_execute_SimdPlugin_rd_11;
  assign _zz__zz_execute_SimdPlugin_rd_14 = _zz_execute_SimdPlugin_rd_12;
  assign _zz__zz_execute_SimdPlugin_rd_21_1 = _zz__zz_execute_SimdPlugin_rd_21_2;
  assign _zz__zz_execute_SimdPlugin_rd_21 = {1'd0, _zz__zz_execute_SimdPlugin_rd_21_1};
  assign _zz__zz_execute_SimdPlugin_rd_21_2 = _zz_execute_SimdPlugin_rd_18[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_21_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_12 < _zz_execute_SimdPlugin_rd_11) ? _zz_execute_SimdPlugin_rd_11 : _zz_execute_SimdPlugin_rd_12) : (($signed(_zz__zz_execute_SimdPlugin_rd_21_4) < $signed(_zz__zz_execute_SimdPlugin_rd_21_5)) ? _zz_execute_SimdPlugin_rd_11 : _zz_execute_SimdPlugin_rd_12));
  assign _zz__zz_execute_SimdPlugin_rd_21_4 = _zz_execute_SimdPlugin_rd_12;
  assign _zz__zz_execute_SimdPlugin_rd_21_5 = _zz_execute_SimdPlugin_rd_11;
  assign _zz__zz_execute_SimdPlugin_rd_21_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_11 < _zz_execute_SimdPlugin_rd_12) ? _zz_execute_SimdPlugin_rd_11 : _zz_execute_SimdPlugin_rd_12) : (($signed(_zz__zz_execute_SimdPlugin_rd_21_7) < $signed(_zz__zz_execute_SimdPlugin_rd_21_8)) ? _zz_execute_SimdPlugin_rd_11 : _zz_execute_SimdPlugin_rd_12));
  assign _zz__zz_execute_SimdPlugin_rd_21_7 = _zz_execute_SimdPlugin_rd_11;
  assign _zz__zz_execute_SimdPlugin_rd_21_8 = _zz_execute_SimdPlugin_rd_12;
  assign _zz__zz_execute_SimdPlugin_rd_24 = _zz_execute_SimdPlugin_rd_22;
  assign _zz__zz_execute_SimdPlugin_rd_25 = _zz_execute_SimdPlugin_rd_23;
  assign _zz__zz_execute_SimdPlugin_rd_32_1 = _zz__zz_execute_SimdPlugin_rd_32_2;
  assign _zz__zz_execute_SimdPlugin_rd_32 = {1'd0, _zz__zz_execute_SimdPlugin_rd_32_1};
  assign _zz__zz_execute_SimdPlugin_rd_32_2 = _zz_execute_SimdPlugin_rd_29[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_32_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_23 < _zz_execute_SimdPlugin_rd_22) ? _zz_execute_SimdPlugin_rd_22 : _zz_execute_SimdPlugin_rd_23) : (($signed(_zz__zz_execute_SimdPlugin_rd_32_4) < $signed(_zz__zz_execute_SimdPlugin_rd_32_5)) ? _zz_execute_SimdPlugin_rd_22 : _zz_execute_SimdPlugin_rd_23));
  assign _zz__zz_execute_SimdPlugin_rd_32_4 = _zz_execute_SimdPlugin_rd_23;
  assign _zz__zz_execute_SimdPlugin_rd_32_5 = _zz_execute_SimdPlugin_rd_22;
  assign _zz__zz_execute_SimdPlugin_rd_32_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_22 < _zz_execute_SimdPlugin_rd_23) ? _zz_execute_SimdPlugin_rd_22 : _zz_execute_SimdPlugin_rd_23) : (($signed(_zz__zz_execute_SimdPlugin_rd_32_7) < $signed(_zz__zz_execute_SimdPlugin_rd_32_8)) ? _zz_execute_SimdPlugin_rd_22 : _zz_execute_SimdPlugin_rd_23));
  assign _zz__zz_execute_SimdPlugin_rd_32_7 = _zz_execute_SimdPlugin_rd_22;
  assign _zz__zz_execute_SimdPlugin_rd_32_8 = _zz_execute_SimdPlugin_rd_23;
  assign _zz__zz_execute_SimdPlugin_rd_35 = _zz_execute_SimdPlugin_rd_33;
  assign _zz__zz_execute_SimdPlugin_rd_36 = _zz_execute_SimdPlugin_rd_34;
  assign _zz__zz_execute_SimdPlugin_rd_43_1 = _zz__zz_execute_SimdPlugin_rd_43_2;
  assign _zz__zz_execute_SimdPlugin_rd_43 = {1'd0, _zz__zz_execute_SimdPlugin_rd_43_1};
  assign _zz__zz_execute_SimdPlugin_rd_43_2 = _zz_execute_SimdPlugin_rd_40[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_43_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_34 < _zz_execute_SimdPlugin_rd_33) ? _zz_execute_SimdPlugin_rd_33 : _zz_execute_SimdPlugin_rd_34) : (($signed(_zz__zz_execute_SimdPlugin_rd_43_4) < $signed(_zz__zz_execute_SimdPlugin_rd_43_5)) ? _zz_execute_SimdPlugin_rd_33 : _zz_execute_SimdPlugin_rd_34));
  assign _zz__zz_execute_SimdPlugin_rd_43_4 = _zz_execute_SimdPlugin_rd_34;
  assign _zz__zz_execute_SimdPlugin_rd_43_5 = _zz_execute_SimdPlugin_rd_33;
  assign _zz__zz_execute_SimdPlugin_rd_43_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_33 < _zz_execute_SimdPlugin_rd_34) ? _zz_execute_SimdPlugin_rd_33 : _zz_execute_SimdPlugin_rd_34) : (($signed(_zz__zz_execute_SimdPlugin_rd_43_7) < $signed(_zz__zz_execute_SimdPlugin_rd_43_8)) ? _zz_execute_SimdPlugin_rd_33 : _zz_execute_SimdPlugin_rd_34));
  assign _zz__zz_execute_SimdPlugin_rd_43_7 = _zz_execute_SimdPlugin_rd_33;
  assign _zz__zz_execute_SimdPlugin_rd_43_8 = _zz_execute_SimdPlugin_rd_34;
  assign _zz__zz_execute_SimdPlugin_rd_46 = _zz_execute_SimdPlugin_rd_44;
  assign _zz__zz_execute_SimdPlugin_rd_47 = _zz_execute_SimdPlugin_rd_45;
  assign _zz__zz_execute_SimdPlugin_rd_54_1 = _zz__zz_execute_SimdPlugin_rd_54_2;
  assign _zz__zz_execute_SimdPlugin_rd_54 = {1'd0, _zz__zz_execute_SimdPlugin_rd_54_1};
  assign _zz__zz_execute_SimdPlugin_rd_54_2 = _zz_execute_SimdPlugin_rd_51[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_54_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_45 < _zz_execute_SimdPlugin_rd_44) ? _zz_execute_SimdPlugin_rd_44 : _zz_execute_SimdPlugin_rd_45) : (($signed(_zz__zz_execute_SimdPlugin_rd_54_4) < $signed(_zz__zz_execute_SimdPlugin_rd_54_5)) ? _zz_execute_SimdPlugin_rd_44 : _zz_execute_SimdPlugin_rd_45));
  assign _zz__zz_execute_SimdPlugin_rd_54_4 = _zz_execute_SimdPlugin_rd_45;
  assign _zz__zz_execute_SimdPlugin_rd_54_5 = _zz_execute_SimdPlugin_rd_44;
  assign _zz__zz_execute_SimdPlugin_rd_54_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_44 < _zz_execute_SimdPlugin_rd_45) ? _zz_execute_SimdPlugin_rd_44 : _zz_execute_SimdPlugin_rd_45) : (($signed(_zz__zz_execute_SimdPlugin_rd_54_7) < $signed(_zz__zz_execute_SimdPlugin_rd_54_8)) ? _zz_execute_SimdPlugin_rd_44 : _zz_execute_SimdPlugin_rd_45));
  assign _zz__zz_execute_SimdPlugin_rd_54_7 = _zz_execute_SimdPlugin_rd_44;
  assign _zz__zz_execute_SimdPlugin_rd_54_8 = _zz_execute_SimdPlugin_rd_45;
  assign _zz__zz_execute_SimdPlugin_rd_57 = _zz_execute_SimdPlugin_rd_55;
  assign _zz__zz_execute_SimdPlugin_rd_58 = _zz_execute_SimdPlugin_rd_56;
  assign _zz__zz_execute_SimdPlugin_rd_65_1 = _zz__zz_execute_SimdPlugin_rd_65_2;
  assign _zz__zz_execute_SimdPlugin_rd_65 = {1'd0, _zz__zz_execute_SimdPlugin_rd_65_1};
  assign _zz__zz_execute_SimdPlugin_rd_65_2 = _zz_execute_SimdPlugin_rd_62[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_65_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_56 < _zz_execute_SimdPlugin_rd_55) ? _zz_execute_SimdPlugin_rd_55 : _zz_execute_SimdPlugin_rd_56) : (($signed(_zz__zz_execute_SimdPlugin_rd_65_4) < $signed(_zz__zz_execute_SimdPlugin_rd_65_5)) ? _zz_execute_SimdPlugin_rd_55 : _zz_execute_SimdPlugin_rd_56));
  assign _zz__zz_execute_SimdPlugin_rd_65_4 = _zz_execute_SimdPlugin_rd_56;
  assign _zz__zz_execute_SimdPlugin_rd_65_5 = _zz_execute_SimdPlugin_rd_55;
  assign _zz__zz_execute_SimdPlugin_rd_65_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_55 < _zz_execute_SimdPlugin_rd_56) ? _zz_execute_SimdPlugin_rd_55 : _zz_execute_SimdPlugin_rd_56) : (($signed(_zz__zz_execute_SimdPlugin_rd_65_7) < $signed(_zz__zz_execute_SimdPlugin_rd_65_8)) ? _zz_execute_SimdPlugin_rd_55 : _zz_execute_SimdPlugin_rd_56));
  assign _zz__zz_execute_SimdPlugin_rd_65_7 = _zz_execute_SimdPlugin_rd_55;
  assign _zz__zz_execute_SimdPlugin_rd_65_8 = _zz_execute_SimdPlugin_rd_56;
  assign _zz__zz_execute_SimdPlugin_rd_68 = _zz_execute_SimdPlugin_rd_66;
  assign _zz__zz_execute_SimdPlugin_rd_69 = _zz_execute_SimdPlugin_rd_67;
  assign _zz__zz_execute_SimdPlugin_rd_76_1 = _zz__zz_execute_SimdPlugin_rd_76_2;
  assign _zz__zz_execute_SimdPlugin_rd_76 = {1'd0, _zz__zz_execute_SimdPlugin_rd_76_1};
  assign _zz__zz_execute_SimdPlugin_rd_76_2 = _zz_execute_SimdPlugin_rd_73[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_76_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_67 < _zz_execute_SimdPlugin_rd_66) ? _zz_execute_SimdPlugin_rd_66 : _zz_execute_SimdPlugin_rd_67) : (($signed(_zz__zz_execute_SimdPlugin_rd_76_4) < $signed(_zz__zz_execute_SimdPlugin_rd_76_5)) ? _zz_execute_SimdPlugin_rd_66 : _zz_execute_SimdPlugin_rd_67));
  assign _zz__zz_execute_SimdPlugin_rd_76_4 = _zz_execute_SimdPlugin_rd_67;
  assign _zz__zz_execute_SimdPlugin_rd_76_5 = _zz_execute_SimdPlugin_rd_66;
  assign _zz__zz_execute_SimdPlugin_rd_76_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_66 < _zz_execute_SimdPlugin_rd_67) ? _zz_execute_SimdPlugin_rd_66 : _zz_execute_SimdPlugin_rd_67) : (($signed(_zz__zz_execute_SimdPlugin_rd_76_7) < $signed(_zz__zz_execute_SimdPlugin_rd_76_8)) ? _zz_execute_SimdPlugin_rd_66 : _zz_execute_SimdPlugin_rd_67));
  assign _zz__zz_execute_SimdPlugin_rd_76_7 = _zz_execute_SimdPlugin_rd_66;
  assign _zz__zz_execute_SimdPlugin_rd_76_8 = _zz_execute_SimdPlugin_rd_67;
  assign _zz__zz_execute_SimdPlugin_rd_79 = _zz_execute_SimdPlugin_rd_77;
  assign _zz__zz_execute_SimdPlugin_rd_80 = _zz_execute_SimdPlugin_rd_78;
  assign _zz__zz_execute_SimdPlugin_rd_87_1 = _zz__zz_execute_SimdPlugin_rd_87_2;
  assign _zz__zz_execute_SimdPlugin_rd_87 = {1'd0, _zz__zz_execute_SimdPlugin_rd_87_1};
  assign _zz__zz_execute_SimdPlugin_rd_87_2 = _zz_execute_SimdPlugin_rd_84[3 : 0];
  assign _zz__zz_execute_SimdPlugin_rd_87_3 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_78 < _zz_execute_SimdPlugin_rd_77) ? _zz_execute_SimdPlugin_rd_77 : _zz_execute_SimdPlugin_rd_78) : (($signed(_zz__zz_execute_SimdPlugin_rd_87_4) < $signed(_zz__zz_execute_SimdPlugin_rd_87_5)) ? _zz_execute_SimdPlugin_rd_77 : _zz_execute_SimdPlugin_rd_78));
  assign _zz__zz_execute_SimdPlugin_rd_87_4 = _zz_execute_SimdPlugin_rd_78;
  assign _zz__zz_execute_SimdPlugin_rd_87_5 = _zz_execute_SimdPlugin_rd_77;
  assign _zz__zz_execute_SimdPlugin_rd_87_6 = (execute_INT4_UNSIGNED ? ((_zz_execute_SimdPlugin_rd_77 < _zz_execute_SimdPlugin_rd_78) ? _zz_execute_SimdPlugin_rd_77 : _zz_execute_SimdPlugin_rd_78) : (($signed(_zz__zz_execute_SimdPlugin_rd_87_7) < $signed(_zz__zz_execute_SimdPlugin_rd_87_8)) ? _zz_execute_SimdPlugin_rd_77 : _zz_execute_SimdPlugin_rd_78));
  assign _zz__zz_execute_SimdPlugin_rd_87_7 = _zz_execute_SimdPlugin_rd_77;
  assign _zz__zz_execute_SimdPlugin_rd_87_8 = _zz_execute_SimdPlugin_rd_78;
  assign _zz_execute_SimdPlugin_prods_0_2 = ($signed(_zz_execute_SimdPlugin_prods_0_3) * $signed(_zz_execute_SimdPlugin_prods_0_8));
  assign _zz_execute_SimdPlugin_prods_0_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_0_4 : _zz_execute_SimdPlugin_prods_0_6);
  assign _zz_execute_SimdPlugin_prods_0_4 = _zz_execute_SimdPlugin_prods_0_5;
  assign _zz_execute_SimdPlugin_prods_0_5 = {4'd0, _zz_execute_SimdPlugin_prods_0};
  assign _zz_execute_SimdPlugin_prods_0_7 = _zz_execute_SimdPlugin_prods_0;
  assign _zz_execute_SimdPlugin_prods_0_6 = {{4{_zz_execute_SimdPlugin_prods_0_7[3]}}, _zz_execute_SimdPlugin_prods_0_7};
  assign _zz_execute_SimdPlugin_prods_0_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_0_9 : _zz_execute_SimdPlugin_prods_0_11);
  assign _zz_execute_SimdPlugin_prods_0_9 = _zz_execute_SimdPlugin_prods_0_10;
  assign _zz_execute_SimdPlugin_prods_0_10 = {4'd0, _zz_execute_SimdPlugin_prods_0_1};
  assign _zz_execute_SimdPlugin_prods_0_12 = _zz_execute_SimdPlugin_prods_0_1;
  assign _zz_execute_SimdPlugin_prods_0_11 = {{4{_zz_execute_SimdPlugin_prods_0_12[3]}}, _zz_execute_SimdPlugin_prods_0_12};
  assign _zz_execute_SimdPlugin_prods_1_2 = ($signed(_zz_execute_SimdPlugin_prods_1_3) * $signed(_zz_execute_SimdPlugin_prods_1_8));
  assign _zz_execute_SimdPlugin_prods_1_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_1_4 : _zz_execute_SimdPlugin_prods_1_6);
  assign _zz_execute_SimdPlugin_prods_1_4 = _zz_execute_SimdPlugin_prods_1_5;
  assign _zz_execute_SimdPlugin_prods_1_5 = {4'd0, _zz_execute_SimdPlugin_prods_1};
  assign _zz_execute_SimdPlugin_prods_1_7 = _zz_execute_SimdPlugin_prods_1;
  assign _zz_execute_SimdPlugin_prods_1_6 = {{4{_zz_execute_SimdPlugin_prods_1_7[3]}}, _zz_execute_SimdPlugin_prods_1_7};
  assign _zz_execute_SimdPlugin_prods_1_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_1_9 : _zz_execute_SimdPlugin_prods_1_11);
  assign _zz_execute_SimdPlugin_prods_1_9 = _zz_execute_SimdPlugin_prods_1_10;
  assign _zz_execute_SimdPlugin_prods_1_10 = {4'd0, _zz_execute_SimdPlugin_prods_1_1};
  assign _zz_execute_SimdPlugin_prods_1_12 = _zz_execute_SimdPlugin_prods_1_1;
  assign _zz_execute_SimdPlugin_prods_1_11 = {{4{_zz_execute_SimdPlugin_prods_1_12[3]}}, _zz_execute_SimdPlugin_prods_1_12};
  assign _zz_execute_SimdPlugin_prods_2_2 = ($signed(_zz_execute_SimdPlugin_prods_2_3) * $signed(_zz_execute_SimdPlugin_prods_2_8));
  assign _zz_execute_SimdPlugin_prods_2_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_2_4 : _zz_execute_SimdPlugin_prods_2_6);
  assign _zz_execute_SimdPlugin_prods_2_4 = _zz_execute_SimdPlugin_prods_2_5;
  assign _zz_execute_SimdPlugin_prods_2_5 = {4'd0, _zz_execute_SimdPlugin_prods_2};
  assign _zz_execute_SimdPlugin_prods_2_7 = _zz_execute_SimdPlugin_prods_2;
  assign _zz_execute_SimdPlugin_prods_2_6 = {{4{_zz_execute_SimdPlugin_prods_2_7[3]}}, _zz_execute_SimdPlugin_prods_2_7};
  assign _zz_execute_SimdPlugin_prods_2_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_2_9 : _zz_execute_SimdPlugin_prods_2_11);
  assign _zz_execute_SimdPlugin_prods_2_9 = _zz_execute_SimdPlugin_prods_2_10;
  assign _zz_execute_SimdPlugin_prods_2_10 = {4'd0, _zz_execute_SimdPlugin_prods_2_1};
  assign _zz_execute_SimdPlugin_prods_2_12 = _zz_execute_SimdPlugin_prods_2_1;
  assign _zz_execute_SimdPlugin_prods_2_11 = {{4{_zz_execute_SimdPlugin_prods_2_12[3]}}, _zz_execute_SimdPlugin_prods_2_12};
  assign _zz_execute_SimdPlugin_prods_3_2 = ($signed(_zz_execute_SimdPlugin_prods_3_3) * $signed(_zz_execute_SimdPlugin_prods_3_8));
  assign _zz_execute_SimdPlugin_prods_3_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_3_4 : _zz_execute_SimdPlugin_prods_3_6);
  assign _zz_execute_SimdPlugin_prods_3_4 = _zz_execute_SimdPlugin_prods_3_5;
  assign _zz_execute_SimdPlugin_prods_3_5 = {4'd0, _zz_execute_SimdPlugin_prods_3};
  assign _zz_execute_SimdPlugin_prods_3_7 = _zz_execute_SimdPlugin_prods_3;
  assign _zz_execute_SimdPlugin_prods_3_6 = {{4{_zz_execute_SimdPlugin_prods_3_7[3]}}, _zz_execute_SimdPlugin_prods_3_7};
  assign _zz_execute_SimdPlugin_prods_3_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_3_9 : _zz_execute_SimdPlugin_prods_3_11);
  assign _zz_execute_SimdPlugin_prods_3_9 = _zz_execute_SimdPlugin_prods_3_10;
  assign _zz_execute_SimdPlugin_prods_3_10 = {4'd0, _zz_execute_SimdPlugin_prods_3_1};
  assign _zz_execute_SimdPlugin_prods_3_12 = _zz_execute_SimdPlugin_prods_3_1;
  assign _zz_execute_SimdPlugin_prods_3_11 = {{4{_zz_execute_SimdPlugin_prods_3_12[3]}}, _zz_execute_SimdPlugin_prods_3_12};
  assign _zz_execute_SimdPlugin_prods_4_2 = ($signed(_zz_execute_SimdPlugin_prods_4_3) * $signed(_zz_execute_SimdPlugin_prods_4_8));
  assign _zz_execute_SimdPlugin_prods_4_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_4_4 : _zz_execute_SimdPlugin_prods_4_6);
  assign _zz_execute_SimdPlugin_prods_4_4 = _zz_execute_SimdPlugin_prods_4_5;
  assign _zz_execute_SimdPlugin_prods_4_5 = {4'd0, _zz_execute_SimdPlugin_prods_4};
  assign _zz_execute_SimdPlugin_prods_4_7 = _zz_execute_SimdPlugin_prods_4;
  assign _zz_execute_SimdPlugin_prods_4_6 = {{4{_zz_execute_SimdPlugin_prods_4_7[3]}}, _zz_execute_SimdPlugin_prods_4_7};
  assign _zz_execute_SimdPlugin_prods_4_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_4_9 : _zz_execute_SimdPlugin_prods_4_11);
  assign _zz_execute_SimdPlugin_prods_4_9 = _zz_execute_SimdPlugin_prods_4_10;
  assign _zz_execute_SimdPlugin_prods_4_10 = {4'd0, _zz_execute_SimdPlugin_prods_4_1};
  assign _zz_execute_SimdPlugin_prods_4_12 = _zz_execute_SimdPlugin_prods_4_1;
  assign _zz_execute_SimdPlugin_prods_4_11 = {{4{_zz_execute_SimdPlugin_prods_4_12[3]}}, _zz_execute_SimdPlugin_prods_4_12};
  assign _zz_execute_SimdPlugin_prods_5_2 = ($signed(_zz_execute_SimdPlugin_prods_5_3) * $signed(_zz_execute_SimdPlugin_prods_5_8));
  assign _zz_execute_SimdPlugin_prods_5_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_5_4 : _zz_execute_SimdPlugin_prods_5_6);
  assign _zz_execute_SimdPlugin_prods_5_4 = _zz_execute_SimdPlugin_prods_5_5;
  assign _zz_execute_SimdPlugin_prods_5_5 = {4'd0, _zz_execute_SimdPlugin_prods_5};
  assign _zz_execute_SimdPlugin_prods_5_7 = _zz_execute_SimdPlugin_prods_5;
  assign _zz_execute_SimdPlugin_prods_5_6 = {{4{_zz_execute_SimdPlugin_prods_5_7[3]}}, _zz_execute_SimdPlugin_prods_5_7};
  assign _zz_execute_SimdPlugin_prods_5_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_5_9 : _zz_execute_SimdPlugin_prods_5_11);
  assign _zz_execute_SimdPlugin_prods_5_9 = _zz_execute_SimdPlugin_prods_5_10;
  assign _zz_execute_SimdPlugin_prods_5_10 = {4'd0, _zz_execute_SimdPlugin_prods_5_1};
  assign _zz_execute_SimdPlugin_prods_5_12 = _zz_execute_SimdPlugin_prods_5_1;
  assign _zz_execute_SimdPlugin_prods_5_11 = {{4{_zz_execute_SimdPlugin_prods_5_12[3]}}, _zz_execute_SimdPlugin_prods_5_12};
  assign _zz_execute_SimdPlugin_prods_6_2 = ($signed(_zz_execute_SimdPlugin_prods_6_3) * $signed(_zz_execute_SimdPlugin_prods_6_8));
  assign _zz_execute_SimdPlugin_prods_6_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_6_4 : _zz_execute_SimdPlugin_prods_6_6);
  assign _zz_execute_SimdPlugin_prods_6_4 = _zz_execute_SimdPlugin_prods_6_5;
  assign _zz_execute_SimdPlugin_prods_6_5 = {4'd0, _zz_execute_SimdPlugin_prods_6};
  assign _zz_execute_SimdPlugin_prods_6_7 = _zz_execute_SimdPlugin_prods_6;
  assign _zz_execute_SimdPlugin_prods_6_6 = {{4{_zz_execute_SimdPlugin_prods_6_7[3]}}, _zz_execute_SimdPlugin_prods_6_7};
  assign _zz_execute_SimdPlugin_prods_6_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_6_9 : _zz_execute_SimdPlugin_prods_6_11);
  assign _zz_execute_SimdPlugin_prods_6_9 = _zz_execute_SimdPlugin_prods_6_10;
  assign _zz_execute_SimdPlugin_prods_6_10 = {4'd0, _zz_execute_SimdPlugin_prods_6_1};
  assign _zz_execute_SimdPlugin_prods_6_12 = _zz_execute_SimdPlugin_prods_6_1;
  assign _zz_execute_SimdPlugin_prods_6_11 = {{4{_zz_execute_SimdPlugin_prods_6_12[3]}}, _zz_execute_SimdPlugin_prods_6_12};
  assign _zz_execute_SimdPlugin_prods_7_2 = ($signed(_zz_execute_SimdPlugin_prods_7_3) * $signed(_zz_execute_SimdPlugin_prods_7_8));
  assign _zz_execute_SimdPlugin_prods_7_3 = (execute_DOT_UNSIGNED_RS1 ? _zz_execute_SimdPlugin_prods_7_4 : _zz_execute_SimdPlugin_prods_7_6);
  assign _zz_execute_SimdPlugin_prods_7_4 = _zz_execute_SimdPlugin_prods_7_5;
  assign _zz_execute_SimdPlugin_prods_7_5 = {4'd0, _zz_execute_SimdPlugin_prods_7};
  assign _zz_execute_SimdPlugin_prods_7_7 = _zz_execute_SimdPlugin_prods_7;
  assign _zz_execute_SimdPlugin_prods_7_6 = {{4{_zz_execute_SimdPlugin_prods_7_7[3]}}, _zz_execute_SimdPlugin_prods_7_7};
  assign _zz_execute_SimdPlugin_prods_7_8 = (execute_DOT_UNSIGNED_RS2 ? _zz_execute_SimdPlugin_prods_7_9 : _zz_execute_SimdPlugin_prods_7_11);
  assign _zz_execute_SimdPlugin_prods_7_9 = _zz_execute_SimdPlugin_prods_7_10;
  assign _zz_execute_SimdPlugin_prods_7_10 = {4'd0, _zz_execute_SimdPlugin_prods_7_1};
  assign _zz_execute_SimdPlugin_prods_7_12 = _zz_execute_SimdPlugin_prods_7_1;
  assign _zz_execute_SimdPlugin_prods_7_11 = {{4{_zz_execute_SimdPlugin_prods_7_12[3]}}, _zz_execute_SimdPlugin_prods_7_12};
  assign _zz_IBusSimplePlugin_fetchPc_pc_1 = {IBusSimplePlugin_fetchPc_inc,2'b00};
  assign _zz_IBusSimplePlugin_fetchPc_pc = {29'd0, _zz_IBusSimplePlugin_fetchPc_pc_1};
  assign _zz_IBusSimplePlugin_pending_next = (IBusSimplePlugin_pending_value + _zz_IBusSimplePlugin_pending_next_1);
  assign _zz_IBusSimplePlugin_pending_next_2 = IBusSimplePlugin_pending_inc;
  assign _zz_IBusSimplePlugin_pending_next_1 = {2'd0, _zz_IBusSimplePlugin_pending_next_2};
  assign _zz_IBusSimplePlugin_pending_next_4 = IBusSimplePlugin_pending_dec;
  assign _zz_IBusSimplePlugin_pending_next_3 = {2'd0, _zz_IBusSimplePlugin_pending_next_4};
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1 = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000));
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter = {2'd0, _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1};
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3 = IBusSimplePlugin_pending_dec;
  assign _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2 = {2'd0, _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3};
  assign _zz__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
  assign _zz__zz_decode_SRC1 = 3'b100;
  assign _zz__zz_decode_SRC1_1 = decode_INSTRUCTION[19 : 15];
  assign _zz__zz_decode_SRC2_2 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _zz_execute_SrcPlugin_addSub = ($signed(_zz_execute_SrcPlugin_addSub_1) + $signed(_zz_execute_SrcPlugin_addSub_4));
  assign _zz_execute_SrcPlugin_addSub_1 = ($signed(_zz_execute_SrcPlugin_addSub_2) + $signed(_zz_execute_SrcPlugin_addSub_3));
  assign _zz_execute_SrcPlugin_addSub_2 = execute_SRC1;
  assign _zz_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? 32'h00000001 : 32'h0);
  assign _zz__zz_execute_BranchPlugin_branch_src2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz__zz_execute_BranchPlugin_branch_src2_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_decode_RegFilePlugin_rs1Data = 1'b1;
  assign _zz_decode_RegFilePlugin_rs2Data = 1'b1;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED = (decode_INSTRUCTION & 32'h0000001c);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_1 = 32'h00000004;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_2 = (decode_INSTRUCTION & 32'h00000048);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_3 = 32'h00000040;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_4 = ((decode_INSTRUCTION & 32'h00007014) == 32'h00005010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_5 = {(_zz__zz_decode_SRC_LESS_UNSIGNED_6 == _zz__zz_decode_SRC_LESS_UNSIGNED_7),(_zz__zz_decode_SRC_LESS_UNSIGNED_8 == _zz__zz_decode_SRC_LESS_UNSIGNED_9)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_10 = (|(_zz__zz_decode_SRC_LESS_UNSIGNED_11 == _zz__zz_decode_SRC_LESS_UNSIGNED_12));
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_13 = (|_zz__zz_decode_SRC_LESS_UNSIGNED_14);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_15 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_16),{_zz__zz_decode_SRC_LESS_UNSIGNED_18,{_zz__zz_decode_SRC_LESS_UNSIGNED_21,_zz__zz_decode_SRC_LESS_UNSIGNED_23}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_6 = (decode_INSTRUCTION & 32'h40003014);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_7 = 32'h40001010;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_8 = (decode_INSTRUCTION & 32'h00007014);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_9 = 32'h00001010;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_11 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_12 = 32'h00000024;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_14 = ((decode_INSTRUCTION & 32'h00001000) == 32'h00001000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_16 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_17) == 32'h00002000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_18 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_19,_zz__zz_decode_SRC_LESS_UNSIGNED_20});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_21 = (|_zz__zz_decode_SRC_LESS_UNSIGNED_22);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_23 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_24),{_zz__zz_decode_SRC_LESS_UNSIGNED_25,{_zz__zz_decode_SRC_LESS_UNSIGNED_28,_zz__zz_decode_SRC_LESS_UNSIGNED_29}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_17 = 32'h00003000;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_19 = ((decode_INSTRUCTION & 32'h00002010) == 32'h00002000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_20 = ((decode_INSTRUCTION & 32'h00005000) == 32'h00001000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_22 = ((decode_INSTRUCTION & 32'h00004004) == 32'h00004000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_24 = ((decode_INSTRUCTION & 32'h00006004) == 32'h00002000);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_25 = (|{(_zz__zz_decode_SRC_LESS_UNSIGNED_26 == _zz__zz_decode_SRC_LESS_UNSIGNED_27),_zz_decode_SRC_LESS_UNSIGNED_6});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_28 = (|_zz_decode_SRC_LESS_UNSIGNED_5);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_29 = {(|{_zz__zz_decode_SRC_LESS_UNSIGNED_30,_zz__zz_decode_SRC_LESS_UNSIGNED_31}),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_32),{_zz__zz_decode_SRC_LESS_UNSIGNED_34,{_zz__zz_decode_SRC_LESS_UNSIGNED_36,_zz__zz_decode_SRC_LESS_UNSIGNED_42}}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_26 = (decode_INSTRUCTION & 32'h00000040);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_27 = 32'h00000040;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_30 = _zz_decode_SRC_LESS_UNSIGNED_4;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_31 = ((decode_INSTRUCTION & 32'h00000070) == 32'h00000020);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_32 = {_zz_decode_SRC_LESS_UNSIGNED_4,((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_33) == 32'h0)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_34 = (|((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_35) == 32'h0));
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_36 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_37,{_zz__zz_decode_SRC_LESS_UNSIGNED_38,_zz__zz_decode_SRC_LESS_UNSIGNED_40}});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_42 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_43),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_44),{_zz__zz_decode_SRC_LESS_UNSIGNED_46,{_zz__zz_decode_SRC_LESS_UNSIGNED_49,_zz__zz_decode_SRC_LESS_UNSIGNED_51}}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_33 = 32'h00000020;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_35 = 32'h00000058;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_37 = ((decode_INSTRUCTION & 32'h00000044) == 32'h00000040);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_38 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_39) == 32'h00002010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_40 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_41) == 32'h40000030);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_43 = ((decode_INSTRUCTION & 32'h00000014) == 32'h00000004);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_44 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_45) == 32'h00000004);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_46 = (|(_zz__zz_decode_SRC_LESS_UNSIGNED_47 == _zz__zz_decode_SRC_LESS_UNSIGNED_48));
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_49 = (|_zz__zz_decode_SRC_LESS_UNSIGNED_50);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_51 = {(|_zz__zz_decode_SRC_LESS_UNSIGNED_52),{_zz__zz_decode_SRC_LESS_UNSIGNED_53,{_zz__zz_decode_SRC_LESS_UNSIGNED_55,_zz__zz_decode_SRC_LESS_UNSIGNED_57}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_39 = 32'h00002014;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_41 = 32'h40000034;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_45 = 32'h00000044;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_47 = (decode_INSTRUCTION & 32'h2400000c);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_48 = 32'h20000008;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_50 = ((decode_INSTRUCTION & 32'h2600000c) == 32'h20000008);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_52 = ((decode_INSTRUCTION & 32'h2000000c) == 32'h20000008);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_53 = (|((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_54) == 32'h00000020));
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_55 = (|{_zz__zz_decode_SRC_LESS_UNSIGNED_56,_zz_decode_SRC_LESS_UNSIGNED_6});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_57 = {(|{_zz__zz_decode_SRC_LESS_UNSIGNED_58,_zz__zz_decode_SRC_LESS_UNSIGNED_59}),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_60),{_zz__zz_decode_SRC_LESS_UNSIGNED_65,{_zz__zz_decode_SRC_LESS_UNSIGNED_73,_zz__zz_decode_SRC_LESS_UNSIGNED_76}}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_54 = 32'h00000024;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_56 = ((decode_INSTRUCTION & 32'h00000004) == 32'h0);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_58 = _zz_decode_SRC_LESS_UNSIGNED_3;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_59 = _zz_decode_SRC_LESS_UNSIGNED_5;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_60 = {_zz_decode_SRC_LESS_UNSIGNED_4,{(_zz__zz_decode_SRC_LESS_UNSIGNED_61 == _zz__zz_decode_SRC_LESS_UNSIGNED_62),{_zz__zz_decode_SRC_LESS_UNSIGNED_63,_zz__zz_decode_SRC_LESS_UNSIGNED_64}}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_65 = (|{_zz_decode_SRC_LESS_UNSIGNED_3,{_zz_decode_SRC_LESS_UNSIGNED_2,{_zz__zz_decode_SRC_LESS_UNSIGNED_66,_zz__zz_decode_SRC_LESS_UNSIGNED_68}}});
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_73 = (|(_zz__zz_decode_SRC_LESS_UNSIGNED_74 == _zz__zz_decode_SRC_LESS_UNSIGNED_75));
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_76 = {(|{_zz__zz_decode_SRC_LESS_UNSIGNED_77,_zz__zz_decode_SRC_LESS_UNSIGNED_78}),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_80),(|_zz__zz_decode_SRC_LESS_UNSIGNED_83)}};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_61 = (decode_INSTRUCTION & 32'h00002010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_62 = 32'h00002010;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_63 = ((decode_INSTRUCTION & 32'h00001010) == 32'h00000010);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_64 = ((decode_INSTRUCTION & 32'h00000030) == 32'h00000020);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_66 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_67) == 32'h00000008);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_68 = {(_zz__zz_decode_SRC_LESS_UNSIGNED_69 == _zz__zz_decode_SRC_LESS_UNSIGNED_70),(_zz__zz_decode_SRC_LESS_UNSIGNED_71 == _zz__zz_decode_SRC_LESS_UNSIGNED_72)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_74 = (decode_INSTRUCTION & 32'h0000100c);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_75 = 32'h00001008;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_77 = _zz_decode_SRC_LESS_UNSIGNED_1;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_78 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_79) == 32'h04000008);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_80 = {_zz_decode_SRC_LESS_UNSIGNED_1,(_zz__zz_decode_SRC_LESS_UNSIGNED_81 == _zz__zz_decode_SRC_LESS_UNSIGNED_82)};
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_83 = ((decode_INSTRUCTION & _zz__zz_decode_SRC_LESS_UNSIGNED_84) == 32'h00000008);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_67 = 32'h0000000c;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_69 = (decode_INSTRUCTION & 32'h0000000c);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_70 = 32'h00000004;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_71 = (decode_INSTRUCTION & 32'h00000028);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_72 = 32'h0;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_79 = 32'h2400000c;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_81 = (decode_INSTRUCTION & 32'h2600000c);
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_82 = 32'h02000008;
  assign _zz__zz_decode_SRC_LESS_UNSIGNED_84 = 32'h2000000c;
  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs1Data) begin
      RegFilePlugin_regFile_spinal_port0 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @(posedge clk) begin
    if(_zz_decode_RegFilePlugin_rs2Data) begin
      RegFilePlugin_regFile_spinal_port1 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  always @(posedge clk) begin
    if(_zz_1) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  StreamFifoLowLatency IBusSimplePlugin_rspJoin_rspBuffer_c (
    .io_push_valid         (iBus_rsp_toStream_valid                                       ), //i
    .io_push_ready         (IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready            ), //o
    .io_push_payload_error (iBus_rsp_toStream_payload_error                               ), //i
    .io_push_payload_inst  (iBus_rsp_toStream_payload_inst[31:0]                          ), //i
    .io_pop_valid          (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid             ), //o
    .io_pop_ready          (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready             ), //i
    .io_pop_payload_error  (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error     ), //o
    .io_pop_payload_inst   (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst[31:0]), //o
    .io_flush              (1'b0                                                          ), //i
    .io_occupancy          (IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy             ), //o
    .io_availability       (IBusSimplePlugin_rspJoin_rspBuffer_c_io_availability          ), //o
    .clk                   (clk                                                           ), //i
    .reset                 (reset                                                         )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_to_execute_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_to_execute_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_to_memory_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_execute_to_memory_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_to_execute_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_INT4_OP)
      Int4OpEnum_ADD : decode_INT4_OP_string = "ADD";
      Int4OpEnum_SUB : decode_INT4_OP_string = "SUB";
      Int4OpEnum_MAX : decode_INT4_OP_string = "MAX";
      Int4OpEnum_MIN : decode_INT4_OP_string = "MIN";
      default : decode_INT4_OP_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_INT4_OP)
      Int4OpEnum_ADD : _zz_decode_INT4_OP_string = "ADD";
      Int4OpEnum_SUB : _zz_decode_INT4_OP_string = "SUB";
      Int4OpEnum_MAX : _zz_decode_INT4_OP_string = "MAX";
      Int4OpEnum_MIN : _zz_decode_INT4_OP_string = "MIN";
      default : _zz_decode_INT4_OP_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_INT4_OP)
      Int4OpEnum_ADD : _zz_decode_to_execute_INT4_OP_string = "ADD";
      Int4OpEnum_SUB : _zz_decode_to_execute_INT4_OP_string = "SUB";
      Int4OpEnum_MAX : _zz_decode_to_execute_INT4_OP_string = "MAX";
      Int4OpEnum_MIN : _zz_decode_to_execute_INT4_OP_string = "MIN";
      default : _zz_decode_to_execute_INT4_OP_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_INT4_OP_1)
      Int4OpEnum_ADD : _zz_decode_to_execute_INT4_OP_1_string = "ADD";
      Int4OpEnum_SUB : _zz_decode_to_execute_INT4_OP_1_string = "SUB";
      Int4OpEnum_MAX : _zz_decode_to_execute_INT4_OP_1_string = "MAX";
      Int4OpEnum_MIN : _zz_decode_to_execute_INT4_OP_1_string = "MIN";
      default : _zz_decode_to_execute_INT4_OP_1_string = "???";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : _zz_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : _zz_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : _zz_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : memory_SHIFT_CTRL_string = "SRA_1    ";
      default : memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : _zz_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : _zz_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_string = "PC ";
      default : _zz_decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : _zz_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : _zz_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_1)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_1_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_1_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_1_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_1)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_1_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_1_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_1_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_1_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_1_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_1)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_1_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_1)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_1_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_1_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_1)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_1_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_1_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_1_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_1)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_1_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_1_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_1_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_INT4_OP_1)
      Int4OpEnum_ADD : _zz_decode_INT4_OP_1_string = "ADD";
      Int4OpEnum_SUB : _zz_decode_INT4_OP_1_string = "SUB";
      Int4OpEnum_MAX : _zz_decode_INT4_OP_1_string = "MAX";
      Int4OpEnum_MIN : _zz_decode_INT4_OP_1_string = "MIN";
      default : _zz_decode_INT4_OP_1_string = "???";
    endcase
  end
  always @(*) begin
    case(execute_INT4_OP)
      Int4OpEnum_ADD : execute_INT4_OP_string = "ADD";
      Int4OpEnum_SUB : execute_INT4_OP_string = "SUB";
      Int4OpEnum_MAX : execute_INT4_OP_string = "MAX";
      Int4OpEnum_MIN : execute_INT4_OP_string = "MIN";
      default : execute_INT4_OP_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_execute_INT4_OP)
      Int4OpEnum_ADD : _zz_execute_INT4_OP_string = "ADD";
      Int4OpEnum_SUB : _zz_execute_INT4_OP_string = "SUB";
      Int4OpEnum_MAX : _zz_execute_INT4_OP_string = "MAX";
      Int4OpEnum_MIN : _zz_execute_INT4_OP_string = "MIN";
      default : _zz_execute_INT4_OP_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_INT4_OP_2)
      Int4OpEnum_ADD : _zz_decode_INT4_OP_2_string = "ADD";
      Int4OpEnum_SUB : _zz_decode_INT4_OP_2_string = "SUB";
      Int4OpEnum_MAX : _zz_decode_INT4_OP_2_string = "MAX";
      Int4OpEnum_MIN : _zz_decode_INT4_OP_2_string = "MIN";
      default : _zz_decode_INT4_OP_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_2)
      Src1CtrlEnum_RS : _zz_decode_SRC1_CTRL_2_string = "RS          ";
      Src1CtrlEnum_IMU : _zz_decode_SRC1_CTRL_2_string = "IMU         ";
      Src1CtrlEnum_PC_INCREMENT : _zz_decode_SRC1_CTRL_2_string = "PC_INCREMENT";
      Src1CtrlEnum_URS1 : _zz_decode_SRC1_CTRL_2_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_2_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_2)
      Src2CtrlEnum_RS : _zz_decode_SRC2_CTRL_2_string = "RS ";
      Src2CtrlEnum_IMI : _zz_decode_SRC2_CTRL_2_string = "IMI";
      Src2CtrlEnum_IMS : _zz_decode_SRC2_CTRL_2_string = "IMS";
      Src2CtrlEnum_PC : _zz_decode_SRC2_CTRL_2_string = "PC ";
      default : _zz_decode_SRC2_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_2)
      AluCtrlEnum_ADD_SUB : _zz_decode_ALU_CTRL_2_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : _zz_decode_ALU_CTRL_2_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : _zz_decode_ALU_CTRL_2_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_2)
      AluBitwiseCtrlEnum_XOR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : _zz_decode_ALU_BITWISE_CTRL_2_string = "AND_1";
      default : _zz_decode_ALU_BITWISE_CTRL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_2)
      ShiftCtrlEnum_DISABLE_1 : _zz_decode_SHIFT_CTRL_2_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : _zz_decode_SHIFT_CTRL_2_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : _zz_decode_SHIFT_CTRL_2_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : _zz_decode_SHIFT_CTRL_2_string = "SRA_1    ";
      default : _zz_decode_SHIFT_CTRL_2_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_2)
      BranchCtrlEnum_INC : _zz_decode_BRANCH_CTRL_2_string = "INC ";
      BranchCtrlEnum_B : _zz_decode_BRANCH_CTRL_2_string = "B   ";
      BranchCtrlEnum_JAL : _zz_decode_BRANCH_CTRL_2_string = "JAL ";
      BranchCtrlEnum_JALR : _zz_decode_BRANCH_CTRL_2_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_INT4_OP)
      Int4OpEnum_ADD : decode_to_execute_INT4_OP_string = "ADD";
      Int4OpEnum_SUB : decode_to_execute_INT4_OP_string = "SUB";
      Int4OpEnum_MAX : decode_to_execute_INT4_OP_string = "MAX";
      Int4OpEnum_MIN : decode_to_execute_INT4_OP_string = "MIN";
      default : decode_to_execute_INT4_OP_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      AluCtrlEnum_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      AluCtrlEnum_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      AluCtrlEnum_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      AluBitwiseCtrlEnum_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      AluBitwiseCtrlEnum_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_SHIFT_CTRL)
      ShiftCtrlEnum_DISABLE_1 : execute_to_memory_SHIFT_CTRL_string = "DISABLE_1";
      ShiftCtrlEnum_SLL_1 : execute_to_memory_SHIFT_CTRL_string = "SLL_1    ";
      ShiftCtrlEnum_SRL_1 : execute_to_memory_SHIFT_CTRL_string = "SRL_1    ";
      ShiftCtrlEnum_SRA_1 : execute_to_memory_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_to_memory_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      BranchCtrlEnum_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      BranchCtrlEnum_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      BranchCtrlEnum_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  `endif

  assign memory_MEMORY_READ_DATA = dBus_rsp_data;
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0};
  assign execute_BRANCH_DO = _zz_execute_BRANCH_DO_1;
  assign execute_SHIFT_RIGHT = _zz_execute_SHIFT_RIGHT;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = dBus_cmd_payload_address[1 : 0];
  assign decode_SRC2 = _zz_decode_SRC2_4;
  assign decode_SRC1 = _zz_decode_SRC1;
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1;
  assign _zz_execute_to_memory_SHIFT_CTRL = _zz_execute_to_memory_SHIFT_CTRL_1;
  assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1;
  assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  assign decode_SRC_LESS_UNSIGNED = _zz_decode_SRC_LESS_UNSIGNED[22];
  assign decode_ALU_CTRL = _zz_decode_ALU_CTRL;
  assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1;
  assign decode_MEMORY_STORE = _zz_decode_SRC_LESS_UNSIGNED[18];
  assign decode_MEMORY_ENABLE = _zz_decode_SRC_LESS_UNSIGNED[15];
  assign decode_DOT_UNSIGNED_RS2 = _zz_decode_SRC_LESS_UNSIGNED[11];
  assign decode_DOT_UNSIGNED_RS1 = _zz_decode_SRC_LESS_UNSIGNED[10];
  assign decode_IS_DOT_INT4 = _zz_decode_SRC_LESS_UNSIGNED[9];
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_SRC_LESS_UNSIGNED[6];
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_SRC_LESS_UNSIGNED[5];
  assign decode_INT4_UNSIGNED = _zz_decode_SRC_LESS_UNSIGNED[3];
  assign decode_INT4_OP = _zz_decode_INT4_OP;
  assign _zz_decode_to_execute_INT4_OP = _zz_decode_to_execute_INT4_OP_1;
  assign decode_IS_ALU_INT4 = _zz_decode_SRC_LESS_UNSIGNED[0];
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = (decode_PC + 32'h00000004);
  assign memory_PC = execute_to_memory_PC;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL;
  assign decode_RS2_USE = _zz_decode_SRC_LESS_UNSIGNED[8];
  assign decode_RS1_USE = _zz_decode_SRC_LESS_UNSIGNED[7];
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    decode_RS2 = decode_RegFilePlugin_rs2Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr1Match) begin
        decode_RS2 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l51) begin
          decode_RS2 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l51_1) begin
          decode_RS2 = _zz_decode_RS2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l51_2) begin
          decode_RS2 = _zz_decode_RS2_2;
        end
      end
    end
  end

  always @(*) begin
    decode_RS1 = decode_RegFilePlugin_rs1Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr0Match) begin
        decode_RS1 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l48) begin
          decode_RS1 = _zz_decode_RS2_1;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l48_1) begin
          decode_RS1 = _zz_decode_RS2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l48_2) begin
          decode_RS1 = _zz_decode_RS2_2;
        end
      end
    end
  end

  assign memory_SHIFT_RIGHT = execute_to_memory_SHIFT_RIGHT;
  always @(*) begin
    _zz_decode_RS2 = memory_REGFILE_WRITE_DATA;
    if(memory_arbitration_isValid) begin
      case(memory_SHIFT_CTRL)
        ShiftCtrlEnum_SLL_1 : begin
          _zz_decode_RS2 = _zz_decode_RS2_3;
        end
        ShiftCtrlEnum_SRL_1, ShiftCtrlEnum_SRA_1 : begin
          _zz_decode_RS2 = memory_SHIFT_RIGHT;
        end
        default : begin
        end
      endcase
    end
  end

  assign memory_SHIFT_CTRL = _zz_memory_SHIFT_CTRL;
  assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_decode_to_execute_PC = decode_PC;
  assign _zz_decode_to_execute_RS2 = decode_RS2;
  assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL;
  assign _zz_decode_to_execute_RS1 = decode_RS1;
  assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL;
  assign decode_SRC_USE_SUB_LESS = _zz_decode_SRC_LESS_UNSIGNED[14];
  assign decode_SRC_ADD_ZERO = _zz_decode_SRC_LESS_UNSIGNED[25];
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign execute_ALU_CTRL = _zz_execute_ALU_CTRL;
  assign execute_SRC2 = decode_to_execute_SRC2;
  assign execute_SRC1 = decode_to_execute_SRC1;
  assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL;
  assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION;
  assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    _zz_1 = 1'b0;
    if(lastStageRegFileWrite_valid) begin
      _zz_1 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusSimplePlugin_iBusRsp_output_payload_rsp_inst);
  always @(*) begin
    decode_REGFILE_WRITE_VALID = _zz_decode_SRC_LESS_UNSIGNED[4];
    if(when_RegFilePlugin_l63) begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @(*) begin
    _zz_decode_RS2_1 = writeBack_REGFILE_WRITE_DATA;
    if(when_DBusSimplePlugin_l566) begin
      _zz_decode_RS2_1 = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_MEMORY_STORE = execute_to_memory_MEMORY_STORE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_MEMORY_STORE = decode_to_execute_MEMORY_STORE;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_ALIGNEMENT_FAULT = 1'b0;
  assign decode_PC = IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign decode_INSTRUCTION = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign execute_IS_DOT_INT4 = decode_to_execute_IS_DOT_INT4;
  assign execute_DOT_UNSIGNED_RS2 = decode_to_execute_DOT_UNSIGNED_RS2;
  assign execute_DOT_UNSIGNED_RS1 = decode_to_execute_DOT_UNSIGNED_RS1;
  always @(*) begin
    _zz_decode_RS2_2 = execute_REGFILE_WRITE_DATA;
    if(execute_IS_ALU_INT4) begin
      _zz_decode_RS2_2 = execute_SimdPlugin_rd;
    end
    if(execute_IS_DOT_INT4) begin
      _zz_decode_RS2_2 = execute_SimdPlugin_dotSum;
    end
  end

  assign execute_IS_ALU_INT4 = decode_to_execute_IS_ALU_INT4;
  assign execute_INT4_OP = _zz_execute_INT4_OP;
  assign execute_INT4_UNSIGNED = decode_to_execute_INT4_UNSIGNED;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_RS1 = decode_to_execute_RS1;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  assign decode_arbitration_haltItself = 1'b0;
  always @(*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(when_HazardSimplePlugin_l113) begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_arbitration_isFlushed) begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  assign decode_arbitration_flushNext = 1'b0;
  always @(*) begin
    execute_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l435) begin
      execute_arbitration_haltItself = 1'b1;
    end
  end

  assign execute_arbitration_haltByOther = 1'b0;
  always @(*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed) begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  assign execute_arbitration_flushIt = 1'b0;
  assign execute_arbitration_flushNext = 1'b0;
  always @(*) begin
    memory_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l490) begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @(*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_arbitration_isFlushed) begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  always @(*) begin
    memory_arbitration_flushNext = 1'b0;
    if(BranchPlugin_jumpInterface_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
  end

  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @(*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushIt = 1'b0;
  assign writeBack_arbitration_flushNext = 1'b0;
  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  assign IBusSimplePlugin_fetcherHalt = 1'b0;
  assign IBusSimplePlugin_forceNoDecodeCond = 1'b0;
  always @(*) begin
    IBusSimplePlugin_incomingInstruction = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_valid) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
  end

  assign BranchPlugin_inDebugNoFetchFlag = 1'b0;
  assign execute_SimdPlugin_rs1 = execute_RS1;
  assign execute_SimdPlugin_rs2 = execute_RS2;
  assign execute_SimdPlugin_smax = 5'h07;
  assign execute_SimdPlugin_smin = 5'h18;
  assign execute_SimdPlugin_umax = 5'h0f;
  assign execute_SimdPlugin_uzero = 5'h0;
  assign _zz_execute_SimdPlugin_rd = execute_SimdPlugin_rs1[3 : 0];
  assign _zz_execute_SimdPlugin_rd_1 = execute_SimdPlugin_rs2[3 : 0];
  assign _zz_execute_SimdPlugin_rd_2 = {{1{_zz__zz_execute_SimdPlugin_rd_2[3]}}, _zz__zz_execute_SimdPlugin_rd_2};
  assign _zz_execute_SimdPlugin_rd_3 = {{1{_zz__zz_execute_SimdPlugin_rd_3[3]}}, _zz__zz_execute_SimdPlugin_rd_3};
  assign _zz_execute_SimdPlugin_rd_4 = {1'd0, _zz_execute_SimdPlugin_rd};
  assign _zz_execute_SimdPlugin_rd_5 = {1'd0, _zz_execute_SimdPlugin_rd_1};
  assign _zz_execute_SimdPlugin_rd_6 = ($signed(_zz_execute_SimdPlugin_rd_2) + $signed(_zz_execute_SimdPlugin_rd_3));
  assign _zz_execute_SimdPlugin_rd_7 = ($signed(_zz_execute_SimdPlugin_rd_2) - $signed(_zz_execute_SimdPlugin_rd_3));
  assign _zz_execute_SimdPlugin_rd_8 = (_zz_execute_SimdPlugin_rd_4 + _zz_execute_SimdPlugin_rd_5);
  assign _zz_execute_SimdPlugin_rd_9 = (_zz_execute_SimdPlugin_rd_4 - _zz_execute_SimdPlugin_rd_5);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_10 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_8) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_8) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_6)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_6) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_6)));
    if(when_SimdPlugin_l199) begin
      _zz_execute_SimdPlugin_rd_10 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_9[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_9) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_9)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_7)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_7) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_10)));
    end
    if(when_SimdPlugin_l200) begin
      _zz_execute_SimdPlugin_rd_10 = {1'd0, _zz__zz_execute_SimdPlugin_rd_10_3};
    end
    if(when_SimdPlugin_l201) begin
      _zz_execute_SimdPlugin_rd_10 = {1'd0, _zz__zz_execute_SimdPlugin_rd_10_6};
    end
  end

  assign when_SimdPlugin_l199 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201 = (execute_INT4_OP == Int4OpEnum_MIN);
  always @(*) begin
    execute_SimdPlugin_rd[3 : 0] = _zz_execute_SimdPlugin_rd_10[3 : 0];
    execute_SimdPlugin_rd[7 : 4] = _zz_execute_SimdPlugin_rd_21[3 : 0];
    execute_SimdPlugin_rd[11 : 8] = _zz_execute_SimdPlugin_rd_32[3 : 0];
    execute_SimdPlugin_rd[15 : 12] = _zz_execute_SimdPlugin_rd_43[3 : 0];
    execute_SimdPlugin_rd[19 : 16] = _zz_execute_SimdPlugin_rd_54[3 : 0];
    execute_SimdPlugin_rd[23 : 20] = _zz_execute_SimdPlugin_rd_65[3 : 0];
    execute_SimdPlugin_rd[27 : 24] = _zz_execute_SimdPlugin_rd_76[3 : 0];
    execute_SimdPlugin_rd[31 : 28] = _zz_execute_SimdPlugin_rd_87[3 : 0];
  end

  assign _zz_execute_SimdPlugin_rd_11 = execute_SimdPlugin_rs1[7 : 4];
  assign _zz_execute_SimdPlugin_rd_12 = execute_SimdPlugin_rs2[7 : 4];
  assign _zz_execute_SimdPlugin_rd_13 = {{1{_zz__zz_execute_SimdPlugin_rd_13[3]}}, _zz__zz_execute_SimdPlugin_rd_13};
  assign _zz_execute_SimdPlugin_rd_14 = {{1{_zz__zz_execute_SimdPlugin_rd_14[3]}}, _zz__zz_execute_SimdPlugin_rd_14};
  assign _zz_execute_SimdPlugin_rd_15 = {1'd0, _zz_execute_SimdPlugin_rd_11};
  assign _zz_execute_SimdPlugin_rd_16 = {1'd0, _zz_execute_SimdPlugin_rd_12};
  assign _zz_execute_SimdPlugin_rd_17 = ($signed(_zz_execute_SimdPlugin_rd_13) + $signed(_zz_execute_SimdPlugin_rd_14));
  assign _zz_execute_SimdPlugin_rd_18 = ($signed(_zz_execute_SimdPlugin_rd_13) - $signed(_zz_execute_SimdPlugin_rd_14));
  assign _zz_execute_SimdPlugin_rd_19 = (_zz_execute_SimdPlugin_rd_15 + _zz_execute_SimdPlugin_rd_16);
  assign _zz_execute_SimdPlugin_rd_20 = (_zz_execute_SimdPlugin_rd_15 - _zz_execute_SimdPlugin_rd_16);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_21 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_19) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_19) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_17)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_17) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_17)));
    if(when_SimdPlugin_l199_1) begin
      _zz_execute_SimdPlugin_rd_21 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_20[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_20) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_20)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_18)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_18) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_21)));
    end
    if(when_SimdPlugin_l200_1) begin
      _zz_execute_SimdPlugin_rd_21 = {1'd0, _zz__zz_execute_SimdPlugin_rd_21_3};
    end
    if(when_SimdPlugin_l201_1) begin
      _zz_execute_SimdPlugin_rd_21 = {1'd0, _zz__zz_execute_SimdPlugin_rd_21_6};
    end
  end

  assign when_SimdPlugin_l199_1 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200_1 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201_1 = (execute_INT4_OP == Int4OpEnum_MIN);
  assign _zz_execute_SimdPlugin_rd_22 = execute_SimdPlugin_rs1[11 : 8];
  assign _zz_execute_SimdPlugin_rd_23 = execute_SimdPlugin_rs2[11 : 8];
  assign _zz_execute_SimdPlugin_rd_24 = {{1{_zz__zz_execute_SimdPlugin_rd_24[3]}}, _zz__zz_execute_SimdPlugin_rd_24};
  assign _zz_execute_SimdPlugin_rd_25 = {{1{_zz__zz_execute_SimdPlugin_rd_25[3]}}, _zz__zz_execute_SimdPlugin_rd_25};
  assign _zz_execute_SimdPlugin_rd_26 = {1'd0, _zz_execute_SimdPlugin_rd_22};
  assign _zz_execute_SimdPlugin_rd_27 = {1'd0, _zz_execute_SimdPlugin_rd_23};
  assign _zz_execute_SimdPlugin_rd_28 = ($signed(_zz_execute_SimdPlugin_rd_24) + $signed(_zz_execute_SimdPlugin_rd_25));
  assign _zz_execute_SimdPlugin_rd_29 = ($signed(_zz_execute_SimdPlugin_rd_24) - $signed(_zz_execute_SimdPlugin_rd_25));
  assign _zz_execute_SimdPlugin_rd_30 = (_zz_execute_SimdPlugin_rd_26 + _zz_execute_SimdPlugin_rd_27);
  assign _zz_execute_SimdPlugin_rd_31 = (_zz_execute_SimdPlugin_rd_26 - _zz_execute_SimdPlugin_rd_27);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_32 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_30) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_30) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_28)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_28) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_28)));
    if(when_SimdPlugin_l199_2) begin
      _zz_execute_SimdPlugin_rd_32 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_31[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_31) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_31)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_29)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_29) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_32)));
    end
    if(when_SimdPlugin_l200_2) begin
      _zz_execute_SimdPlugin_rd_32 = {1'd0, _zz__zz_execute_SimdPlugin_rd_32_3};
    end
    if(when_SimdPlugin_l201_2) begin
      _zz_execute_SimdPlugin_rd_32 = {1'd0, _zz__zz_execute_SimdPlugin_rd_32_6};
    end
  end

  assign when_SimdPlugin_l199_2 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200_2 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201_2 = (execute_INT4_OP == Int4OpEnum_MIN);
  assign _zz_execute_SimdPlugin_rd_33 = execute_SimdPlugin_rs1[15 : 12];
  assign _zz_execute_SimdPlugin_rd_34 = execute_SimdPlugin_rs2[15 : 12];
  assign _zz_execute_SimdPlugin_rd_35 = {{1{_zz__zz_execute_SimdPlugin_rd_35[3]}}, _zz__zz_execute_SimdPlugin_rd_35};
  assign _zz_execute_SimdPlugin_rd_36 = {{1{_zz__zz_execute_SimdPlugin_rd_36[3]}}, _zz__zz_execute_SimdPlugin_rd_36};
  assign _zz_execute_SimdPlugin_rd_37 = {1'd0, _zz_execute_SimdPlugin_rd_33};
  assign _zz_execute_SimdPlugin_rd_38 = {1'd0, _zz_execute_SimdPlugin_rd_34};
  assign _zz_execute_SimdPlugin_rd_39 = ($signed(_zz_execute_SimdPlugin_rd_35) + $signed(_zz_execute_SimdPlugin_rd_36));
  assign _zz_execute_SimdPlugin_rd_40 = ($signed(_zz_execute_SimdPlugin_rd_35) - $signed(_zz_execute_SimdPlugin_rd_36));
  assign _zz_execute_SimdPlugin_rd_41 = (_zz_execute_SimdPlugin_rd_37 + _zz_execute_SimdPlugin_rd_38);
  assign _zz_execute_SimdPlugin_rd_42 = (_zz_execute_SimdPlugin_rd_37 - _zz_execute_SimdPlugin_rd_38);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_43 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_41) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_41) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_39)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_39) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_39)));
    if(when_SimdPlugin_l199_3) begin
      _zz_execute_SimdPlugin_rd_43 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_42[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_42) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_42)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_40)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_40) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_43)));
    end
    if(when_SimdPlugin_l200_3) begin
      _zz_execute_SimdPlugin_rd_43 = {1'd0, _zz__zz_execute_SimdPlugin_rd_43_3};
    end
    if(when_SimdPlugin_l201_3) begin
      _zz_execute_SimdPlugin_rd_43 = {1'd0, _zz__zz_execute_SimdPlugin_rd_43_6};
    end
  end

  assign when_SimdPlugin_l199_3 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200_3 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201_3 = (execute_INT4_OP == Int4OpEnum_MIN);
  assign _zz_execute_SimdPlugin_rd_44 = execute_SimdPlugin_rs1[19 : 16];
  assign _zz_execute_SimdPlugin_rd_45 = execute_SimdPlugin_rs2[19 : 16];
  assign _zz_execute_SimdPlugin_rd_46 = {{1{_zz__zz_execute_SimdPlugin_rd_46[3]}}, _zz__zz_execute_SimdPlugin_rd_46};
  assign _zz_execute_SimdPlugin_rd_47 = {{1{_zz__zz_execute_SimdPlugin_rd_47[3]}}, _zz__zz_execute_SimdPlugin_rd_47};
  assign _zz_execute_SimdPlugin_rd_48 = {1'd0, _zz_execute_SimdPlugin_rd_44};
  assign _zz_execute_SimdPlugin_rd_49 = {1'd0, _zz_execute_SimdPlugin_rd_45};
  assign _zz_execute_SimdPlugin_rd_50 = ($signed(_zz_execute_SimdPlugin_rd_46) + $signed(_zz_execute_SimdPlugin_rd_47));
  assign _zz_execute_SimdPlugin_rd_51 = ($signed(_zz_execute_SimdPlugin_rd_46) - $signed(_zz_execute_SimdPlugin_rd_47));
  assign _zz_execute_SimdPlugin_rd_52 = (_zz_execute_SimdPlugin_rd_48 + _zz_execute_SimdPlugin_rd_49);
  assign _zz_execute_SimdPlugin_rd_53 = (_zz_execute_SimdPlugin_rd_48 - _zz_execute_SimdPlugin_rd_49);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_54 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_52) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_52) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_50)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_50) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_50)));
    if(when_SimdPlugin_l199_4) begin
      _zz_execute_SimdPlugin_rd_54 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_53[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_53) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_53)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_51)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_51) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_54)));
    end
    if(when_SimdPlugin_l200_4) begin
      _zz_execute_SimdPlugin_rd_54 = {1'd0, _zz__zz_execute_SimdPlugin_rd_54_3};
    end
    if(when_SimdPlugin_l201_4) begin
      _zz_execute_SimdPlugin_rd_54 = {1'd0, _zz__zz_execute_SimdPlugin_rd_54_6};
    end
  end

  assign when_SimdPlugin_l199_4 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200_4 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201_4 = (execute_INT4_OP == Int4OpEnum_MIN);
  assign _zz_execute_SimdPlugin_rd_55 = execute_SimdPlugin_rs1[23 : 20];
  assign _zz_execute_SimdPlugin_rd_56 = execute_SimdPlugin_rs2[23 : 20];
  assign _zz_execute_SimdPlugin_rd_57 = {{1{_zz__zz_execute_SimdPlugin_rd_57[3]}}, _zz__zz_execute_SimdPlugin_rd_57};
  assign _zz_execute_SimdPlugin_rd_58 = {{1{_zz__zz_execute_SimdPlugin_rd_58[3]}}, _zz__zz_execute_SimdPlugin_rd_58};
  assign _zz_execute_SimdPlugin_rd_59 = {1'd0, _zz_execute_SimdPlugin_rd_55};
  assign _zz_execute_SimdPlugin_rd_60 = {1'd0, _zz_execute_SimdPlugin_rd_56};
  assign _zz_execute_SimdPlugin_rd_61 = ($signed(_zz_execute_SimdPlugin_rd_57) + $signed(_zz_execute_SimdPlugin_rd_58));
  assign _zz_execute_SimdPlugin_rd_62 = ($signed(_zz_execute_SimdPlugin_rd_57) - $signed(_zz_execute_SimdPlugin_rd_58));
  assign _zz_execute_SimdPlugin_rd_63 = (_zz_execute_SimdPlugin_rd_59 + _zz_execute_SimdPlugin_rd_60);
  assign _zz_execute_SimdPlugin_rd_64 = (_zz_execute_SimdPlugin_rd_59 - _zz_execute_SimdPlugin_rd_60);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_65 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_63) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_63) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_61)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_61) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_61)));
    if(when_SimdPlugin_l199_5) begin
      _zz_execute_SimdPlugin_rd_65 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_64[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_64) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_64)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_62)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_62) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_65)));
    end
    if(when_SimdPlugin_l200_5) begin
      _zz_execute_SimdPlugin_rd_65 = {1'd0, _zz__zz_execute_SimdPlugin_rd_65_3};
    end
    if(when_SimdPlugin_l201_5) begin
      _zz_execute_SimdPlugin_rd_65 = {1'd0, _zz__zz_execute_SimdPlugin_rd_65_6};
    end
  end

  assign when_SimdPlugin_l199_5 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200_5 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201_5 = (execute_INT4_OP == Int4OpEnum_MIN);
  assign _zz_execute_SimdPlugin_rd_66 = execute_SimdPlugin_rs1[27 : 24];
  assign _zz_execute_SimdPlugin_rd_67 = execute_SimdPlugin_rs2[27 : 24];
  assign _zz_execute_SimdPlugin_rd_68 = {{1{_zz__zz_execute_SimdPlugin_rd_68[3]}}, _zz__zz_execute_SimdPlugin_rd_68};
  assign _zz_execute_SimdPlugin_rd_69 = {{1{_zz__zz_execute_SimdPlugin_rd_69[3]}}, _zz__zz_execute_SimdPlugin_rd_69};
  assign _zz_execute_SimdPlugin_rd_70 = {1'd0, _zz_execute_SimdPlugin_rd_66};
  assign _zz_execute_SimdPlugin_rd_71 = {1'd0, _zz_execute_SimdPlugin_rd_67};
  assign _zz_execute_SimdPlugin_rd_72 = ($signed(_zz_execute_SimdPlugin_rd_68) + $signed(_zz_execute_SimdPlugin_rd_69));
  assign _zz_execute_SimdPlugin_rd_73 = ($signed(_zz_execute_SimdPlugin_rd_68) - $signed(_zz_execute_SimdPlugin_rd_69));
  assign _zz_execute_SimdPlugin_rd_74 = (_zz_execute_SimdPlugin_rd_70 + _zz_execute_SimdPlugin_rd_71);
  assign _zz_execute_SimdPlugin_rd_75 = (_zz_execute_SimdPlugin_rd_70 - _zz_execute_SimdPlugin_rd_71);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_76 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_74) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_74) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_72)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_72) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_72)));
    if(when_SimdPlugin_l199_6) begin
      _zz_execute_SimdPlugin_rd_76 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_75[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_75) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_75)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_73)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_73) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_76)));
    end
    if(when_SimdPlugin_l200_6) begin
      _zz_execute_SimdPlugin_rd_76 = {1'd0, _zz__zz_execute_SimdPlugin_rd_76_3};
    end
    if(when_SimdPlugin_l201_6) begin
      _zz_execute_SimdPlugin_rd_76 = {1'd0, _zz__zz_execute_SimdPlugin_rd_76_6};
    end
  end

  assign when_SimdPlugin_l199_6 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200_6 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201_6 = (execute_INT4_OP == Int4OpEnum_MIN);
  assign _zz_execute_SimdPlugin_rd_77 = execute_SimdPlugin_rs1[31 : 28];
  assign _zz_execute_SimdPlugin_rd_78 = execute_SimdPlugin_rs2[31 : 28];
  assign _zz_execute_SimdPlugin_rd_79 = {{1{_zz__zz_execute_SimdPlugin_rd_79[3]}}, _zz__zz_execute_SimdPlugin_rd_79};
  assign _zz_execute_SimdPlugin_rd_80 = {{1{_zz__zz_execute_SimdPlugin_rd_80[3]}}, _zz__zz_execute_SimdPlugin_rd_80};
  assign _zz_execute_SimdPlugin_rd_81 = {1'd0, _zz_execute_SimdPlugin_rd_77};
  assign _zz_execute_SimdPlugin_rd_82 = {1'd0, _zz_execute_SimdPlugin_rd_78};
  assign _zz_execute_SimdPlugin_rd_83 = ($signed(_zz_execute_SimdPlugin_rd_79) + $signed(_zz_execute_SimdPlugin_rd_80));
  assign _zz_execute_SimdPlugin_rd_84 = ($signed(_zz_execute_SimdPlugin_rd_79) - $signed(_zz_execute_SimdPlugin_rd_80));
  assign _zz_execute_SimdPlugin_rd_85 = (_zz_execute_SimdPlugin_rd_81 + _zz_execute_SimdPlugin_rd_82);
  assign _zz_execute_SimdPlugin_rd_86 = (_zz_execute_SimdPlugin_rd_81 - _zz_execute_SimdPlugin_rd_82);
  always @(*) begin
    _zz_execute_SimdPlugin_rd_87 = (execute_INT4_UNSIGNED ? ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_85) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_85) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_83)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_83) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz_execute_SimdPlugin_rd_83)));
    if(when_SimdPlugin_l199_7) begin
      _zz_execute_SimdPlugin_rd_87 = (execute_INT4_UNSIGNED ? (_zz_execute_SimdPlugin_rd_86[4] ? execute_SimdPlugin_uzero : ((execute_SimdPlugin_umax < _zz_execute_SimdPlugin_rd_86) ? execute_SimdPlugin_umax : _zz_execute_SimdPlugin_rd_86)) : (($signed(execute_SimdPlugin_smax) < $signed(_zz_execute_SimdPlugin_rd_84)) ? execute_SimdPlugin_smax : (($signed(_zz_execute_SimdPlugin_rd_84) < $signed(execute_SimdPlugin_smin)) ? execute_SimdPlugin_smin : _zz__zz_execute_SimdPlugin_rd_87)));
    end
    if(when_SimdPlugin_l200_7) begin
      _zz_execute_SimdPlugin_rd_87 = {1'd0, _zz__zz_execute_SimdPlugin_rd_87_3};
    end
    if(when_SimdPlugin_l201_7) begin
      _zz_execute_SimdPlugin_rd_87 = {1'd0, _zz__zz_execute_SimdPlugin_rd_87_6};
    end
  end

  assign when_SimdPlugin_l199_7 = (execute_INT4_OP == Int4OpEnum_SUB);
  assign when_SimdPlugin_l200_7 = (execute_INT4_OP == Int4OpEnum_MAX);
  assign when_SimdPlugin_l201_7 = (execute_INT4_OP == Int4OpEnum_MIN);
  assign _zz_execute_SimdPlugin_prods_0 = execute_SimdPlugin_rs1[3 : 0];
  assign _zz_execute_SimdPlugin_prods_0_1 = execute_SimdPlugin_rs2[3 : 0];
  assign execute_SimdPlugin_prods_0 = {{16{_zz_execute_SimdPlugin_prods_0_2[15]}}, _zz_execute_SimdPlugin_prods_0_2};
  assign _zz_execute_SimdPlugin_prods_1 = execute_SimdPlugin_rs1[7 : 4];
  assign _zz_execute_SimdPlugin_prods_1_1 = execute_SimdPlugin_rs2[7 : 4];
  assign execute_SimdPlugin_prods_1 = {{16{_zz_execute_SimdPlugin_prods_1_2[15]}}, _zz_execute_SimdPlugin_prods_1_2};
  assign _zz_execute_SimdPlugin_prods_2 = execute_SimdPlugin_rs1[11 : 8];
  assign _zz_execute_SimdPlugin_prods_2_1 = execute_SimdPlugin_rs2[11 : 8];
  assign execute_SimdPlugin_prods_2 = {{16{_zz_execute_SimdPlugin_prods_2_2[15]}}, _zz_execute_SimdPlugin_prods_2_2};
  assign _zz_execute_SimdPlugin_prods_3 = execute_SimdPlugin_rs1[15 : 12];
  assign _zz_execute_SimdPlugin_prods_3_1 = execute_SimdPlugin_rs2[15 : 12];
  assign execute_SimdPlugin_prods_3 = {{16{_zz_execute_SimdPlugin_prods_3_2[15]}}, _zz_execute_SimdPlugin_prods_3_2};
  assign _zz_execute_SimdPlugin_prods_4 = execute_SimdPlugin_rs1[19 : 16];
  assign _zz_execute_SimdPlugin_prods_4_1 = execute_SimdPlugin_rs2[19 : 16];
  assign execute_SimdPlugin_prods_4 = {{16{_zz_execute_SimdPlugin_prods_4_2[15]}}, _zz_execute_SimdPlugin_prods_4_2};
  assign _zz_execute_SimdPlugin_prods_5 = execute_SimdPlugin_rs1[23 : 20];
  assign _zz_execute_SimdPlugin_prods_5_1 = execute_SimdPlugin_rs2[23 : 20];
  assign execute_SimdPlugin_prods_5 = {{16{_zz_execute_SimdPlugin_prods_5_2[15]}}, _zz_execute_SimdPlugin_prods_5_2};
  assign _zz_execute_SimdPlugin_prods_6 = execute_SimdPlugin_rs1[27 : 24];
  assign _zz_execute_SimdPlugin_prods_6_1 = execute_SimdPlugin_rs2[27 : 24];
  assign execute_SimdPlugin_prods_6 = {{16{_zz_execute_SimdPlugin_prods_6_2[15]}}, _zz_execute_SimdPlugin_prods_6_2};
  assign _zz_execute_SimdPlugin_prods_7 = execute_SimdPlugin_rs1[31 : 28];
  assign _zz_execute_SimdPlugin_prods_7_1 = execute_SimdPlugin_rs2[31 : 28];
  assign execute_SimdPlugin_prods_7 = {{16{_zz_execute_SimdPlugin_prods_7_2[15]}}, _zz_execute_SimdPlugin_prods_7_2};
  assign execute_SimdPlugin_lvl0 = ($signed(execute_SimdPlugin_prods_0) + $signed(execute_SimdPlugin_prods_1));
  assign execute_SimdPlugin_lvl1 = ($signed(execute_SimdPlugin_prods_2) + $signed(execute_SimdPlugin_prods_3));
  assign execute_SimdPlugin_lvl2 = ($signed(execute_SimdPlugin_prods_4) + $signed(execute_SimdPlugin_prods_5));
  assign execute_SimdPlugin_lvl3 = ($signed(execute_SimdPlugin_prods_6) + $signed(execute_SimdPlugin_prods_7));
  assign execute_SimdPlugin_lvl4 = ($signed(execute_SimdPlugin_lvl0) + $signed(execute_SimdPlugin_lvl1));
  assign execute_SimdPlugin_lvl5 = ($signed(execute_SimdPlugin_lvl2) + $signed(execute_SimdPlugin_lvl3));
  assign execute_SimdPlugin_dotSum = ($signed(execute_SimdPlugin_lvl4) + $signed(execute_SimdPlugin_lvl5));
  assign IBusSimplePlugin_externalFlush = (|{writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}});
  assign IBusSimplePlugin_jump_pcLoad_valid = (|BranchPlugin_jumpInterface_valid);
  assign IBusSimplePlugin_jump_pcLoad_payload = BranchPlugin_jumpInterface_payload;
  always @(*) begin
    IBusSimplePlugin_fetchPc_correction = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_correction = 1'b1;
    end
  end

  assign IBusSimplePlugin_fetchPc_output_fire = (IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready);
  assign IBusSimplePlugin_fetchPc_corrected = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_correctionReg);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_ready) begin
      IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  assign when_Fetcher_l133 = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_pcRegPropagate);
  assign when_Fetcher_l133_1 = ((! IBusSimplePlugin_fetchPc_output_valid) && IBusSimplePlugin_fetchPc_output_ready);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_IBusSimplePlugin_fetchPc_pc);
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    IBusSimplePlugin_fetchPc_pc[0] = 1'b0;
    IBusSimplePlugin_fetchPc_pc[1] = 1'b0;
  end

  always @(*) begin
    IBusSimplePlugin_fetchPc_flushed = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_flushed = 1'b1;
    end
  end

  assign when_Fetcher_l160 = (IBusSimplePlugin_fetchPc_booted && ((IBusSimplePlugin_fetchPc_output_ready || IBusSimplePlugin_fetchPc_correction) || IBusSimplePlugin_fetchPc_pcRegPropagate));
  assign IBusSimplePlugin_fetchPc_output_valid = ((! IBusSimplePlugin_fetcherHalt) && IBusSimplePlugin_fetchPc_booted);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_pc;
  assign IBusSimplePlugin_iBusRsp_redoFetch = 1'b0;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_valid = IBusSimplePlugin_fetchPc_output_valid;
  assign IBusSimplePlugin_fetchPc_output_ready = IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b0;
    if(when_IBusSimplePlugin_l306) begin
      IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready = (! IBusSimplePlugin_iBusRsp_stages_0_halt);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_ready = (IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_ready && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_payload = IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_0_output_valid = IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_valid;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_ready = IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_output_payload = IBusSimplePlugin_iBusRsp_stages_0_input_haltWhen_payload;
  assign IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b0;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready = (! IBusSimplePlugin_iBusRsp_stages_1_halt);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_ready = (IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_ready && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_payload = IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_valid = IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_valid;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_ready = IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_payload = IBusSimplePlugin_iBusRsp_stages_1_input_haltWhen_payload;
  assign IBusSimplePlugin_iBusRsp_flush = (IBusSimplePlugin_externalFlush || IBusSimplePlugin_iBusRsp_redoFetch);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_valid = IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  assign IBusSimplePlugin_iBusRsp_stages_0_output_ready = IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_ready = ((1'b0 && (! IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid)) || IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_valid = IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid;
  assign IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_ready = IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_payload = IBusSimplePlugin_fetchPc_pcReg;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
    if(when_Fetcher_l322) begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusSimplePlugin_iBusRsp_output_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_IBusSimplePlugin_injector_decodeInput_valid;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign when_Fetcher_l322 = (! IBusSimplePlugin_pcValids_0);
  assign when_Fetcher_l331 = (! (! IBusSimplePlugin_iBusRsp_stages_1_input_ready));
  assign when_Fetcher_l331_1 = (! (! IBusSimplePlugin_injector_decodeInput_ready));
  assign when_Fetcher_l331_2 = (! execute_arbitration_isStuck);
  assign when_Fetcher_l331_3 = (! memory_arbitration_isStuck);
  assign when_Fetcher_l331_4 = (! writeBack_arbitration_isStuck);
  assign IBusSimplePlugin_pcValids_0 = IBusSimplePlugin_injector_nextPcCalc_valids_1;
  assign IBusSimplePlugin_pcValids_1 = IBusSimplePlugin_injector_nextPcCalc_valids_2;
  assign IBusSimplePlugin_pcValids_2 = IBusSimplePlugin_injector_nextPcCalc_valids_3;
  assign IBusSimplePlugin_pcValids_3 = IBusSimplePlugin_injector_nextPcCalc_valids_4;
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @(*) begin
    decode_arbitration_isValid = IBusSimplePlugin_injector_decodeInput_valid;
    if(IBusSimplePlugin_forceNoDecodeCond) begin
      decode_arbitration_isValid = 1'b0;
    end
  end

  assign iBus_cmd_valid = IBusSimplePlugin_cmd_valid;
  assign IBusSimplePlugin_cmd_ready = iBus_cmd_ready;
  assign iBus_cmd_payload_pc = IBusSimplePlugin_cmd_payload_pc;
  assign IBusSimplePlugin_pending_next = (_zz_IBusSimplePlugin_pending_next - _zz_IBusSimplePlugin_pending_next_3);
  assign IBusSimplePlugin_cmdFork_canEmit = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && (IBusSimplePlugin_pending_value != 3'b111));
  assign when_IBusSimplePlugin_l306 = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && ((! IBusSimplePlugin_cmdFork_canEmit) || (! IBusSimplePlugin_cmd_ready)));
  assign IBusSimplePlugin_cmd_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && IBusSimplePlugin_cmdFork_canEmit);
  assign IBusSimplePlugin_cmd_fire = (IBusSimplePlugin_cmd_valid && IBusSimplePlugin_cmd_ready);
  assign IBusSimplePlugin_pending_inc = IBusSimplePlugin_cmd_fire;
  assign IBusSimplePlugin_cmd_payload_pc = {IBusSimplePlugin_iBusRsp_stages_0_input_payload[31 : 2],2'b00};
  assign iBus_rsp_toStream_valid = iBus_rsp_valid;
  assign iBus_rsp_toStream_payload_error = iBus_rsp_payload_error;
  assign iBus_rsp_toStream_payload_inst = iBus_rsp_payload_inst;
  assign iBus_rsp_toStream_ready = IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  assign IBusSimplePlugin_rspJoin_rspBuffer_flush = ((IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000) || IBusSimplePlugin_iBusRsp_flush);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_valid = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter == 3'b000));
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  assign IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready = (IBusSimplePlugin_rspJoin_rspBuffer_output_ready || IBusSimplePlugin_rspJoin_rspBuffer_flush);
  assign io_pop_fire = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready);
  assign IBusSimplePlugin_pending_dec = io_pop_fire;
  assign IBusSimplePlugin_rspJoin_fetchRsp_isRvc = 1'b0;
  assign IBusSimplePlugin_rspJoin_fetchRsp_pc = IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  always @(*) begin
    IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
    if(when_IBusSimplePlugin_l378) begin
      IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  assign when_IBusSimplePlugin_l378 = (! IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_exceptionDetected = 1'b0;
  assign IBusSimplePlugin_rspJoin_join_valid = (IBusSimplePlugin_iBusRsp_stages_1_output_valid && IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_join_payload_pc = IBusSimplePlugin_rspJoin_fetchRsp_pc;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_error = IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_inst = IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_payload_isRvc = IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  assign IBusSimplePlugin_rspJoin_join_fire = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_valid ? IBusSimplePlugin_rspJoin_join_fire : IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_ready = IBusSimplePlugin_rspJoin_join_fire;
  assign _zz_IBusSimplePlugin_rspJoin_join_ready = (! IBusSimplePlugin_rspJoin_exceptionDetected);
  assign IBusSimplePlugin_rspJoin_join_haltWhen_valid = (IBusSimplePlugin_rspJoin_join_valid && _zz_IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_join_ready = (IBusSimplePlugin_rspJoin_join_haltWhen_ready && _zz_IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_join_haltWhen_payload_pc = IBusSimplePlugin_rspJoin_join_payload_pc;
  assign IBusSimplePlugin_rspJoin_join_haltWhen_payload_rsp_error = IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_haltWhen_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_haltWhen_payload_isRvc = IBusSimplePlugin_rspJoin_join_payload_isRvc;
  assign IBusSimplePlugin_iBusRsp_output_valid = IBusSimplePlugin_rspJoin_join_haltWhen_valid;
  assign IBusSimplePlugin_rspJoin_join_haltWhen_ready = IBusSimplePlugin_iBusRsp_output_ready;
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rspJoin_join_haltWhen_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rspJoin_join_haltWhen_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_haltWhen_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rspJoin_join_haltWhen_payload_isRvc;
  assign _zz_dBus_cmd_valid = 1'b0;
  always @(*) begin
    execute_DBusSimplePlugin_skipCmd = 1'b0;
    if(execute_ALIGNEMENT_FAULT) begin
      execute_DBusSimplePlugin_skipCmd = 1'b1;
    end
  end

  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  assign dBus_cmd_payload_wr = execute_MEMORY_STORE;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_dBus_cmd_payload_data = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_dBus_cmd_payload_data = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_dBus_cmd_payload_data = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_dBus_cmd_payload_data;
  assign when_DBusSimplePlugin_l435 = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0001;
      end
      2'b01 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0011;
      end
      default : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b1111;
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_execute_DBusSimplePlugin_formalMask <<< dBus_cmd_payload_address[1 : 0]);
  assign dBus_cmd_payload_mask = execute_DBusSimplePlugin_formalMask;
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign when_DBusSimplePlugin_l490 = (((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_MEMORY_STORE)) && ((! dBus_rsp_ready) || 1'b0));
  always @(*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign switch_Misc_l245 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_writeBack_DBusSimplePlugin_rspFormated = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[31] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[30] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[29] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[28] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[27] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[26] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[25] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[24] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[23] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[22] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[21] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[20] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[19] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[18] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[17] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[16] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[15] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[14] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[13] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[12] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[11] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[10] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[9] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[8] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_writeBack_DBusSimplePlugin_rspFormated_2 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[31] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[30] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[29] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[28] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[27] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[26] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[25] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[24] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[23] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[22] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[21] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[20] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[19] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[18] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[17] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[16] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @(*) begin
    case(switch_Misc_l245)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_1;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_3;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign when_DBusSimplePlugin_l566 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  assign _zz_decode_SRC_LESS_UNSIGNED_1 = ((decode_INSTRUCTION & 32'h0800000c) == 32'h08000008);
  assign _zz_decode_SRC_LESS_UNSIGNED_2 = ((decode_INSTRUCTION & 32'h00000048) == 32'h00000048);
  assign _zz_decode_SRC_LESS_UNSIGNED_3 = ((decode_INSTRUCTION & 32'h00000010) == 32'h00000010);
  assign _zz_decode_SRC_LESS_UNSIGNED_4 = ((decode_INSTRUCTION & 32'h00000004) == 32'h00000004);
  assign _zz_decode_SRC_LESS_UNSIGNED_5 = ((decode_INSTRUCTION & 32'h00000020) == 32'h00000020);
  assign _zz_decode_SRC_LESS_UNSIGNED_6 = ((decode_INSTRUCTION & 32'h00000018) == 32'h0);
  assign _zz_decode_SRC_LESS_UNSIGNED = {(|{_zz_decode_SRC_LESS_UNSIGNED_2,(_zz__zz_decode_SRC_LESS_UNSIGNED == _zz__zz_decode_SRC_LESS_UNSIGNED_1)}),{(|(_zz__zz_decode_SRC_LESS_UNSIGNED_2 == _zz__zz_decode_SRC_LESS_UNSIGNED_3)),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_4),{(|_zz__zz_decode_SRC_LESS_UNSIGNED_5),{_zz__zz_decode_SRC_LESS_UNSIGNED_10,{_zz__zz_decode_SRC_LESS_UNSIGNED_13,_zz__zz_decode_SRC_LESS_UNSIGNED_15}}}}}};
  assign _zz_decode_INT4_OP_2 = _zz_decode_SRC_LESS_UNSIGNED[2 : 1];
  assign _zz_decode_INT4_OP_1 = _zz_decode_INT4_OP_2;
  assign _zz_decode_SRC1_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[13 : 12];
  assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2;
  assign _zz_decode_SRC2_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[17 : 16];
  assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2;
  assign _zz_decode_ALU_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[21 : 20];
  assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2;
  assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[24 : 23];
  assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2;
  assign _zz_decode_SHIFT_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[27 : 26];
  assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_2;
  assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_SRC_LESS_UNSIGNED[29 : 28];
  assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL_2;
  assign when_RegFilePlugin_l63 = (decode_INSTRUCTION[11 : 7] == 5'h0);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = RegFilePlugin_regFile_spinal_port0;
  assign decode_RegFilePlugin_rs2Data = RegFilePlugin_regFile_spinal_port1;
  always @(*) begin
    lastStageRegFileWrite_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
    if(_zz_5) begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
    if(_zz_5) begin
      lastStageRegFileWrite_payload_address = 5'h0;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_data = _zz_decode_RS2_1;
    if(_zz_5) begin
      lastStageRegFileWrite_payload_data = 32'h0;
    end
  end

  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      AluBitwiseCtrlEnum_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      AluBitwiseCtrlEnum_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @(*) begin
    case(execute_ALU_CTRL)
      AluCtrlEnum_BITWISE : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise;
      end
      AluCtrlEnum_SLT_SLTU : begin
        _zz_execute_REGFILE_WRITE_DATA = {31'd0, _zz__zz_execute_REGFILE_WRITE_DATA};
      end
      default : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @(*) begin
    case(decode_SRC1_CTRL)
      Src1CtrlEnum_RS : begin
        _zz_decode_SRC1 = _zz_decode_to_execute_RS1;
      end
      Src1CtrlEnum_PC_INCREMENT : begin
        _zz_decode_SRC1 = {29'd0, _zz__zz_decode_SRC1};
      end
      Src1CtrlEnum_IMU : begin
        _zz_decode_SRC1 = {decode_INSTRUCTION[31 : 12],12'h0};
      end
      default : begin
        _zz_decode_SRC1 = {27'd0, _zz__zz_decode_SRC1_1};
      end
    endcase
  end

  assign _zz_decode_SRC2 = decode_INSTRUCTION[31];
  always @(*) begin
    _zz_decode_SRC2_1[19] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[18] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[17] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[16] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[15] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[14] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[13] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[12] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[11] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[10] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[9] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[8] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[7] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[6] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[5] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[4] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[3] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[2] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[1] = _zz_decode_SRC2;
    _zz_decode_SRC2_1[0] = _zz_decode_SRC2;
  end

  assign _zz_decode_SRC2_2 = _zz__zz_decode_SRC2_2[11];
  always @(*) begin
    _zz_decode_SRC2_3[19] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[18] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[17] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[16] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[15] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[14] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[13] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[12] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[11] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[10] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[9] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[8] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[7] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[6] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[5] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[4] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[3] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[2] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[1] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[0] = _zz_decode_SRC2_2;
  end

  always @(*) begin
    case(decode_SRC2_CTRL)
      Src2CtrlEnum_RS : begin
        _zz_decode_SRC2_4 = _zz_decode_to_execute_RS2;
      end
      Src2CtrlEnum_IMI : begin
        _zz_decode_SRC2_4 = {_zz_decode_SRC2_1,decode_INSTRUCTION[31 : 20]};
      end
      Src2CtrlEnum_IMS : begin
        _zz_decode_SRC2_4 = {_zz_decode_SRC2_3,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_decode_SRC2_4 = _zz_decode_to_execute_PC;
      end
    endcase
  end

  always @(*) begin
    execute_SrcPlugin_addSub = _zz_execute_SrcPlugin_addSub;
    if(execute_SRC2_FORCE_ZERO) begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_FullBarrelShifterPlugin_amplitude = execute_SRC2[4 : 0];
  always @(*) begin
    _zz_execute_FullBarrelShifterPlugin_reversed[0] = execute_SRC1[31];
    _zz_execute_FullBarrelShifterPlugin_reversed[1] = execute_SRC1[30];
    _zz_execute_FullBarrelShifterPlugin_reversed[2] = execute_SRC1[29];
    _zz_execute_FullBarrelShifterPlugin_reversed[3] = execute_SRC1[28];
    _zz_execute_FullBarrelShifterPlugin_reversed[4] = execute_SRC1[27];
    _zz_execute_FullBarrelShifterPlugin_reversed[5] = execute_SRC1[26];
    _zz_execute_FullBarrelShifterPlugin_reversed[6] = execute_SRC1[25];
    _zz_execute_FullBarrelShifterPlugin_reversed[7] = execute_SRC1[24];
    _zz_execute_FullBarrelShifterPlugin_reversed[8] = execute_SRC1[23];
    _zz_execute_FullBarrelShifterPlugin_reversed[9] = execute_SRC1[22];
    _zz_execute_FullBarrelShifterPlugin_reversed[10] = execute_SRC1[21];
    _zz_execute_FullBarrelShifterPlugin_reversed[11] = execute_SRC1[20];
    _zz_execute_FullBarrelShifterPlugin_reversed[12] = execute_SRC1[19];
    _zz_execute_FullBarrelShifterPlugin_reversed[13] = execute_SRC1[18];
    _zz_execute_FullBarrelShifterPlugin_reversed[14] = execute_SRC1[17];
    _zz_execute_FullBarrelShifterPlugin_reversed[15] = execute_SRC1[16];
    _zz_execute_FullBarrelShifterPlugin_reversed[16] = execute_SRC1[15];
    _zz_execute_FullBarrelShifterPlugin_reversed[17] = execute_SRC1[14];
    _zz_execute_FullBarrelShifterPlugin_reversed[18] = execute_SRC1[13];
    _zz_execute_FullBarrelShifterPlugin_reversed[19] = execute_SRC1[12];
    _zz_execute_FullBarrelShifterPlugin_reversed[20] = execute_SRC1[11];
    _zz_execute_FullBarrelShifterPlugin_reversed[21] = execute_SRC1[10];
    _zz_execute_FullBarrelShifterPlugin_reversed[22] = execute_SRC1[9];
    _zz_execute_FullBarrelShifterPlugin_reversed[23] = execute_SRC1[8];
    _zz_execute_FullBarrelShifterPlugin_reversed[24] = execute_SRC1[7];
    _zz_execute_FullBarrelShifterPlugin_reversed[25] = execute_SRC1[6];
    _zz_execute_FullBarrelShifterPlugin_reversed[26] = execute_SRC1[5];
    _zz_execute_FullBarrelShifterPlugin_reversed[27] = execute_SRC1[4];
    _zz_execute_FullBarrelShifterPlugin_reversed[28] = execute_SRC1[3];
    _zz_execute_FullBarrelShifterPlugin_reversed[29] = execute_SRC1[2];
    _zz_execute_FullBarrelShifterPlugin_reversed[30] = execute_SRC1[1];
    _zz_execute_FullBarrelShifterPlugin_reversed[31] = execute_SRC1[0];
  end

  assign execute_FullBarrelShifterPlugin_reversed = ((execute_SHIFT_CTRL == ShiftCtrlEnum_SLL_1) ? _zz_execute_FullBarrelShifterPlugin_reversed : execute_SRC1);
  always @(*) begin
    _zz_decode_RS2_3[0] = memory_SHIFT_RIGHT[31];
    _zz_decode_RS2_3[1] = memory_SHIFT_RIGHT[30];
    _zz_decode_RS2_3[2] = memory_SHIFT_RIGHT[29];
    _zz_decode_RS2_3[3] = memory_SHIFT_RIGHT[28];
    _zz_decode_RS2_3[4] = memory_SHIFT_RIGHT[27];
    _zz_decode_RS2_3[5] = memory_SHIFT_RIGHT[26];
    _zz_decode_RS2_3[6] = memory_SHIFT_RIGHT[25];
    _zz_decode_RS2_3[7] = memory_SHIFT_RIGHT[24];
    _zz_decode_RS2_3[8] = memory_SHIFT_RIGHT[23];
    _zz_decode_RS2_3[9] = memory_SHIFT_RIGHT[22];
    _zz_decode_RS2_3[10] = memory_SHIFT_RIGHT[21];
    _zz_decode_RS2_3[11] = memory_SHIFT_RIGHT[20];
    _zz_decode_RS2_3[12] = memory_SHIFT_RIGHT[19];
    _zz_decode_RS2_3[13] = memory_SHIFT_RIGHT[18];
    _zz_decode_RS2_3[14] = memory_SHIFT_RIGHT[17];
    _zz_decode_RS2_3[15] = memory_SHIFT_RIGHT[16];
    _zz_decode_RS2_3[16] = memory_SHIFT_RIGHT[15];
    _zz_decode_RS2_3[17] = memory_SHIFT_RIGHT[14];
    _zz_decode_RS2_3[18] = memory_SHIFT_RIGHT[13];
    _zz_decode_RS2_3[19] = memory_SHIFT_RIGHT[12];
    _zz_decode_RS2_3[20] = memory_SHIFT_RIGHT[11];
    _zz_decode_RS2_3[21] = memory_SHIFT_RIGHT[10];
    _zz_decode_RS2_3[22] = memory_SHIFT_RIGHT[9];
    _zz_decode_RS2_3[23] = memory_SHIFT_RIGHT[8];
    _zz_decode_RS2_3[24] = memory_SHIFT_RIGHT[7];
    _zz_decode_RS2_3[25] = memory_SHIFT_RIGHT[6];
    _zz_decode_RS2_3[26] = memory_SHIFT_RIGHT[5];
    _zz_decode_RS2_3[27] = memory_SHIFT_RIGHT[4];
    _zz_decode_RS2_3[28] = memory_SHIFT_RIGHT[3];
    _zz_decode_RS2_3[29] = memory_SHIFT_RIGHT[2];
    _zz_decode_RS2_3[30] = memory_SHIFT_RIGHT[1];
    _zz_decode_RS2_3[31] = memory_SHIFT_RIGHT[0];
  end

  always @(*) begin
    HazardSimplePlugin_src0Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l48) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l48_1) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l48_2) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l105) begin
      HazardSimplePlugin_src0Hazard = 1'b0;
    end
  end

  always @(*) begin
    HazardSimplePlugin_src1Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l51) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l51_1) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l51_2) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l108) begin
      HazardSimplePlugin_src1Hazard = 1'b0;
    end
  end

  assign HazardSimplePlugin_writeBackWrites_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
  assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
  assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_decode_RS2_1;
  assign HazardSimplePlugin_addr0Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19 : 15]);
  assign HazardSimplePlugin_addr1Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l47 = 1'b1;
  assign when_HazardSimplePlugin_l48 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58 = (1'b0 || (! when_HazardSimplePlugin_l47));
  assign when_HazardSimplePlugin_l48_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_1 = (1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign when_HazardSimplePlugin_l48_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_2 = (1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign when_HazardSimplePlugin_l105 = (! decode_RS1_USE);
  assign when_HazardSimplePlugin_l108 = (! decode_RS2_USE);
  assign when_HazardSimplePlugin_l113 = (decode_arbitration_isValid && (HazardSimplePlugin_src0Hazard || HazardSimplePlugin_src1Hazard));
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign switch_Misc_l245_1 = execute_INSTRUCTION[14 : 12];
  always @(*) begin
    case(switch_Misc_l245_1)
      3'b000 : begin
        _zz_execute_BRANCH_DO = execute_BranchPlugin_eq;
      end
      3'b001 : begin
        _zz_execute_BRANCH_DO = (! execute_BranchPlugin_eq);
      end
      3'b101 : begin
        _zz_execute_BRANCH_DO = (! execute_SRC_LESS);
      end
      3'b111 : begin
        _zz_execute_BRANCH_DO = (! execute_SRC_LESS);
      end
      default : begin
        _zz_execute_BRANCH_DO = execute_SRC_LESS;
      end
    endcase
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_INC : begin
        _zz_execute_BRANCH_DO_1 = 1'b0;
      end
      BranchCtrlEnum_JAL : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BRANCH_DO_1 = 1'b1;
      end
      default : begin
        _zz_execute_BRANCH_DO_1 = _zz_execute_BRANCH_DO;
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == BranchCtrlEnum_JALR) ? execute_RS1 : execute_PC);
  assign _zz_execute_BranchPlugin_branch_src2 = _zz__zz_execute_BranchPlugin_branch_src2[19];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_1[10] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[9] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[8] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[7] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[6] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[5] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[4] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[3] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[2] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[1] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[0] = _zz_execute_BranchPlugin_branch_src2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_2 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_3[19] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[18] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[17] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[16] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[15] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[14] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[13] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[12] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[11] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[10] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[9] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[8] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[7] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[6] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[5] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[4] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[3] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[2] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[1] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[0] = _zz_execute_BranchPlugin_branch_src2_2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_4 = _zz__zz_execute_BranchPlugin_branch_src2_4[11];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_5[18] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[17] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[16] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[15] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[14] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[13] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[12] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[11] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[10] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[9] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[8] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[7] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[6] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[5] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[4] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[3] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[2] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[1] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[0] = _zz_execute_BranchPlugin_branch_src2_4;
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      BranchCtrlEnum_JAL : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {{_zz_execute_BranchPlugin_branch_src2_1,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      BranchCtrlEnum_JALR : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {_zz_execute_BranchPlugin_branch_src2_3,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_execute_BranchPlugin_branch_src2_6 = {{_zz_execute_BranchPlugin_branch_src2_5,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_execute_BranchPlugin_branch_src2_6;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  assign when_Pipeline_l124 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_1 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_2 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_3 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_4 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_5 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_6 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_7 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_8 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_INT4_OP_1 = decode_INT4_OP;
  assign _zz_decode_INT4_OP = _zz_decode_INT4_OP_1;
  assign when_Pipeline_l124_9 = (! execute_arbitration_isStuck);
  assign _zz_execute_INT4_OP = decode_to_execute_INT4_OP;
  assign when_Pipeline_l124_10 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_11 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_12 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_13 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_14 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_15 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_16 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_17 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_18 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_19 = (! execute_arbitration_isStuck);
  assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1;
  assign when_Pipeline_l124_20 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_21 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_22 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_23 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1;
  assign when_Pipeline_l124_24 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_25 = (! memory_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL;
  assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1;
  assign when_Pipeline_l124_26 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL;
  assign when_Pipeline_l124_27 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL;
  assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1;
  assign when_Pipeline_l124_28 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL;
  assign _zz_execute_to_memory_SHIFT_CTRL_1 = execute_SHIFT_CTRL;
  assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1;
  assign when_Pipeline_l124_29 = (! execute_arbitration_isStuck);
  assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL;
  assign when_Pipeline_l124_30 = (! memory_arbitration_isStuck);
  assign _zz_memory_SHIFT_CTRL = execute_to_memory_SHIFT_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL;
  assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1;
  assign when_Pipeline_l124_31 = (! execute_arbitration_isStuck);
  assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL;
  assign when_Pipeline_l124_32 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_33 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_34 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_35 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_36 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_37 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_38 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_39 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_40 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_41 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_42 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_43 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_44 = (! writeBack_arbitration_isStuck);
  assign decode_arbitration_isFlushed = ((|{writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}}) || (|{writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}}));
  assign execute_arbitration_isFlushed = ((|{writeBack_arbitration_flushNext,memory_arbitration_flushNext}) || (|{writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}}));
  assign memory_arbitration_isFlushed = ((|writeBack_arbitration_flushNext) || (|{writeBack_arbitration_flushIt,memory_arbitration_flushIt}));
  assign writeBack_arbitration_isFlushed = (1'b0 || (|writeBack_arbitration_flushIt));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign when_Pipeline_l151 = ((! execute_arbitration_isStuck) || execute_arbitration_removeIt);
  assign when_Pipeline_l154 = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign when_Pipeline_l151_1 = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  assign when_Pipeline_l154_1 = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign when_Pipeline_l151_2 = ((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt);
  assign when_Pipeline_l154_2 = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      IBusSimplePlugin_fetchPc_pcReg <= 32'h80000000;
      IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      IBusSimplePlugin_fetchPc_booted <= 1'b0;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      _zz_IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid <= 1'b0;
      _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      IBusSimplePlugin_pending_value <= 3'b000;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= 3'b000;
      _zz_5 <= 1'b1;
      HazardSimplePlugin_writeBackBuffer_valid <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
    end else begin
      if(IBusSimplePlugin_fetchPc_correction) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b1;
      end
      if(IBusSimplePlugin_fetchPc_output_fire) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      end
      IBusSimplePlugin_fetchPc_booted <= 1'b1;
      if(when_Fetcher_l133) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_output_fire) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(when_Fetcher_l133_1) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(when_Fetcher_l160) begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      if(IBusSimplePlugin_iBusRsp_flush) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid <= 1'b0;
      end
      if(IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_ready) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_m2sPipe_valid <= (IBusSimplePlugin_iBusRsp_stages_0_output_toEvent_valid && (! 1'b0));
      end
      if(decode_arbitration_removeIt) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      end
      if(IBusSimplePlugin_iBusRsp_output_ready) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= (IBusSimplePlugin_iBusRsp_output_valid && (! IBusSimplePlugin_externalFlush));
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if(when_Fetcher_l331) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(when_Fetcher_l331_1) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(when_Fetcher_l331_2) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(when_Fetcher_l331_3) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= IBusSimplePlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      if(when_Fetcher_l331_4) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= IBusSimplePlugin_injector_nextPcCalc_valids_3;
      end
      if(IBusSimplePlugin_fetchPc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_4 <= 1'b0;
      end
      IBusSimplePlugin_pending_value <= IBusSimplePlugin_pending_next;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter - _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter);
      if(IBusSimplePlugin_iBusRsp_flush) begin
        IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_pending_value - _zz_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2);
      end
      _zz_5 <= 1'b0;
      HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid;
      if(when_Pipeline_l151) begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154) begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(when_Pipeline_l151_1) begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_1) begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(when_Pipeline_l151_2) begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_2) begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
    end
  end

  always @(posedge clk) begin
    if(IBusSimplePlugin_iBusRsp_output_ready) begin
      _zz_IBusSimplePlugin_injector_decodeInput_payload_pc <= IBusSimplePlugin_iBusRsp_output_payload_pc;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error <= IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc <= IBusSimplePlugin_iBusRsp_output_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready) begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
    end
    HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address;
    HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data;
    if(when_Pipeline_l124) begin
      decode_to_execute_PC <= _zz_decode_to_execute_PC;
    end
    if(when_Pipeline_l124_1) begin
      execute_to_memory_PC <= execute_PC;
    end
    if(when_Pipeline_l124_2) begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if(when_Pipeline_l124_3) begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if(when_Pipeline_l124_4) begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if(when_Pipeline_l124_5) begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
    end
    if(when_Pipeline_l124_6) begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_7) begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_8) begin
      decode_to_execute_IS_ALU_INT4 <= decode_IS_ALU_INT4;
    end
    if(when_Pipeline_l124_9) begin
      decode_to_execute_INT4_OP <= _zz_decode_to_execute_INT4_OP;
    end
    if(when_Pipeline_l124_10) begin
      decode_to_execute_INT4_UNSIGNED <= decode_INT4_UNSIGNED;
    end
    if(when_Pipeline_l124_11) begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_12) begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_13) begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_14) begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if(when_Pipeline_l124_15) begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_16) begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_17) begin
      decode_to_execute_IS_DOT_INT4 <= decode_IS_DOT_INT4;
    end
    if(when_Pipeline_l124_18) begin
      decode_to_execute_DOT_UNSIGNED_RS1 <= decode_DOT_UNSIGNED_RS1;
    end
    if(when_Pipeline_l124_19) begin
      decode_to_execute_DOT_UNSIGNED_RS2 <= decode_DOT_UNSIGNED_RS2;
    end
    if(when_Pipeline_l124_20) begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if(when_Pipeline_l124_21) begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_22) begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_23) begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_24) begin
      decode_to_execute_MEMORY_STORE <= decode_MEMORY_STORE;
    end
    if(when_Pipeline_l124_25) begin
      execute_to_memory_MEMORY_STORE <= execute_MEMORY_STORE;
    end
    if(when_Pipeline_l124_26) begin
      decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL;
    end
    if(when_Pipeline_l124_27) begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if(when_Pipeline_l124_28) begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL;
    end
    if(when_Pipeline_l124_29) begin
      decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_30) begin
      execute_to_memory_SHIFT_CTRL <= _zz_execute_to_memory_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_31) begin
      decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL;
    end
    if(when_Pipeline_l124_32) begin
      decode_to_execute_RS1 <= _zz_decode_to_execute_RS1;
    end
    if(when_Pipeline_l124_33) begin
      decode_to_execute_RS2 <= _zz_decode_to_execute_RS2;
    end
    if(when_Pipeline_l124_34) begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if(when_Pipeline_l124_35) begin
      decode_to_execute_SRC1 <= decode_SRC1;
    end
    if(when_Pipeline_l124_36) begin
      decode_to_execute_SRC2 <= decode_SRC2;
    end
    if(when_Pipeline_l124_37) begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_38) begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_39) begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_decode_RS2_2;
    end
    if(when_Pipeline_l124_40) begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_decode_RS2;
    end
    if(when_Pipeline_l124_41) begin
      execute_to_memory_SHIFT_RIGHT <= execute_SHIFT_RIGHT;
    end
    if(when_Pipeline_l124_42) begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if(when_Pipeline_l124_43) begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if(when_Pipeline_l124_44) begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
  end


endmodule

module StreamFifoLowLatency (
  input  wire          io_push_valid,
  output wire          io_push_ready,
  input  wire          io_push_payload_error,
  input  wire [31:0]   io_push_payload_inst,
  output wire          io_pop_valid,
  input  wire          io_pop_ready,
  output wire          io_pop_payload_error,
  output wire [31:0]   io_pop_payload_inst,
  input  wire          io_flush,
  output wire [0:0]    io_occupancy,
  output wire [0:0]    io_availability,
  input  wire          clk,
  input  wire          reset
);

  wire                fifo_io_push_ready;
  wire                fifo_io_pop_valid;
  wire                fifo_io_pop_payload_error;
  wire       [31:0]   fifo_io_pop_payload_inst;
  wire       [0:0]    fifo_io_occupancy;
  wire       [0:0]    fifo_io_availability;

  StreamFifo fifo (
    .io_push_valid         (io_push_valid                 ), //i
    .io_push_ready         (fifo_io_push_ready            ), //o
    .io_push_payload_error (io_push_payload_error         ), //i
    .io_push_payload_inst  (io_push_payload_inst[31:0]    ), //i
    .io_pop_valid          (fifo_io_pop_valid             ), //o
    .io_pop_ready          (io_pop_ready                  ), //i
    .io_pop_payload_error  (fifo_io_pop_payload_error     ), //o
    .io_pop_payload_inst   (fifo_io_pop_payload_inst[31:0]), //o
    .io_flush              (io_flush                      ), //i
    .io_occupancy          (fifo_io_occupancy             ), //o
    .io_availability       (fifo_io_availability          ), //o
    .clk                   (clk                           ), //i
    .reset                 (reset                         )  //i
  );
  assign io_push_ready = fifo_io_push_ready;
  assign io_pop_valid = fifo_io_pop_valid;
  assign io_pop_payload_error = fifo_io_pop_payload_error;
  assign io_pop_payload_inst = fifo_io_pop_payload_inst;
  assign io_occupancy = fifo_io_occupancy;
  assign io_availability = fifo_io_availability;

endmodule

module StreamFifo (
  input  wire          io_push_valid,
  output reg           io_push_ready,
  input  wire          io_push_payload_error,
  input  wire [31:0]   io_push_payload_inst,
  output reg           io_pop_valid,
  input  wire          io_pop_ready,
  output reg           io_pop_payload_error,
  output reg  [31:0]   io_pop_payload_inst,
  input  wire          io_flush,
  output wire [0:0]    io_occupancy,
  output wire [0:0]    io_availability,
  input  wire          clk,
  input  wire          reset
);

  reg                 oneStage_doFlush;
  wire                oneStage_buffer_valid;
  wire                oneStage_buffer_ready;
  wire                oneStage_buffer_payload_error;
  wire       [31:0]   oneStage_buffer_payload_inst;
  reg                 io_push_rValid;
  reg                 io_push_rData_error;
  reg        [31:0]   io_push_rData_inst;
  wire                when_Stream_l477;
  wire                when_Stream_l1432;

  always @(*) begin
    oneStage_doFlush = io_flush;
    if(when_Stream_l1432) begin
      if(io_pop_ready) begin
        oneStage_doFlush = 1'b1;
      end
    end
  end

  always @(*) begin
    io_push_ready = oneStage_buffer_ready;
    if(when_Stream_l477) begin
      io_push_ready = 1'b1;
    end
  end

  assign when_Stream_l477 = (! oneStage_buffer_valid);
  assign oneStage_buffer_valid = io_push_rValid;
  assign oneStage_buffer_payload_error = io_push_rData_error;
  assign oneStage_buffer_payload_inst = io_push_rData_inst;
  always @(*) begin
    io_pop_valid = oneStage_buffer_valid;
    if(when_Stream_l1432) begin
      io_pop_valid = io_push_valid;
    end
  end

  assign oneStage_buffer_ready = io_pop_ready;
  always @(*) begin
    io_pop_payload_error = oneStage_buffer_payload_error;
    if(when_Stream_l1432) begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @(*) begin
    io_pop_payload_inst = oneStage_buffer_payload_inst;
    if(when_Stream_l1432) begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign io_occupancy = oneStage_buffer_valid;
  assign io_availability = (! oneStage_buffer_valid);
  assign when_Stream_l1432 = (! oneStage_buffer_valid);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      io_push_rValid <= 1'b0;
    end else begin
      if(io_push_ready) begin
        io_push_rValid <= io_push_valid;
      end
      if(oneStage_doFlush) begin
        io_push_rValid <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(io_push_ready) begin
      io_push_rData_error <= io_push_payload_error;
      io_push_rData_inst <= io_push_payload_inst;
    end
  end


endmodule
