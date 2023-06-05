`include "package.svh"
`include "design.sv"
`include "interface.sv"


module top();
	
	import uvm_pkg::*;
	import my_package::*;
	
	design_if if1();
	dff dut(if1);
	
	initial begin 
	if1.clk = 0;
	forever #5 if1.clk = ~if1.clk;
	end
	
	initial begin
	uvm_config_db#(virtual design_if)::set(null,"*","vif",if1);
	run_test("test");
	#100 $finish;
	end

endmodule
