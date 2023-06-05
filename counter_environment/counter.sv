`include "uvm_macros.svh"

module counter (dut_if if1);
	import uvm_pkg::*;
	always @(posedge if1.clk)
	begin
	if(if1.rst)
	begin
		if1.count <= 4'b0;
	end
	else
	begin
		if1.count <= if1.count + 1'b1;
	end
	end
endmodule
