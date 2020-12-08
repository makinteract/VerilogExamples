`default_nettype none

`include "SPI_Slave.v"
`include "UART_TX.v"
`include "Display.v"

// read data (a,b,c,d...) SPI slave mode 0, and print it using UART


// define a Count module
module top(
  	  input CLK,
	    output [6:0] SEG1,
	    output [6:0] SEG2,
	    output [3:0] LED,
      input SCK,
      output MISO,
      input MOSI,
      input CS,
      input SW1,
      input SW2,
      output UARTTX,
);

  wire [7:0] in;
  reg [7:0] data = 8'd0;
  wire done;

  DisplayNumber ns (CLK, SEG1, SEG2, in);

  // I cannot get to work the MISO...

  SPI_Slave #(.SPI_MODE(0)) slave
  (
   // Control/Data Signals,
   .i_Rst_L(1'b1),   // FPGA Reset
   .i_Clk(CLK),       // FPGA Clock
   .o_RX_DV(done),    // Data Valid pulse (1 clock cycle)
   .o_RX_Byte(in),    // Byte received on MOSI
   .i_TX_DV(),      // Data Valid pulse to register i_TX_Byte
   .i_TX_Byte(),  // Byte to serialize to MISO.

   // SPI Interface
   .i_SPI_Clk(SCK),
   .o_SPI_MISO(MISO),
   .i_SPI_MOSI(MOSI),
   .i_SPI_CS_n(CS)
   );


  // 115200
  UART_TX #(.CLKS_PER_BIT(217)) UART_TX_Inst
  (
     .i_Rst_L(1'b1),
     .i_Clock(CLK),
     .i_TX_DV(done),
     .i_TX_Byte(in),
     .o_TX_Active(),
     .o_TX_Serial(UARTTX),
     .o_TX_Done()
  );


  
endmodule



