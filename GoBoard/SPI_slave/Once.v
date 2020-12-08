`ifndef __ONCE__V__
`define __ONCE__V__


module Once 
  (
	input iClk,
	input iEnable,
  output oOnceEnable,
  );

  reg curr=0;

  always @(posedge iClk)
  begin
      curr <= iEnable;
      oOnceEnable <= iEnable & !curr;
  end

endmodule
