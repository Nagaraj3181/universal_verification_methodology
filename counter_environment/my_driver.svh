//`include "seq_item.svh"
class my_driver extends uvm_driver#(my_seq_item);
`uvm_component_utils(my_driver)
	virtual dut_if dut_vif;
	
	function new (string name , uvm_component parent);
	super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db #(virtual dut_if) :: get(this,"","dut_vif",dut_vif))
	begin

	`uvm_error(get_type_name(),"uvm_config_db :: get failed")
	end
	endfunction 


	task run_phase(uvm_phase phase);
	super.run_phase(phase);
	dut_vif.rst=0;

	@(posedge dut_vif.clk);
	#5 dut_vif.rst=1;
	
	forever begin
	seq_item_port.get_next_item(req);
	
	dut_vif.rst = req.rst;
	
	seq_item_port.item_done(req);
	//req.print();
	`uvm_info("","----------------",UVM_NONE)
	`uvm_info("driver",$sformatf("a=%0d",req.rst),UVM_NONE)

	end
endtask
endclass
