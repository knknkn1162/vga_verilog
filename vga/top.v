`include "px_clk.v"
`include "hsync.v"
`include "vsync.v"
`include "gen_640_480.v"

module top (
  input wire clk, i_sclr_n,
  output wire [3:0] o_vga_red, o_vga_green, o_vga_blue,
  output wire o_vga_hsync, o_vga_vsync
);
  
  wire s_sclr;
  wire s_px_clk;
  wire s_hsync_en, s_vsync_en;
  wire s_haddr_en, s_vaddr_en;
  wire [3:0] s_red, s_green, s_blue;

  assign s_sclr = ~i_sclr_n;

  px_clk px_clk0(
    .clk(clk), .i_sclr(s_sclr),
    .o_px_clk(s_px_clk)
  );

  hsync hsync0 (
    .clk(clk), .i_sclr(s_sclr), .i_px_clk(s_px_clk),
    .o_hsync_en(o_vga_hsync), .o_addr_en(s_haddr_en)
  );

  vsync vsync0 (
    .clk(clk), .i_sclr(s_sclr), .i_px_clk(s_px_clk),
    .o_vsync_en(o_vga_vsync), .o_addr_en(s_vaddr_en)
  );

  // TODO: create image
  gen_640_480 gen_640_480_0 (
    .clk(clk), .i_sclr(i_sclr), .i_px_clk(i_px_clk),
    .i_haddr_en(s_haddr_en), .i_vaddr_en(s_vaddr_en),
    .o_vga_red(o_vga_red), .o_vga_green(o_vga_green), .o_vga_blue(o_vga_blue)
  );

endmodule
