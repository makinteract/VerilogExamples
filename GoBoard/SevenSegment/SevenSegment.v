`ifndef __SEVENSEGMENT__V__
`define __SEVENSEGMENT__V__

module SevenSegment (
	input CLK,
	output [6:0] SEG,
	input  [3:0] DATA
	);



always @(posedge CLK)
begin
	case (DATA)
		4'd0: SEG <= 7'b0000001;
		4'd1: SEG <= 7'b1001111;
		4'd2: SEG <= 7'b0010010;
		4'd3: SEG <= 7'b0000110;
		4'd4: SEG <= 7'b1001100;
		4'd5: SEG <= 7'b0100100;
		4'd6: SEG <= 7'b0100000;
		4'd7: SEG <= 7'b0001111;
		4'd8: SEG <= 7'b0000000;
		4'd9: SEG <= 7'b0000100;
		default: SEG <= 7'b1111111;
	endcase
end
endmodule



// Driver
/*
module top (
	input CLK,
	output [6:0] SEG
);

reg [3:0] number = 0; // change this 0-9

SevenSegment s ( CLK, SEG, number);

endmodule
*/