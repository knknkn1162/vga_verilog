`define assert(a) \
  if ((a) !== 1) begin \
    $display("assertion failed in %m: signal != value at line %d in %s", `__LINE__, `__FILE__); \
    $stop; \
  end

`define assert_eq(a, b) \
  `assert(a === b)

`define assert_ne(a, b) \
  `assert(a !== b)

`define end_tb \
  begin \
    $display("<end of test>"); \
    $finish; \
  end

`define alert_empty_tb \
  begin \
    $display("<empty testbench>"); \
    $finish; \
  end
