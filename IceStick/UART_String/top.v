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
		   output wire CLK_2,
		   output wire [4:0] LED,
		   output wire TX);

	parameter ClkFrequency = 12000000;	// 12MHz
	parameter Baud = 115200;

	// Once enable
	reg enableOnce=0;
	reg curr=0;

	always @(posedge CLK_2)
	begin
		curr <= 1'b1;
		enableOnce <= 1'b1 & !curr;
	end

	always @(posedge enableOnce)
	begin
		enableOnce<=0;
		curr<=0;
	end

	

	reg CLK_2;
	CLK_GEN #(.FREQ(1)) sampler (CLK_IN, CLK_2);

	// UART
	async_transmitter #(ClkFrequency, Baud) TXD(.clk(CLK_IN), .TxD(TX), .TxD_start(enableOnce), .TxD_data(8'd95));
	




// reg [2:0] char_count;

// always @(posedge CLK_2)
// begin
// 	case (char_count)
// 		8'd0: data <= "H";
// 		8'd1: data <= "e";
// 		8'd2: data <= "l";
// 		8'd3: data <= "l";
// 		8'd4: data <= "o";
// 		8'd5: data <= "!";
// 		8'd6: data <= ".";
// 		8'd7: data <= ".";
// 		default: data <= ".";
// 	endcase

//   	char_count <= char_count + 1;
// end

endmodule
