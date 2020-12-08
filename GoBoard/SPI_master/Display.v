`ifndef __SEVENSEGMENT__V__
`define __SEVENSEGMENT__V__


module DisplayNumber (
	input CLK,
	output [6:0] SEGMENT1,
	output [6:0] SEGMENT2,
	input [7:0] NUMBER
);

reg [3:0] left;

always @(posedge CLK)
begin
	left = (NUMBER / 10) % 10;

	if (left == 3'b0)
	begin
		left = 4'd10; // make not appear
	end
end

SevenSegment s1 ( CLK, SEGMENT1, left);
SevenSegment s2 ( CLK, SEGMENT2, NUMBER % 10);

endmodule


// ------------------------ 

module SevenSegment (
	input CLK,
	output [6:0] SEGMENT,
	input  [3:0] DATA
	);


always @(posedge CLK)
begin
	case (DATA)    // ensure not default case happens
		4'd0: SEGMENT <= 7'b0000001;
		4'd1: SEGMENT <= 7'b1001111;
		4'd2: SEGMENT <= 7'b0010010;
		4'd3: SEGMENT <= 7'b0000110;
		4'd4: SEGMENT <= 7'b1001100;
		4'd5: SEGMENT <= 7'b0100100;
		4'd6: SEGMENT <= 7'b0100000;
		4'd7: SEGMENT <= 7'b0001111;
		4'd8: SEGMENT <= 7'b0000000;
		4'd9: SEGMENT <= 7'b0000100;
		default: SEGMENT <= 7'b1111111;
	endcase
end
endmodule


