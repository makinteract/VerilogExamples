`ifndef __DEBOUNCER__V__
`define __DEBOUNCER__V__

`include "../D-FlipFlop/DFF.v"

module BetterDebouncer (
	input CLK,
	input INPUT_BUT,
	output reg OUTPUT
	);

wire slowClock;
wire Q1, Q2, Q2_bar;

ClockDivider #(.FREQ(500)) u1(CLK, slowClock);

DFF d1(slowClock, INPUT_BUT, Q1);
DFF d2(slowClock, Q1, Q2);

assign Q2_bar = ~Q2;
assign OUTPUT = Q1 & Q2_bar;


endmodule




// 25 MHz clock input -> output defaul 100Hz
// ClockDivider #(.FREQ(100)) u1(CLK, PMOD1);
module ClockDivider #(parameter FREQ = 100) (
	input CLK,
	output reg slow_clk
	);

parameter COUNTER_MAX = 25000000 / FREQ;
parameter COUNTER_HALF = COUNTER_MAX / 2;

reg [26:0] count = 0;

// Formula is: (25 MHz / Freq Hz * 50% duty cycle)
// So for DURATION_MS : 25,000,000 / FREQ * 0.5 - 1
// There is an approximation error

always @(posedge CLK)
begin
	count <= (count >= COUNTER_MAX-1)? 0 : count+1;
	slow_clk <= (count < COUNTER_HALF)? 1'b0 : 1'b1;
end

endmodule



`endif
