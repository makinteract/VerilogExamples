TARGET = top

all: $(TARGET).bin

$(TARGET).bin: $(TARGET).txt
	icepack $(TARGET).txt $(TARGET).bin

$(TARGET).txt: $(TARGET).blif
	arachne-pnr -d 1k -p icestick.pcf -o $(TARGET).txt $(TARGET).blif 

$(TARGET).blif: $(TARGET).v
	yosys -p "synth_ice40 -blif $(TARGET).blif" $(TARGET).v

prog_flash: $(TARGET).bin
	iceprog $(TARGET).bin

clean:
	rm *.bin *.blif *.txt