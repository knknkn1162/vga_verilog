`ifndef _gen_640_480
`define _gen_640_480

`include "mux2.v"

module gen_640_480 (
  input wire clk, i_sclr, i_px_clk,
  input wire i_haddr_en, i_vaddr_en,
  output wire [3:0] o_vga_red, o_vga_green, o_vga_blue
);

  //localparam COLOR_BIT_SIZE = 19;
  //localparam ULIMIT = 19'd307200;
  wire [11:0] s_color0, s_color1;
  wire s_red, s_green, s_blue;
  //wire [COLOR_BIT_SIZE-1:0] s_idx; // 307200
  wire s_addr_en;

  assign s_addr_en = i_vaddr_en && i_haddr_en;

  assign s_red = 4'hF; assign s_green = 4'h0; assign s_blue = 4'h0;
  assign s_color0 = {s_red, s_green, s_blue};

  //counterN_en #(ULIMIT, WIDTH) counterN_en0(
  //  .clk(clk), .i_sclr(i_sclr), .i_en(s_addr_en), .o_cnt(s_idx)
  //);

  mux2 #(12) mux2_0(
    .i_d0(12'h000),
    .i_d1(s_color0),
    .i_s(s_addr_en),
    .o_y(s_color1)
  );

  assign o_vga_red = s_color1[11:8];
  assign o_vga_green = s_color1[7:4];
  assign o_vga_blue = s_color1[3:0];

endmodule

`endif

