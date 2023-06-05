`include "dut_if.sv"
`include "counter.sv"
`include "my_package.svh"
module top();
import uvm_pkg::*;
import my_package::*;
	dut_if dutif();
	counter dut1(dutif);
	
	initial begin
	dutif.clk = 0;
	forever #5 dutif.clk = ~dutif.clk;
	end

	initial begin
	 uvm_config_db#(virtual dut_if) :: set(null,"*","dut_vif",dutif);
	 run_test("my_test");
	end
endmodule
