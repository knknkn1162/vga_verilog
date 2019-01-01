`ifndef _flopr_en
`define _flopr_en

module flopr_en #(
  parameter WIDTH = 32
) (
  input wire clk, i_sclr, i_en,
  input wire [WIDTH-1:0] i_a,
  output reg [WIDTH-1:0] o_y
);
  always @(posedge clk) begin
    if (i_sclr) begin
      o_y <= {WIDTH{1'b0}};
    end else if (i_en) begin
      o_y <= i_a;
    end
  end
endmodule

`endif
