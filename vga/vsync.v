`ifndef _vsync
`define _vsync

`include "enableN_gen.v"
`include "counterN_en.v"

module vsync (
  input wire clk, i_sclr, i_ven,
  output wire o_vsync_enb, o_addr_enb,
  output wire o_frame_en,
  output wire [8:0] o_idx
);

  // See http://www.tinyvga.com/vga-timing/640x480@60Hz
  localparam VSYNC_PULSE_UTIME = 2;
  localparam BACK_PORCH_UTIME = 35;
  localparam VISIBLE_AREA_UTIME = 515;
  localparam COUNTER = 525; // line * px
  localparam COUNTER_BIT = 10;
  wire [COUNTER_BIT-1:0] s_cnt;
  wire [9:0] s_idx;

  counterN_en #(COUNTER, COUNTER_BIT) vsync_counter0 (
    .clk(clk), .i_sclr(i_sclr), .i_en(i_ven), .o_cnt(s_cnt)
  );

  assign o_vsync_enb = (s_cnt < VSYNC_PULSE_UTIME) ? 1'b1 : 1'b0;
  assign o_addr_enb = (s_cnt >= BACK_PORCH_UTIME && s_cnt < VISIBLE_AREA_UTIME) ? 1'b1 : 1'b0;
  assign s_idx = s_cnt - BACK_PORCH_UTIME;
  assign o_idx = s_idx[8:0];
  assign o_frame_en = (s_cnt == 10'd0) ? 1'b1 : 1'b0;
endmodule

`endif
