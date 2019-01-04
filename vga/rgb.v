`ifndef rgb
`define rgb

`include "mux2.v"
  
module rgb (
  input wire i_vsync_en, i_hsync_en,
  input wire [3:0] i_red, i_green, i_blue,
  output wire [3:0] o_vga_red, o_vga_green, o_vga_blue
);

  localparam WIDTH = 4;
  wire [11:0] s_color0, s_color1;

  assign s_color0 = {i_red, i_green, i_blue};

  mux2 #(WIDTH*3) mux2_0(
    .i_d0(12'h000),
    .i_d1(s_color0),
    .i_s(i_vsync_en & i_hsync_en),
    .o_y(s_color1)
  );

  assign o_vga_red = s_color1[11:8];
  assign o_vga_green = s_color1[7:4];
  assign o_vga_blue = s_color1[3:0];

endmodule

`endif
