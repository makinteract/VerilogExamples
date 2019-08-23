`ifndef __SHIFTREGISTER__V__
`define __SHIFTREGISTER__V__

// Shift register
`include "../Debouncer/Debouncer.v"
`include "../D-FlipFlop/DFF.v"

module top (
	input CLK,
	input [3:0] SW,
	output [3:0] LED
	);

wire Q1, Q2, Q3;
reg outSW1, outSW3;

Debouncer db0 (CLK, SW[0], outSW0);
Debouncer db1 (CLK, SW[1], outSW1);

DFF d1(outSW0, outSW1, Q1);
DFF d2(outSW0, Q1, Q2);
DFF d3(outSW0, Q2, Q3);
DFF d4(outSW0, Q3, LED[3]);

assign LED[0]= Q1;
assign LED[1]= Q2;
assign LED[2]= Q3;
endmodule


`endif