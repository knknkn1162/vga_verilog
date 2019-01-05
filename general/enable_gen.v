`ifndef _enable_gen
`define _enable_gen

`include "counter_en.v"

module enable_gen #(
  parameter BIT_SIZE = 6
) (
  input wire clk, i_sclr,
  output wire o_en
);

  wire [BIT_SIZE-1:0] w_cnt;
  counter_en #(BIT_SIZE) counter_en0(
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(1'b1),
    .o_cnt(w_cnt)
  );

  assign o_en = (w_cnt == {BIT_SIZE{1'b0}}) ? 1'b1 : 1'b0;
endmodule

`endif
