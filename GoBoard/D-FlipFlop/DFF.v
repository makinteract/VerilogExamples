// D-Flip Flop

`ifndef __DFF__V__
`define __DFF__V__

module DFF (input CLK, D, output reg Q);

    always @ (posedge CLK) begin
        Q <= D;
    end

endmodule



// Driver 
/*
module top (
	input CLK,
	input [3:0] SW,
	output io_PMOD_1
	);


DFF d1(CLK, SW[1], io_PMOD_1);

endmodule
*/

`endif