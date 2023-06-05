`include "my_package.svh"
`include "dut.sv"
`include "dut_if.sv"

module top();
import uvm_pkg::*;	
import my_package::*;
	dut_if DutIf();
 	dut dut1(.if1(DutIf));
	
		
	
	initial begin
  	 DutIf.clock = 0;
	 forever #5 DutIf.clock = ~DutIf.clock;
	end
//WE NEED TO SET THE VIRTUAL INTERFACE TO SEND IT TO THE DRIVER

	initial begin
	 uvm_config_db#(virtual dut_if) :: set(null,"*","dut_vif",DutIf);
	 run_test("my_test");
	end
//$dumpfile $dumpvars can be added here

endmodule
