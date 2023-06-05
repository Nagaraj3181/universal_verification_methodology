class my_test extends uvm_test;
	`uvm_component_utils(my_test)

	function new(string name , uvm_component parent);
	super.new(name , parent);
	endfunction

	function void build_phase(uvm_phase phase);
	my_object t = my_object::type_id::create("t",this);
	t.randomize();
	t.print;
	endfunction

	`define info(msg) uvm_top.uvm_report_info($psprintf("%m"),msg);
	`define warning(msg) uvm_top.uvm_report_warning($psprintf("%m"),msg);
	`define error(msg) uvm_top.uvm_report_error($psprintf("%m"),msg);

endclass
