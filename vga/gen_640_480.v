`ifndef _gen_640_480
`define _gen_640_480

`include "mux2.v"
`include "counterN_en.v"

module gen_640_480 (
  input wire clk, i_sclr, i_px_clk,
  input wire i_hsync_en, i_vsync_en,
  input wire i_haddr_en, i_vaddr_en,
  input wire [9:0] i_hidx,
  input wire [8:0] i_vidx,
  output wire [3:0] o_vga_red, o_vga_green, o_vga_blue
);

  wire [11:0] s_color0, s_color1;
  wire s_area_en;
  localparam RED = 12'hF00;
  localparam BLUE = 12'h000;

  assign s_area_en = (i_haddr_en & (i_hidx >= 10'd100 && i_hidx < 10'd200)) & (i_vaddr_en & (i_vidx >= 9'd100 && i_vidx < 9'd200));
  assign s_color0 = (s_area0) ? RED : BLUE;

  mux2 #(12) mux2_0(
    .i_d0(12'h000),
    .i_d1(s_color0),
    .i_s(i_vaddr_en & i_haddr_en),
    .o_y(s_color1)
  );

  assign o_vga_red = s_color1[11:8];
  assign o_vga_green = s_color1[7:4];
  assign o_vga_blue = s_color1[3:0];

endmodule

`endif

