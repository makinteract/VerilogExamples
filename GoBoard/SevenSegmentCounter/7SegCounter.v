module sevenSeg (
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




module test #( parameter DURATION = 22 ) (
	input CLK,
	input SW1,
	input SW3,
	output [6:0] SEG
);


reg [3:0] number = 0;
reg A, B;

reg [DURATION:0] counter;
reg state;



always @ (posedge CLK) begin
        counter <= counter + 1;
        state <= counter[DURATION-1]; 
end


always @(posedge state)
begin
	if (SW1) begin
		if (number == 4'd9 ) begin
			number <= 0;
		end else begin
			number <= number + 1;
		end
	end else if (SW3) begin
		if (number == 4'd0 ) begin
			number <= 4'd9;
		end else begin
			number <= number - 1;
		end
	end
end


sevenSeg decoder ( CLK, SEG, number );

endmodule