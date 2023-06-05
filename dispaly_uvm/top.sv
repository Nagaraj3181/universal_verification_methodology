`include "design.sv"
`include "interface.sv"
`include "package.sv"


module top;
	import uvm_pkg::*;
	import test_pkg::*;
	

	dut_if _if();

	design1 dut(.i(_if));

	initial begin
	run_test("test");
	end


endmodule
