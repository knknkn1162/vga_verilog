`ifndef _hsync
`define _hsync

`include "counterN_en.v"

module hsync (
  input wire clk, i_sclr, i_px_clk,
  output wire o_vga_hsync
);

  localparam HSYNC_COUNTER = 800;
  localparam HSYNC_COUNTER_BIT = 10;
  localparam HSYNC_CLKS = 7'd96;
  wire [HSYNC_COUNTER_BIT-1:0] s_hsync_cnt;


  counterN_en #(HSYNC_COUNTER, HSYNC_COUNTER_BIT) hsync_counter0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_px_clk), .o_cnt(s_hsync_cnt)
  );

  assign o_vga_hsync = (s_hsync_cnt < HSYNC_CLKS) ? 1'b1 : 1'b0;
endmodule

`endif
