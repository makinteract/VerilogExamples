`default_nettype none

`include "async.v"

// define a Count module
module top(input wire CLK_IN, 
		   input wire [4:0] J3,
		   input wire ENABLE,
		   input wire RX,
		   output wire [4:0] LED,
		   output wire TX);	

	parameter ClkFrequency = 12000000;	// 12MHz
	parameter Baud = 256000;

	// locals
	reg [8:0] rxdata;
	reg RxD_data_ready;

	// Once enable
	reg enableOnce=0;
	reg curr=0;

	always @(posedge CLK_IN)
	begin
		curr <= ENABLE;
		enableOnce <= ENABLE & !curr;
	end

	// LED (turn on using J3 state and ENABLE)
	// always @(posedge CLK_IN) if(ENABLE) LED <= J3; 


	// UART
	// BaudTickGen #(ClkFrequency, Baud) tickgen(.clk(CLK_IN), .enable(1'b1), .tick(TX));

	async_receiver #(ClkFrequency, Baud) RXD (.clk(CLK_IN), .RxD(RX), .RxD_data_ready(RxD_data_ready), .RxD_data(rxdata));

	async_transmitter #(ClkFrequency, Baud) TXD(.clk(CLK_IN), .TxD(TX), .TxD_start(RxD_data_ready), .TxD_data(rxdata));

	always @(posedge RxD_data_ready)  
	begin
		LED <= rxdata[4:0] - 8'd48; // sunbtract '0' from ASCII value
	end


endmodule
