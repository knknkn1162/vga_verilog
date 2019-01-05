`ifndef _vsync
`define _vsync

`include "counterN_en.v"

module vsync (
  input wire clk, i_sclr, i_px_clk,
  output wire o_vsync_en, o_addr_en
);

  // See http://www.tinyvga.com/vga-timing/640x480@60Hz
  localparam SCAN_WIDTH = 800;
  localparam VSYNC_PULSE_UTIME = 2*SCAN_WIDTH;
  localparam BACK_PORCH_UTIME = 35*SCAN_WIDTH;
  localparam VISIBLE_AREA_UTIME = 515*SCAN_WIDTH;
  localparam COUNTER = 525*SCAN_WIDTH; // line * px
  localparam COUNTER_BIT = 19;
  wire [COUNTER_BIT-1:0] s_vsync_cnt;


  counterN_en #(COUNTER, COUNTER_BIT) vsync_counter0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_px_clk), .o_cnt(s_vsync_cnt)
  );

  assign o_vsync_en = (s_vsync_cnt < VSYNC_PULSE_UTIME) ? 1'b1 : 1'b0;
  assign o_addr_en = (s_vsync_cnt >= BACK_PORCH_UTIME && s_vsync_cnt < VISIBLE_AREA_UTIME) ? 1'b1 : 1'b0;
endmodule

`endif
