//`include "my_agent.svh"

class my_env extends uvm_env;
	`uvm_component_utils(my_env)

	my_agent agent;
	
	function new(string name , uvm_component parent);
	super.new(name,parent);
	endfunction

	function void buid_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info("","------envvv----------",UVM_NONE)
	agent = my_agent::type_id::create("agent",this);
	
	endfunction

endclass
