`default_nettype none

`include "Display.v"
`include "SPI_Master.v"
// `include "SPI_Slave.v"


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

  parameter SPI_MODE = 3; // CPOL = 1, CPHA = 1
  parameter CLKS_PER_HALF_BIT = 6;  // 6.25 MHz

  wire [7:0] in;
  reg [7:0] out = 8'd97;
  wire ready;

  DisplayNumber ns (CLK, SEG1, SEG2, out);

  // SPI_Slave slave
  // (
  //  // Control/Data Signals,
  //  .i_Rst_L(reset),   // FPGA Reset
  //  .i_Clk(CLK),       // FPGA Clock
  //  .o_RX_DV(done),    // Data Valid pulse (1 clock cycle)
  //  .o_RX_Byte(in),      // Byte received on MOSI
  //  .i_TX_DV(write),    // Data Valid pulse to register i_TX_Byte
  //  .i_TX_Byte(out),  // Byte to serialize to MISO.

  //  // SPI Interface
  //  .i_SPI_Clk(SCK),
  //  .o_SPI_MISO(MISO),
  //  .i_SPI_MOSI(MOSI),
  //  .i_SPI_CS_n(CS)
  //  );

  // #(parameter SPI_MODE = 0,
  //   parameter CLKS_PER_HALF_BIT = 2)
  
  reg sw;
  
  SPI_Master #(.SPI_MODE(SPI_MODE),
    .CLKS_PER_HALF_BIT(CLKS_PER_HALF_BIT)) mater
  (
   // Control/Data Signals,
   .i_Rst_L(1'b1),
   .i_Clk(CLK),
   
   // TX (MOSI) Signals
   .i_TX_Byte(out),
   .i_TX_DV(enableOnce),
   .o_TX_Ready(ready),
   
   // RX (MISO) Signals
   .o_RX_DV(),     // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(),   // Byte received on MISO

   // SPI Interface
   .o_SPI_Clk(SCK),
   .i_SPI_MISO(MISO),
   .o_SPI_MOSI(MOSI)
   );

  reg enableOnce=0;
	reg curr=0;

	always @(posedge CLK)
	begin
		curr <= SW1;
		enableOnce <= SW1 & !curr;
    
    if (enableOnce) out <= out + 1;

    if (SW2) out <= 8'd97;
	end

  



endmodule



