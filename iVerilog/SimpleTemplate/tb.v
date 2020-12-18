`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2020 02:32:52 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "dff.v"

module tb;
            
    reg in; 
    reg clk;
    wire out;

    // Set the clock            
    always #1 clk= ~clk;


    initial 
    begin
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);

        clk = 0;
        in=0;
        #5
        in=1;
        #5
        in=0;
        #5
        in=1;
        
        #5 $finish;
    end

    
    dff inst (.clk(clk), .d(in) , .q(out));

endmodule
