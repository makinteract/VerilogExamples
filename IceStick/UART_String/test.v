`timescale 1ns/100ps 

`include "top.v"



module test;

parameter ClkFrequency = 12000000;	// 12MHz

reg clk;


initial 
begin
	$dumpfile("test.vcd");
	$dumpvars(0, test);
	
	clk = 0;
	#10_000_000 $finish;
end

always #(1000000000/ClkFrequency/2-1) 
begin
	clk = ~clk;
end

top main (clk);

endmodule