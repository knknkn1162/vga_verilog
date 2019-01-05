`include "testbench.v"
`include "enable_gen.v"

module enable_gen_tb;
  parameter BIT_SIZE = 3;
  reg clk, i_sclr;
  wire o_en;

  parameter CLK_PERIOD = 10;

  enable_gen #(BIT_SIZE) uut (
    .clk(clk),
    .i_sclr(i_sclr),
    .o_en(o_en)
  );

  `dump_block
  `conf_clk_block(clk, CLK_PERIOD)

  initial begin
    #(CLK_PERIOD)
      i_sclr = 1'b1;
    @(posedge clk) #1
      i_sclr = 1'b0;
      `assert_eq(o_en, 1'b1); // 0
    @(posedge clk) #1
      `assert_eq(o_en, 1'b0); // 1
    repeat(6) @(posedge clk)
      `assert_eq(o_en, 1'b0); // 7
    @(posedge clk) #1
      `assert_eq(o_en, 1'b1); // 0
    @(posedge clk) #1
      `assert_eq(o_en, 1'b0);
    @(posedge clk) #1
      `assert_eq(o_en, 1'b0);
    `end_tb
  end
endmodule
