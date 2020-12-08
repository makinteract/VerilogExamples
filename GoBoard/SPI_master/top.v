`default_nettype none

`include "Display.v"
`include "SPI_Master.v"
`include "Once.v"
`include "Debounce_Single_Input.v"


// This modulo prints 'a', 'b', 'c'... with SPI master every time you click SW1. 
// SW2 reset back to the character 'a'
// SW1 is debounced and used to enable SPI MOSI (Once). ASCII value appears on the 7-segment display


// define a Count module
module top(
  	  input CLK,
	    output [6:0] SEG1,
	    output [6:0] SEG2,
	    output [3:0] LED,
      output SCK,
      input MISO,
      output MOSI,
      output CS,
      input SW1,
      input SW2,
);

  // SPI PARAMS
  parameter SPI_MODE = 3; // CPOL = 1, CPHA = 1
  parameter CLKS_PER_HALF_BIT = 8;  // 6.25 MHz

  // Others
  DisplayNumber ns (CLK, SEG1, SEG2, out);

  reg sw1;
  Debounce_Single_Input db (CLK, SW1, sw1);

  reg enableOnce;
  Once once (CLK, sw1, enableOnce);

  // SPI

  wire [7:0] in;
  reg [7:0] out = 8'd97;
  wire txready;
  wire rxready;
  // Very important that the CLKS_PER_HALF_BIT are > 6 or Arduino cannot ready such high freq
  SPI_Master #(.SPI_MODE(SPI_MODE),
    .CLKS_PER_HALF_BIT(CLKS_PER_HALF_BIT)) mater
  (
   // Control/Data Signals,
   .i_Rst_L(1'b1),
   .i_Clk(CLK),
   
   // TX (MOSI) Signals
   .i_TX_Byte(out),
   .i_TX_DV(enableOnce),
   .o_TX_Ready(txready),
   
   // RX (MISO) Signals
   .o_RX_DV(rxready),     // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(in),   // Byte received on MISO

   // SPI Interface
   .o_SPI_Clk(SCK),
   .i_SPI_MISO(MISO),
   .o_SPI_MOSI(MOSI)
   );


	always @(posedge CLK)
	begin    
    if (enableOnce) out <= out + 1;

    if (SW2) out <= 8'd97;
	end

  



endmodule



