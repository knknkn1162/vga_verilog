`ifndef _gen_640_480
`define _gen_640_480

`include "mux2.v"
`include "counterN_en.v"

module gen_640_480 (
  input wire clk, i_sclr, i_px_clk,
  input wire i_haddr_enb, i_vaddr_enb,
  input wire i_frame_en,
  input wire [9:0] i_hidx, // 640
  input wire [8:0] i_vidx, // 480
  output wire [3:0] o_vga_red, o_vga_green, o_vga_blue
);

  wire s_area_en;
  localparam RED = 12'hF00;
  localparam BLUE = 12'h00F;


  wire [49:0] s_data0;
  reg [49:0] s_data1;
  wire [9:0] s_llimitx0, s_ulimitx0;
  wire [8:0] s_llimity0, s_ulimity0;
  wire [9:0] s_llimitx1, s_ulimitx1;
  wire [8:0] s_llimity1, s_ulimity1;
  wire [11:0] s_color0, s_color1;

  // 12 + 10 + 9 + 10 + 9
  always @(posedge clk) begin
    if (i_sclr) begin
      s_data1 <= {RED, 10'd100, 10'd200, 9'd100, 9'd200};
    end else if (i_frame_en) begin
      s_data1 <= {s_color0, s_llimitx0, s_ulimitx0, s_llimity0, s_ulimity0};
    end
  end
  assign {s_color1, s_llimitx1, s_ulimitx1, s_llimity1, s_ulimity1} = s_data1;

  // define square area and color
  assign s_area_en = (i_haddr_enb & (i_hidx >= s_llimitx1 && i_hidx < s_ulimitx1)) & (i_vaddr_enb & (i_vidx >= s_llimity1 && i_vidx < s_ulimity1));
  // update
  assign s_color0 = (s_area_en) ? RED : BLUE; // constant
  assign s_llimitx0 = s_llimitx1 + 1'd1;
  assign s_ulimitx0 = s_ulimitx1 + 1'd1;
  assign s_llimity0 = s_llimity1 + 1'd1;
  assign s_ulimity0 = s_ulimity1 + 1'd1;


  wire [11:0] s_color;
  mux2 #(12) mux2_0(
    .i_d0(12'h000),
    .i_d1(s_color1),
    .i_s(i_vaddr_enb & i_haddr_enb),
    .o_y(s_color)
  );

  assign o_vga_red = s_color[11:8];
  assign o_vga_green = s_color[7:4];
  assign o_vga_blue = s_color[3:0];

endmodule

`endif

