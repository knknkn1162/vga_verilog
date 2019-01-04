`ifndef _vsync
`define _vsync

`include "counterN_en.v"

module vsync (
  input wire clk, i_sclr, i_px_clk,
  output wire o_vga_vsync
);

  localparam VSYNC_COUNTER = 525*800; // line * px
  localparam VSYNC_COUNTER_BIT = 19;
  localparam VSYNC_CLKS = 11'd1600;
  wire [VSYNC_COUNTER_BIT-1:0] s_vsync_cnt;


  counterN_en #(VSYNC_COUNTER, VSYNC_COUNTER_BIT) vsync_counter0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_px_clk), .o_cnt(s_vsync_cnt)
  );

  assign o_vga_vsync = (s_vsync_cnt < VSYNC_CLKS) ? 1'b1 : 1'b0;
endmodule

`endif
