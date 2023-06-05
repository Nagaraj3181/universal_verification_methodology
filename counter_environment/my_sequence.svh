//`include "seq_item.svh"
class my_sequence extends uvm_sequence#(my_seq_item);
`uvm_object_utils(my_sequence)
	my_seq_item req;
	function new(string name = "my_sequence");
	super.new(name);
	endfunction
	
	
	task body;
	`uvm_info("","----------------",UVM_NONE)
	repeat(2) begin
	req = my_seq_item::type_id::create("req");
	start_item(req);
	if(!req.randomize())
	`uvm_error("","Sequence item not randomized")
	//wait_for_sequenceitrm
	finish_item(req);
	end
	endtask
endclass
