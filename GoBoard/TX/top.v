`default_nettype none

`include "Display.v"
`include "UART_TX.v"
`include "UART_RX.v"

// define a Count module
module top(
  	  input CLK,
	    output [6:0] SEG1,
	    output [6:0] SEG2,
	    output [3:0] LED, 
		  output wire UARTTX,
		  input wire UARTRX,
);

	parameter ClkFrequency = 25000000;	// 25MHz
	parameter Baud = 9600;

  wire active;
  wire done;
  reg [7:0] data = 7'd99;
  wire [7:0] dataRx;
  reg enable = 1'b0;
  wire rxDiv;

  UART_TX #(.CLKS_PER_BIT(217)) UART_TX_Inst
  (
     .i_Rst_L(enable),
     .i_Clock(CLK),
     .i_TX_DV(1'b1),
     .i_TX_Byte(data),
     .o_TX_Active(active),
     .o_TX_Serial(UARTTX),
     .o_TX_Done(done)
  );

  UART_RX #(.CLKS_PER_BIT(217)) UART_RX_Inst
  (
   .i_Rst_L(1'b1),
   .i_Clock(CLK),
   .i_RX_Serial(UARTRX),
   .o_RX_DV(rxDiv),
   .o_RX_Byte(dataRx)
  );

  always @(posedge CLK)
  begin
    if (done)
      enable <= 1'b0;
    
    if (rxDiv)
    begin
      data <= dataRx;
      enable <= 1'b1;
    end

  end
  
  
  assign LED = 4'b0;

  DisplayNumber ns (CLK, SEG1, SEG2, data);

endmodule



