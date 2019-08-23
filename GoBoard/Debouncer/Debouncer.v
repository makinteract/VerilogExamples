`ifndef __DEBOUNCER__V__
`define __DEBOUNCER__V__

module Debouncer (
	input CLK,
	input in,
	output reg out
	);

wire state = out;
reg prev, curr;

always @(posedge CLK)
begin
	prev= in;
	curr= prev;
end

reg [16:0] count;
wire idle = (state == curr);
wire finish = &count;


always @(posedge CLK)
begin
	if (idle)
	begin
		count <= 0;
	end
	else
	begin
		count <= count + 1;
		if (finish)
		begin
			state= ~state;
		end
	end
end

endmodule




// Driver
/*
module top (
	input CLK,
	input [3:0] SW,
	output [3:0] LED,
	output PMOD1
	);

reg out;

assign LED[0]= out;
assign LED[1]= out;
assign LED[2]= out;
assign LED[3]= out;
assign PMOD1 = out;

Debouncer  d1 (CLK, SW[0], out);

endmodule
*/

`endif
