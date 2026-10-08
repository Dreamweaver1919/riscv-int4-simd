// =====================================================================
// tb_full.v —— VexRiscv + SimdPlugin 完整端到端验证（修正版）
//
// 内存模型: dBus 覆盖 0x80001000 起 512 字（用地址偏移 [8:2] 索引）
//   结果区   : 0x80001000 + i*4   →  mem[i]
//   完成标志 : 0x80001800         →  mem[0x800>>2 = 512]
// =====================================================================
`timescale 1ns / 1ps
module tb_full;

    localparam IBUS_WORDS = 512;
    localparam DBUS_WORDS = 1024;      // 够覆盖 0x80001800
    localparam MAX_CASES  = 64;        // 上限，实际数量从 n_cases.txt 读

    reg clk = 0, reset = 1; always #5 clk = ~clk;

    // 波形输出（需 Verilator --trace）
    initial begin
        $dumpfile("sim.fst");
        $dumpvars(0, tb_full);
    end

    wire iBus_cmd_valid,iBus_cmd_ready,iBus_rsp_valid,iBus_rsp_payload_error;
    wire [31:0] iBus_cmd_payload_pc,iBus_rsp_payload_inst;
    wire dBus_cmd_valid,dBus_cmd_ready,dBus_cmd_payload_wr,dBus_rsp_ready,dBus_rsp_error;
    wire [3:0] dBus_cmd_payload_mask;
    wire [31:0] dBus_cmd_payload_address,dBus_cmd_payload_data,dBus_rsp_data;
    wire [1:0] dBus_cmd_payload_size;

    VexRiscv dut(.clk(clk),.reset(reset),
        .iBus_cmd_valid(iBus_cmd_valid),.iBus_cmd_ready(iBus_cmd_ready),
        .iBus_cmd_payload_pc(iBus_cmd_payload_pc),.iBus_rsp_valid(iBus_rsp_valid),
        .iBus_rsp_payload_error(iBus_rsp_payload_error),.iBus_rsp_payload_inst(iBus_rsp_payload_inst),
        .dBus_cmd_valid(dBus_cmd_valid),.dBus_cmd_ready(dBus_cmd_ready),
        .dBus_cmd_payload_wr(dBus_cmd_payload_wr),.dBus_cmd_payload_mask(dBus_cmd_payload_mask),
        .dBus_cmd_payload_address(dBus_cmd_payload_address),.dBus_cmd_payload_data(dBus_cmd_payload_data),
        .dBus_cmd_payload_size(dBus_cmd_payload_size),
        .dBus_rsp_ready(dBus_rsp_ready),.dBus_rsp_error(dBus_rsp_error),.dBus_rsp_data(dBus_rsp_data));

    // ---- 指令存储 ----
    reg [31:0] imem[0:IBUS_WORDS-1];
    reg [31:0] iaddr_r; reg ipend;
    assign iBus_cmd_ready = ~ipend;
    assign iBus_rsp_valid = ipend;
    assign iBus_rsp_payload_inst = imem[iaddr_r[10:2]];
    assign iBus_rsp_payload_error = 1'b0;
    always @(posedge clk) begin
        if (reset) begin ipend<=0; iaddr_r<=32'h80000000; end
        else if (iBus_cmd_valid && iBus_cmd_ready) begin iaddr_r<=iBus_cmd_payload_pc; ipend<=1; end
        else ipend<=0;
    end

    // ---- 数据存储（以 0x80001000 为基准的偏移 [10:2] 索引）----
    localparam [31:0] DBASE = 32'h80001000;
    reg [31:0] mem[0:DBUS_WORDS-1];
    assign dBus_cmd_ready = 1'b1;
    assign dBus_rsp_ready = 1'b1;
    assign dBus_rsp_error = 1'b0;
    assign dBus_rsp_data  = dBus_cmd_payload_wr ? 32'h0
                          : mem[(dBus_cmd_payload_address - DBASE) >> 2];
    integer b;
    always @(posedge clk) begin
        for (b=0;b<4;b=b+1)
            if (dBus_cmd_valid && dBus_cmd_payload_wr && dBus_cmd_payload_mask[b])
                mem[(dBus_cmd_payload_address - DBASE) >> 2][8*b +: 8]
                    <= dBus_cmd_payload_data[8*b +: 8];
    end

    // ---- 验证 ----
    integer i, cycles;
    integer n_cases;
    reg [31:0] expected [0:MAX_CASES-1];
    reg [31:0] flag;
    integer pass_cnt, fail_cnt;
    initial begin
        pass_cnt=0; fail_cnt=0; cycles=0; n_cases=0;
        for (i=0;i<DBUS_WORDS;i=i+1) mem[i]=32'h0;
        for (i=0;i<IBUS_WORDS;i=i+1) imem[i]=32'h00000013;
        $readmemh("program.hex", imem);
        $readmemh("expected.hex", expected);
        begin
            integer nfd;
            nfd = $fopen("n_cases.txt", "r");
            if (nfd == 0) n_cases = MAX_CASES;
            else begin
                $fscanf(nfd, "%d", n_cases);
                $fclose(nfd);
            end
        end
        $display("");
        $display("==================================================================");
        $display("  VexRiscv + SimdPlugin 端到端验证（INT4 SIMD + 点积, custom-1）");
        $display("  参考: expected.hex（独立 Python 黄金模型）");
        $display("==================================================================");
        reset=1; repeat(10) @(posedge clk); reset=0;
        $display("  复位释放，开始执行...\n");
        flag=0;
        while (flag !== 32'hDEADBEEF && cycles < 5000) begin
            cycles = cycles+1;
            @(posedge clk);
            flag = mem[32'h800>>2];
        end
        if (flag !== 32'hDEADBEEF) begin
            $display("  [FAIL] 超时未收到完成标志");
            $finish;
        end
        $display("  [OK] 程序完成，用时 %0d 周期\n", cycles);
        $display("  %-3s %-8s %-8s %-8s %-6s", "#", "结果", "期望", "差异", "判定");
        $display("  %s", {48{"-"}});
        for (i=0;i<n_cases;i=i+1) begin
            if (mem[i] === expected[i]) begin
                pass_cnt = pass_cnt+1;
                $display("  %-3d %08x  %08x  %-8s PASS", i, mem[i], expected[i], "-");
            end else begin
                fail_cnt = fail_cnt+1;
                $display("  %-3d %08x  %08x  %08x  FAIL", i, mem[i], expected[i], mem[i]^expected[i]);
            end
        end
        $display("\n==================================================================");
        $display("  共 %0d 项 | 通过 %0d | 失败 %0d", n_cases, pass_cnt, fail_cnt);
        if (fail_cnt==0) $display("  ✅ 全部通过：硬件与黄金模型一致");
        else             $display("  ❌ %0d 项不一致", fail_cnt);
        $display("==================================================================");
        $finish;
    end
endmodule
