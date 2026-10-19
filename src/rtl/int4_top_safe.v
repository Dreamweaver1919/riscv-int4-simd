// =====================================================================
// int4_top_safe.v -- ZERO-RISK KV260 build (VexRiscv + INT4 SIMD)
//
// PS supplies ONLY pl_clk0 / pl_resetn0. All PS AXI masters are disabled,
// so the running Linux can never be stalled by this PL design.
// Debug access is via JTAG-to-AXI Master (xsdb mrd/mwr from the host).
//
// CPU memory map (identical to sim/tb_full.v):
//   0x8000_0000 + 4*i   instruction i  (ROM 512 words, baked in)
//   0x8000_1000 + 4*j   data word j    (RAM 4096 words)
//   0x8000_1800         completion flag = 0xDEADBEEF
//
// AXI4-Lite register map (JTAG-to-AXI window):
//   0x0000 .. 0x3FFC    dmem word n (n = addr[13:2])   read/write
//   0x4000              CTRL    [0] 1 = run, 0 = hold
//   0x4004              STATUS  [0] run, [1] done
//   0x4008              ID      0x1A7C0DE5
//   0x400C              DBG     last iBus PC
//
// AXI writes go through an explicit one-cycle command pulse so no stale
// address can leak into the memory write port.
// =====================================================================
`timescale 1ns / 1ps

module int4_top_safe (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [31:0] s_axi_awaddr,
    input  wire        s_axi_awvalid,
    output wire        s_axi_awready,
    input  wire [31:0] s_axi_wdata,
    input  wire [3:0]  s_axi_wstrb,
    input  wire        s_axi_wvalid,
    output wire        s_axi_wready,
    output wire [1:0]  s_axi_bresp,
    output wire        s_axi_bvalid,
    input  wire        s_axi_bready,
    input  wire [31:0] s_axi_araddr,
    input  wire        s_axi_arvalid,
    output wire        s_axi_arready,
    output wire [31:0] s_axi_rdata,
    output wire [1:0]  s_axi_rresp,
    output wire        s_axi_rvalid,
    input  wire        s_axi_rready,

    output wire [31:0] dbg_pc,
    output wire        dbg_done
);

    `include "imem_init.vh"

    `include "exp_values.vh"

    localparam [31:0] RAM_BASE = 32'h8000_1000;
    localparam [31:0] REG_OFF  = 32'h0000_4000;

    // =================================================================
    // Reset + CPU run control
    // =================================================================
    reg [3:0] rst_cnt = 4'd0;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)           rst_cnt <= 4'd0;
        else if (!rst_cnt[3]) rst_cnt <= rst_cnt + 1'b1;
    end
    wire pl_rst_n = rst_cnt[3];

    reg cpu_run;
    initial cpu_run = 1'b1;              // auto-start after PL load
    always @(posedge clk or negedge pl_rst_n) begin
        if (!pl_rst_n) cpu_run <= 1'b1;  // default: running
    end
    wire cpu_reset = ~cpu_run | ~pl_rst_n;

    // =================================================================
    // CPU
    // =================================================================
    wire        iBus_cmd_valid, iBus_cmd_ready;
    wire [31:0] iBus_cmd_payload_pc;
    wire        iBus_rsp_valid, iBus_rsp_payload_error;
    wire [31:0] iBus_rsp_payload_inst;

    wire        dBus_cmd_valid, dBus_cmd_ready, dBus_cmd_payload_wr;
    wire [3:0]  dBus_cmd_payload_mask;
    wire [31:0] dBus_cmd_payload_address, dBus_cmd_payload_data;
    wire [1:0]  dBus_cmd_payload_size;
    wire        dBus_rsp_ready, dBus_rsp_error;
    wire [31:0] dBus_rsp_data;

    VexRiscv cpu (
        .clk(clk), .reset(cpu_reset),
        .iBus_cmd_valid(iBus_cmd_valid),
        .iBus_cmd_ready(iBus_cmd_ready),
        .iBus_cmd_payload_pc(iBus_cmd_payload_pc),
        .iBus_rsp_valid(iBus_rsp_valid),
        .iBus_rsp_payload_error(iBus_rsp_payload_error),
        .iBus_rsp_payload_inst(iBus_rsp_payload_inst),
        .dBus_cmd_valid(dBus_cmd_valid),
        .dBus_cmd_ready(dBus_cmd_ready),
        .dBus_cmd_payload_wr(dBus_cmd_payload_wr),
        .dBus_cmd_payload_mask(dBus_cmd_payload_mask),
        .dBus_cmd_payload_address(dBus_cmd_payload_address),
        .dBus_cmd_payload_data(dBus_cmd_payload_data),
        .dBus_cmd_payload_size(dBus_cmd_payload_size),
        .dBus_rsp_ready(dBus_rsp_ready),
        .dBus_rsp_error(dBus_rsp_error),
        .dBus_rsp_data(dBus_rsp_data)
    );

    // =================================================================
    // Instruction ROM
    // =================================================================
    reg [31:0] imem [0:511];
    integer ii;
    initial for (ii = 0; ii < 512; ii = ii + 1) imem[ii] = imem_init(ii[12:0]);

    reg [8:0]  i_addr_r;
    reg        i_pend;
    reg [31:0] last_pc;

    assign iBus_cmd_ready         = ~i_pend;
    assign iBus_rsp_valid         = i_pend;
    assign iBus_rsp_payload_error = 1'b0;
    assign iBus_rsp_payload_inst  = imem[i_addr_r];

    always @(posedge clk) begin
        if (cpu_reset) begin
            i_pend   <= 1'b0;
            i_addr_r <= 9'd0;
        end else if (iBus_cmd_valid && iBus_cmd_ready) begin
            i_addr_r <= iBus_cmd_payload_pc[10:2];
            last_pc  <= iBus_cmd_payload_pc;
            i_pend   <= 1'b1;
        end else begin
            i_pend <= 1'b0;
        end
    end

    // =================================================================
    // Data RAM
    // =================================================================
    reg [31:0] dmem [0:4095];
    integer di;
    initial for (di = 0; di < 4096; di = di + 1) dmem[di] = 32'h0;

    reg [11:0] d_addr_r;
    reg        d_pend, d_wr_r;
    assign dBus_cmd_ready = ~d_pend;
    assign dBus_rsp_ready = d_pend;
    assign dBus_rsp_error = 1'b0;
    assign dBus_rsp_data  = (d_pend && !d_wr_r) ? dmem[d_addr_r] : 32'h0;

    wire [31:0] d_off = dBus_cmd_payload_address - RAM_BASE;

    always @(posedge clk) begin
        if (cpu_reset) begin
            d_pend <= 1'b0; d_wr_r <= 1'b0; d_addr_r <= 12'd0;
        end else if (dBus_cmd_valid && dBus_cmd_ready) begin
            d_addr_r <= d_off[13:2];
            d_wr_r   <= dBus_cmd_payload_wr;
            d_pend   <= 1'b1;
        end else begin
            d_pend <= 1'b0;
        end
    end

    // -----------------------------------------------------------------
    // Write port arbitration: AXI pulse has priority, CPU write is direct
    // -----------------------------------------------------------------
    reg        axi_wr_go;
    reg [11:0] axi_wa_q;
    reg [31:0] axi_wd_q;
    reg [3:0]  axi_ws_q;

    always @(posedge clk) begin
        if (axi_wr_go) begin
            if (axi_ws_q[0]) dmem[axi_wa_q][7:0]   <= axi_wd_q[7:0];
            if (axi_ws_q[1]) dmem[axi_wa_q][15:8]  <= axi_wd_q[15:8];
            if (axi_ws_q[2]) dmem[axi_wa_q][23:16] <= axi_wd_q[23:16];
            if (axi_ws_q[3]) dmem[axi_wa_q][31:24] <= axi_wd_q[31:24];
        end else if (!cpu_reset && dBus_cmd_valid && dBus_cmd_ready && dBus_cmd_payload_wr) begin
            if (dBus_cmd_payload_mask[0]) dmem[d_off[13:2]][7:0]   <= dBus_cmd_payload_data[7:0];
            if (dBus_cmd_payload_mask[1]) dmem[d_off[13:2]][15:8]  <= dBus_cmd_payload_data[15:8];
            if (dBus_cmd_payload_mask[2]) dmem[d_off[13:2]][23:16] <= dBus_cmd_payload_data[23:16];
            if (dBus_cmd_payload_mask[3]) dmem[d_off[13:2]][31:24] <= dBus_cmd_payload_data[31:24];
        end
    end

    // done flag
    reg done_r;
    always @(posedge clk) begin
        if (!pl_rst_n) done_r <= 1'b0;
        else if (!cpu_reset && dBus_cmd_valid && dBus_cmd_ready && dBus_cmd_payload_wr
                 && d_off[13:2] == 12'd512 && dBus_cmd_payload_data == 32'hDEADBEEF)
            done_r <= 1'b1;
    end

    assign dbg_pc   = last_pc;
    assign dbg_done = done_r;

    // =================================================================
    // AXI4-Lite slave
    // =================================================================
    reg        bvalid_r;
    reg [31:0] aw_q;
    reg        aw_v;
    reg [1:0]  r_st;
    reg [31:0] ar_q;
    reg [31:0] rdata_r;
    reg        rvalid_r;

    assign s_axi_awready = 1'b1;
    assign s_axi_wready  = 1'b1;
    assign s_axi_bvalid  = bvalid_r;
    assign s_axi_bresp   = 2'b00;

    assign s_axi_arready = 1'b1;
    assign s_axi_rvalid  = rvalid_r;
    assign s_axi_rdata   = rdata_r;
    assign s_axi_rresp   = 2'b00;

    // Is this write destined for the control register?
    wire wr_to_reg = s_axi_awvalid ? (s_axi_awaddr == REG_OFF)
                                   : (aw_v && (aw_q == REG_OFF));
    wire [31:0] wr_addr_sel = s_axi_awvalid ? s_axi_awaddr : aw_q;

    always @(posedge clk or negedge pl_rst_n) begin
        if (!pl_rst_n) begin
            bvalid_r  <= 1'b0;
            aw_q      <= 32'd0;
            aw_v      <= 1'b0;
            axi_wr_go <= 1'b0;
            axi_wa_q  <= 12'd0;
            axi_wd_q  <= 32'd0;
            axi_ws_q  <= 4'd0;
            r_st      <= 2'd0;
            ar_q      <= 32'd0;
            rdata_r   <= 32'd0;
            rvalid_r  <= 1'b0;
            cpu_run   <= 1'b1;
        end else begin
            axi_wr_go <= 1'b0;

            // -------- AW capture --------
            if (s_axi_awvalid) begin
                aw_q <= s_axi_awaddr;
                aw_v <= 1'b1;
            end

            // -------- W capture + execute --------
            if (s_axi_wvalid) begin
                if (wr_to_reg) begin
                    // control register write; memory untouched
                    cpu_run <= s_axi_wdata[0];
                end else begin
                    axi_wr_go <= 1'b1;
                    axi_wa_q  <= wr_addr_sel[13:2];
                    axi_wd_q  <= s_axi_wdata;
                    axi_ws_q  <= s_axi_wstrb;
                end
                bvalid_r <= 1'b1;
            end else if (bvalid_r && s_axi_bready) begin
                bvalid_r <= 1'b0;
                aw_v     <= 1'b0;
            end

            // -------- AR / R --------
            case (r_st)
              2'd0: begin
                  rvalid_r <= 1'b0;
                  if (s_axi_arvalid) begin
                      ar_q <= s_axi_araddr;
                      r_st <= 2'd1;
                  end
              end
              2'd1: r_st <= 2'd2;
              2'd2: begin
                  if (ar_q < 32'h0000_4000)      rdata_r <= dmem[ar_q[13:2]];
                  else if (ar_q == REG_OFF)      rdata_r <= {31'd0, cpu_run};
                  else if (ar_q == REG_OFF + 4)  rdata_r <= status_word;
                  else if (ar_q == REG_OFF + 8)  rdata_r <= 32'h1A7C0DE5;
                  else if (ar_q == REG_OFF + 12) rdata_r <= last_pc;
                  else                           rdata_r <= 32'h0;
                  rvalid_r <= 1'b1;
                  r_st <= 2'd3;
              end
              2'd3: begin
                  if (s_axi_rready) begin
                      rvalid_r <= 1'b0;
                      r_st <= 2'd0;
                  end
              end
              default: r_st <= 2'd0;
            endcase
        end
    end

    // =================================================================
    // Hardware self-check
    // After done_r rises, walk dmem[0..33] and compare with exp_values.vh.
    // chk_done / chk_fail / chk_mismatch are exposed in STATUS.
    // =================================================================
    reg [5:0]  chk_idx;
    reg        chk_busy;
    reg        chk_finished;
    reg        chk_failed;
    reg [7:0]  chk_errs;
    reg [1:0]  chk_st;

    always @(posedge clk or negedge pl_rst_n) begin
        if (!pl_rst_n) begin
            chk_idx      <= 6'd0;
            chk_busy     <= 1'b0;
            chk_finished <= 1'b0;
            chk_failed   <= 1'b0;
            chk_errs     <= 8'd0;
            chk_st       <= 2'd0;
        end else begin
            case (chk_st)
              2'd0: begin
                  if (done_r) begin
                      chk_idx  <= 6'd0;
                      chk_errs <= 8'd0;
                      chk_failed <= 1'b0;
                      chk_busy <= 1'b1;
                      chk_st   <= 2'd1;
                  end
              end
              2'd1: chk_st <= 2'd2;                 // let dmem read settle
              2'd2: begin
                  if (dmem[{6'd0, chk_idx}] != exp_mem(chk_idx)) begin
                      chk_failed <= 1'b1;
                      chk_errs   <= chk_errs + 8'd1;
                  end
                  if (chk_idx == 6'd33) begin
                      chk_finished <= 1'b1;
                      chk_busy     <= 1'b0;
                      chk_st       <= 2'd3;
                  end else begin
                      chk_idx <= chk_idx + 6'd1;
                      chk_st  <= 2'd1;
                  end
              end
              2'd3: chk_st <= 2'd3;                 // hold until reload
              default: chk_st <= 2'd0;
            endcase
        end
    end

    // STATUS word layout:
    //   [31:16] reserved
    //   [15:8]  chk_errs   (number of mismatching cases)
    //   [7]     chk_failed
    //   [6]     chk_finished
    //   [5:2]   reserved
    //   [1]     done_r
    //   [0]     cpu_run
    wire [31:0] status_word = {16'd0, chk_errs, chk_failed, chk_finished,
                               4'd0, done_r, cpu_run};
endmodule
