// =====================================================================
// tb_int4_safe.v -- behavioural testbench for int4_top_safe
//
// Instantiates int4_top_safe with the JTAG-side AXI4-Lite slave left
// idle, lets the CPU free-run from the baked-in instruction ROM, then
// checks the completion flag and every result word against the golden
// values in exp_values.vh.
//
// Run: Vivado -> Flow -> Run Simulation -> Run Behavioural Simulation
// =====================================================================
`timescale 1ns / 1ps

module tb_int4_safe;

    localparam CLK_PERIOD = 10;      // 100 MHz
    localparam N_CASES    = 34;

    reg clk   = 0;
    reg rst_n = 0;

    always #(CLK_PERIOD/2) clk = ~clk;

    // ---------------- DUT AXI-Lite port (unused here) ----------------
    wire [31:0] s_axi_awaddr  = 32'h0;
    wire        s_axi_awvalid = 1'b0;
    wire        s_axi_awready;
    wire [31:0] s_axi_wdata   = 32'h0;
    wire [3:0]  s_axi_wstrb   = 4'h0;
    wire        s_axi_wvalid  = 1'b0;
    wire        s_axi_wready;
    wire [1:0]  s_axi_bresp;
    wire        s_axi_bvalid;
    wire        s_axi_bready  = 1'b1;
    wire [31:0] s_axi_araddr  = 32'h0;
    wire        s_axi_arvalid = 1'b0;
    wire        s_axi_arready;
    wire [31:0] s_axi_rdata;
    wire [1:0]  s_axi_rresp;
    wire        s_axi_rvalid;
    wire        s_axi_rready  = 1'b1;

    wire [31:0] dbg_pc;
    wire        dbg_done;

    // ---------------- DUT ----------------
    int4_top_safe dut (
        .clk           (clk),
        .rst_n         (rst_n),
        .s_axi_awaddr  (s_axi_awaddr),
        .s_axi_awvalid (s_axi_awvalid),
        .s_axi_awready (s_axi_awready),
        .s_axi_wdata   (s_axi_wdata),
        .s_axi_wstrb   (s_axi_wstrb),
        .s_axi_wvalid  (s_axi_wvalid),
        .s_axi_wready  (s_axi_wready),
        .s_axi_bresp   (s_axi_bresp),
        .s_axi_bvalid  (s_axi_bvalid),
        .s_axi_bready  (s_axi_bready),
        .s_axi_araddr  (s_axi_araddr),
        .s_axi_arvalid (s_axi_arvalid),
        .s_axi_arready (s_axi_arready),
        .s_axi_rdata   (s_axi_rdata),
        .s_axi_rresp   (s_axi_rresp),
        .s_axi_rvalid  (s_axi_rvalid),
        .s_axi_rready  (s_axi_rready),
        .dbg_pc        (dbg_pc),
        .dbg_done      (dbg_done)
    );

    // ---------------- golden values ----------------
    // exp_mem() comes from exp_values.vh which the DUT also includes.
    function [31:0] exp_mem;
        input [5:0] idx;
        begin
            case (idx)
                6'd0 : exp_mem = 32'h00000000;
                6'd1 : exp_mem = 32'h77777777;
                6'd2 : exp_mem = 32'h88888888;
                6'd3 : exp_mem = 32'h88888888;
                6'd4 : exp_mem = 32'hFFFFFFFF;
                6'd5 : exp_mem = 32'hFFFFFFFF;
                6'd6 : exp_mem = 32'h77777777;
                6'd7 : exp_mem = 32'h00000000;
                6'd8 : exp_mem = 32'h12345670;
                6'd9 : exp_mem = 32'h9ABCDEF8;
                6'd10: exp_mem = 32'h9ABCDEF8;
                6'd11: exp_mem = 32'h12345670;
                6'd12: exp_mem = 32'h0FFE0FFE;
                6'd13: exp_mem = 32'h00000000;
                6'd14: exp_mem = 32'h00000708;
                6'd15: exp_mem = 32'hFFFFFF88;
                6'd16: exp_mem = 32'h00000008;
                6'd17: exp_mem = 32'h00000002;
                6'd18: exp_mem = 32'h00000010;
                6'd19: exp_mem = 32'h4487F11C;
                6'd20: exp_mem = 32'h259E0D0E;
                6'd21: exp_mem = 32'h00000161;
                6'd22: exp_mem = 32'hFFFFFFB8;
                6'd23: exp_mem = 32'h00000045;
                6'd24: exp_mem = 32'hE2CE8848;
                6'd25: exp_mem = 32'hE8D90D94;
                6'd26: exp_mem = 32'h0000026C;
                6'd27: exp_mem = 32'hFFFFFFA9;
                6'd28: exp_mem = 32'h00000055;
                6'd29: exp_mem = 32'h4E8E12A3;
                6'd30: exp_mem = 32'h8D18FEC9;
                6'd31: exp_mem = 32'h000001C5;
                6'd32: exp_mem = 32'hFFFFFF0B;
                6'd33: exp_mem = 32'h00000029;
                default: exp_mem = 32'h0;
            endcase
        end
    endfunction

    // ---------------- test flow ----------------
    integer i;
    integer pass_cnt;
    integer fail_cnt;
    integer cycles;
    reg [31:0] got;

    initial begin
        pass_cnt = 0;
        fail_cnt = 0;
        cycles   = 0;

        $display("");
        $display("==================================================================");
        $display("  int4_top_safe -- VexRiscv + INT4 SIMD behavioural simulation");
        $display("==================================================================");

        // reset
        rst_n = 0;
        repeat (20) @(posedge clk);
        rst_n = 1;
        $display("  reset released, CPU free-running...");

        // wait for the program to raise the completion flag
        while (!dbg_done && cycles < 20000) begin
            cycles = cycles + 1;
            @(posedge clk);
        end

        if (!dbg_done) begin
            $display("  [FAIL] completion flag never set (timeout)");
            $display("         last PC = 0x%08X", dbg_pc);
            $display("==================================================================");
            $finish;
        end

        $display("  [OK] program finished in %0d cycles, last PC = 0x%08X",
                 cycles, dbg_pc);
        $display("");
        $display("   %-4s %-10s %-10s %-6s", "#", "result", "expected", "check");
        $display("   %s", {44{"-"}});

        for (i = 0; i < N_CASES; i = i + 1) begin
            got = dut.dmem[i];
            if (got === exp_mem(i[5:0])) begin
                pass_cnt = pass_cnt + 1;
                $display("   %-4d 0x%08X  0x%08X  PASS", i, got, exp_mem(i[5:0]));
            end else begin
                fail_cnt = fail_cnt + 1;
                $display("   %-4d 0x%08X  0x%08X  FAIL (xor=0x%08X)",
                         i, got, exp_mem(i[5:0]), got ^ exp_mem(i[5:0]));
            end
        end

        $display("");
        $display("==================================================================");
        $display("   total %0d | PASS %0d | FAIL %0d", N_CASES, pass_cnt, fail_cnt);
        if (fail_cnt == 0)
            $display("   ALL PASS - simulation matches the golden model");
        else
            $display("   MISMATCH");
        $display("==================================================================");
        $display("");
        $finish;
    end

endmodule
