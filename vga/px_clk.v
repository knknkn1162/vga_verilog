`ifndef _px_clk
`define _px_clk

`include "toggle.v"

module px_clk (
  input wire clk, i_sclr_n,
  output wire o_px_clk
);

  wire s_sclr, s_toggle_en;

  assign s_sclr = ~i_sclr_n;

  toggle #(1'b0) toggle0 (
    .clk(clk),
    .i_sclr(s_sclr),
    .i_en(1'b1),
    .o_sw(o_px_clk)
  );

endmodule

`endif
