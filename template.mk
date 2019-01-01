VC=iverilog

WORKDIR=..

INCLUDE_OPTION=$(addprefix -I$(WORKDIR)/, $(INCLUDES))
OPTION=$(INCLUDE_OPTION)

all: $(FILES) clean

%: %.o
	vvp $^

%.o: %.v
	$(VC) ${OPTION} -o $@ $<

open:
	open out.vcd

clean:
	rm -rf *.o *.vcd
