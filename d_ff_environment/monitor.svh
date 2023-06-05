class monitor extends uvm_monitor;
`uvm_component_utils(monitor)

seq_item item;
virtual design_if vif;

uvm_analysis_port#(seq_item) mon_analysis;

function new (string name , uvm_component parent);
super.new(name, parent);
endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);
mon_analysis = new("mon_analysis",this);

if(!uvm_config_db #(virtual design_if)::get(this,"","vif",vif))
`uvm_fatal("","set the vif in top module")

endfunction

 task run_phase(uvm_phase phase);
//super.run_phase(phase);
`uvm_info("",$sformatf("din=%0d",vif.din),UVM_NONE)
item =seq_item::type_id::create("item");
	
	forever begin
	@(posedge vif.clk)
	item.din <= vif.din;
	item.qout <= vif.qout;
	//item.rst <= vif.rst;
	//item.print();
	`uvm_info("monitor",$sformatf("din=%0d,qout=%0d,rst=%0d",vif.din,vif.qout,vif.rst),UVM_NONE)
	mon_analysis.write(item);
	end
	`uvm_info("","---------------------------------------------------",UVM_NONE)
	
endtask
endclass
