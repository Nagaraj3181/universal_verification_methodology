class my_driver extends uvm_driver#(seq_item);
`uvm_component_utils(my_driver)
seq_item seq;
virtual design_if vif;
function new(string name , uvm_component parent);
super.new(name,parent);
endfunction


function void build_phase (uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(virtual design_if)::get(this,"","vif",vif))
`uvm_fatal(" ","virtal interface is not setted in top module")

endfunction


virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
vif.rst<=1;
	#6;
	vif.rst<=0;

forever begin
	@(negedge vif.clk)
	
	seq_item_port.get_next_item(seq);
	
	vif.din <= seq.din;
	//seq.print();
	
	`uvm_info("driver to interface",$sformatf("din=%0d,qout=%0d,rst=%0d",seq.din,seq.qout,vif.rst),UVM_NONE)
	seq_item_port.item_done(seq);
	//repeat(2)@(posedge vif.clk)
end
endtask
endclass


