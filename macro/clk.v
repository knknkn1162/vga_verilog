`define conf_clk_block(clk, clk_period) \
  `init_clk(clk) \
  `gen_clk(clk, clk_period)

`define init_clk(clk) \
  initial begin \
    clk <= 0; \
  end

`define gen_clk(clk, clk_period) \
  always #((clk_period)/2) begin \
    clk <= !clk; \
  end
