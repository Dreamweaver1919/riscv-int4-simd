// =====================================================================
// exp_values.vh -- expected results baked into the PL for self-check
// Generated from build/expected.hex (34 words, the golden model output).
// =====================================================================
//  exp_mem[i] returns the expected value for test case i (i < 34).
// =====================================================================
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
