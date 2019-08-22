// Default blinking is 1 second
module Blinker #(parameter FREQ = 1) (
	input CLK,
	output reg outPin
	);


reg [32:0] count;

// Formula is: (25 MHz / Freq Hz * 50% duty cycle)
// So for DURATION_MS : 25,000,000 / FREQ * 0.5 - 1
// There is an approximation error

always @(posedge CLK)
begin
	if (count == 25000000 / FREQ / 2 -1)
	begin
		outPin= ~outPin;
		count <= 0;
	end
	else
	begin
		count <= count + 1;
	end
end

endmodule




// Driver

module top (
	input CLK,
	output [3:0] LED
	);



Blinker #(.FREQ(1)) blink1 (CLK, LED[0]);
Blinker #(.FREQ(2)) blink2 (CLK, LED[1]);
Blinker #(.FREQ(3)) blink3 (CLK, LED[2]);
Blinker #(.FREQ(4)) blink4 (CLK, LED[3]);


endmodule