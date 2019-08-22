`include "../SevenSegment/SevenSegment.v"
`include "../Debouncer/Debouncer.v"

module top (
	input CLK,
	input SW1,
	input SW3,
	output [6:0] SEG,
	output [3:0] LED
);

// LEDs off
assign LED[3:0]= 4'b0000;

// Switches and debounces
reg outSW1, outSW3;
Debouncer d1 (CLK, SW1, outSW1);
Debouncer d3 (CLK, SW3, outSW3);
reg state = outSW1 || outSW3;

// Seven segment
reg [3:0] number = 0;
SevenSegment s ( CLK, SEG, number );


always @(posedge state)
begin
	if (outSW1) begin
		if (number == 4'd9 ) begin
			number <= 0;
		end else begin
			number <= number + 1;
		end
	end else if (outSW3) begin
		if (number == 4'd0 ) begin
			number <= 4'd9;
		end else begin
			number <= number - 1;
		end
	end
end




endmodule


