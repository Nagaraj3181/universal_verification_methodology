module full_adder(dut_if if1);
	`include "uvm_macros.svh"
	import uvm_pkg::*;


always @(posedge if1.clk)
if(if1.rst)
begin
if1.sum <= 0;
if1.carry <=0;
//`uvm_info("output",$sformatf("a=%0d,b=%0d,cin=%0d,sum=%0d,carry=%0d",if1.a,if1.b,if1.cin,if1.sum,if1.carry),UVM_NONE)
end

else
begin
if1.sum = (if1.a ^ if1.b ^if1.cin);
if1.carry =((if1.a&if1.b)|(if1.b&if1.cin)|(if1.cin&if1.a));
`uvm_info("output",$sformatf("a=%0d,b=%0d,cin=%0d,sum=%0d,carry=%0d",if1.a,if1.b,if1.cin,if1.sum,if1.carry),UVM_NONE)

end



endmodule
