`include "async.v"


// Default 1kHz
module CLK_GEN #(parameter FREQ = 1000) (
	input CLK,
	output reg outPin
	);


reg [32:0] count;

// Formula is: (12 MHz / Freq Hz * 50% duty cycle)
// So for DURATION_MS : 12,000,000 / FREQ * 0.5 - 1
// There is an approximation error

always @(posedge CLK)
begin
	if (count == 12000000 / FREQ / 2 -1)
	begin
		outPin = ~outPin;
		count <= 0;
	end
	else
	begin
		count <= count + 1;
	end
end

endmodule



// define a Count module
module top(input wire CLK_IN,
		   input wire [5:0] J3,
		   output wire CLK_2,
		   output wire [4:0] LED,
		   output wire TX);

	parameter ClkFrequency = 12000000;	// 12MHz
	parameter Baud = 115200;


	CLK_GEN #(.FREQ(1000)) sampler (CLK_IN, CLK_2);
	assign LED= J3[4:0];

	wire ready;
	assign ready = J3[5];

	// UART
	async_transmitter #(ClkFrequency, Baud) TXD(.clk(CLK_IN), .TxD(TX), .TxD_start(ready), .TxD_data({3'b000, J3[4:0]}));
	

endmodule
