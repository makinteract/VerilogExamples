`include "async.v"


// Default 1kHz
module PULSE_GEN #(parameter FREQ = 1000) (
	input CLK,
	output wire outPin
	);


reg [32:0] count = 0;

// Formula is: (12 MHz / Freq Hz * 50% duty cycle)
// So for DURATION_MS : 12,000,000 / FREQ * 0.5 - 1
// There is an approximation error

reg enableOnce=0;
reg curr=0;

always @(posedge CLK)
begin
	if (count == 12_000_000 / FREQ -1)
	begin
		curr <= 1'b1;
		enableOnce <= 1'b1 & !curr;
		count <= 0;
	end
	else if (count == 0)
	begin
		curr <= 0;
		enableOnce <= 0; 
		count <= count + 1;
	end
	else
	begin
		count <= count + 1;
	end
end

assign outPin= enableOnce;
	
endmodule



// define a Count module
module top(input wire CLK_IN);
		  // output wire [4:0] LED,
		   //output wire TX);

	parameter ClkFrequency = 12000000;	// 12MHz
	parameter Baud = 115200;


	
	wire pulse;
	wire done;
	PULSE_GEN #(.FREQ(1000)) sampler (CLK_IN, pulse);

	// UART
	async_transmitter #(ClkFrequency, Baud) TXD(.clk(CLK_IN), .TxD(TX), .TxD_start(pulse), .TxD_data(8'd95), .TxD_busy(done));
	




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
