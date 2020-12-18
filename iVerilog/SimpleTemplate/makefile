TARGET = tb
EXE = test

all:
	iverilog -o $(EXE) $(TARGET).v && ./$(EXE)

clean:
	rm *.bin *.blif *.txt *.vcd $(EXE)
