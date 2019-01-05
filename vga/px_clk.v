`ifndef _px_clk
`define _px_clk

`include "toggle.v"

module px_clk (
  input wire clk, i_sclr,
  output wire o_px_clk,
  output wire o_ven
);

  localparam WIDTH = 800;
  toggle #(1'b0) toggle0 (
    .clk(clk),
    .i_sclr(i_sclr),
    .i_en(1'b1),
    .o_sw(o_px_clk)
  );

  enableN_gen #(WIDTH*2, 11) (
    .clk(clk), .i_sclr(i_sclr),
    .o_en(o_ven)
  );

endmodule

`endif
