`define dump_block \
  initial begin \
    $dumpfile("out.vcd"); \
    $dumpvars(0); \
  end
