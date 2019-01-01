`ifndef _bflopr
`define _bflopr

module bflopr (
  input wire clk, i_sclr,
  input wire i_a,
  output reg o_y
);
  always @(posedge clk) begin
    if (i_sclr) begin
      o_y <= 1'b0;
    end else begin
      o_y <= i_a;
    end
  end

endmodule

`endif
