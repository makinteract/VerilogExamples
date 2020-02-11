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

`include "top.v"

module tb;
            
    reg a; 
    reg clk;
    wire b;
            
                    
    initial 
    begin
    
    $dumpfile("tb.vcd");
	$dumpvars(0, tb);

    clk = 0;
    #1
    a=0;
    #5
    a=1;
    #5
    a=0;
    #1
    a=1;
    
    #20 $finish;
    end
    
    always #1 clk= ~clk;

    top myInstance (a,clk,b);

endmodule
