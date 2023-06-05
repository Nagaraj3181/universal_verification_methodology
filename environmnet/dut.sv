//DESIGN UNDER TEST
`include "uvm_macros.svh"

module dut(dut_if if1);
 import uvm_pkg::*;
 always@(posedge if1.clock) 
  if(!if1.reset)
   `uvm_info("I AM THE DUT.",$sformatf("THE MESSAGE HAS BEEN RECEIVED. cmd = %b,addr = %h, data = %h",if1.cmd,if1.addr,if1.data),UVM_MEDIUM)
endmodule
