`define assert(a) \
  if ((a) !== 1) begin \
    $display("assertion failed in %m: signal != value at line %d in %s", `__LINE__, `__FILE__); \
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
