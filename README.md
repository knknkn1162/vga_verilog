# How to use

```bash
git clone https://github.com/knknkn1162/verilog_template.git project_name
# exec make command on the project according to Makefile in the subdirectory.
make
```

# environments

+ The verilog compiler .. icarus verilog.

+ The default CI .. circle CI.

# (MY) coding rules

## prefix & suffix

||prefix|suffix|remarks|
|---|---|---|---|
|input|`i_`||
|output|`i_`||
|wire|`w_`||
|reg|`r_`||
|n-clk delay||`_$n`|
|block in marco||`_block`|NOT semicolon|

# macros

The general macros is included in include directory for testbench.
