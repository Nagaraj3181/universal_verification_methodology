`include "class.sv"
module c();
	b bb;
	initial begin
	bb = new();
	$display(bb.b1);
	end


endmodule
