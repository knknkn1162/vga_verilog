`ifndef _bflopr_en
`define _bflopr_en

module bflopr_en (
  input wire clk, i_sclr, i_en,
  input wire i_a,
  output reg o_y
);
  always @(posedge clk) begin
    if (i_sclr) begin
      o_y <= 1'b0;
    end else if (i_en) begin
      o_y <= i_a;
    end
  end

endmodule

`endif
