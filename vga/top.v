`include "px_clk.v"
`include "hsync.v"
`include "vsync.v"
`include "gen_640_480.v"

module top (
  input wire clk, i_sclr,
  output wire [3:0] o_vga_red, o_vga_green, o_vga_blue,
  output wire o_vga_hsync, o_vga_vsync
);
  
  wire s_px_clk, s_ven;
  wire s_hsync_enb, s_vsync_enb;
  wire [9:0] s_hidx; // [0, 640)
  wire [8:0] s_vidx; // [0, 480)
  wire s_haddr_enb, s_vaddr_enb;
  wire [3:0] s_red, s_green, s_blue;

  px_clk px_clk0(
    .clk(clk), .i_sclr(i_sclr),
    .o_px_clk(s_px_clk),
    .o_ven(s_ven)
  );

  hsync hsync0 (
    .clk(clk), .i_sclr(i_sclr), .i_px_clk(s_px_clk),
    .o_hsync_enb(o_vga_hsync), .o_addr_enb(s_haddr_enb),
    .o_idx(s_hidx)
  );

  vsync vsync0 (
    .clk(clk), .i_sclr(i_sclr), .i_ven(s_ven),
    .o_vsync_enb(o_vga_vsync), .o_addr_enb(s_vaddr_enb),
    .o_idx(s_vidx)
  );

  // TODO: create image
  gen_640_480 gen_640_480_0 (
    .clk(clk), .i_sclr(i_sclr), .i_px_clk(s_px_clk),
    .i_haddr_enb(s_haddr_enb), .i_hidx(s_hidx),
    .i_vaddr_enb(s_vaddr_enb), .i_vidx(s_vidx),
    .o_vga_red(o_vga_red), .o_vga_green(o_vga_green), .o_vga_blue(o_vga_blue)
  );

endmodule
