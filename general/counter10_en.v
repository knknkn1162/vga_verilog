`ifndef _counter10_en
`define _counter10_en

`include "flopr_en.v"

module counter10_en (
  input wire clk, i_sclr, i_en,
  output wire [3:0] o_cnt
);

  wire [3:0] w_cnt_0, w_cnt_1;
  flopr_en #(4) flopr_en0(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(i_en),
    .i_a(w_cnt_0),
    .o_y(w_cnt_1)
  );

  assign w_cnt_0 = (w_cnt_1 == 4'd9) ? 4'd0 : w_cnt_1 + 1'b1;
  assign o_cnt = w_cnt_1;
endmodule

`endif
