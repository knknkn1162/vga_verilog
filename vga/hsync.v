`ifndef _hsync
`define _hsync

`include "counterN_en.v"

module hsync (
  input wire clk, i_sclr, i_px_clk,
  output wire o_hsync_en, o_addr_en,
  output wire [9:0] o_idx
);

  // See http://www.tinyvga.com/vga-timing/640x480@60Hz
  localparam PULSE_UTIME = 96;
  localparam BACK_PORCH_UTIME = 144;
  localparam VISIBLE_AREA_UTIME = 784;
  localparam COUNTER = 800;
  localparam COUNTER_BIT = 10;
  localparam CLKS = 7'd96;
  wire [COUNTER_BIT-1:0] s_cnt;

  counterN_en #(COUNTER, COUNTER_BIT) hsync_counter0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_px_clk), .o_cnt(s_cnt)
  );

  assign o_hsync_en = (s_cnt < PULSE_UTIME) ? 1'b1 : 1'b0;
  assign o_addr_en = (s_cnt >= BACK_PORCH_UTIME && s_cnt < VISIBLE_AREA_UTIME) ? 1'b1 : 1'b0;
  assign o_idx = s_cnt - BACK_PORCH_UTIME;
endmodule

`endif
