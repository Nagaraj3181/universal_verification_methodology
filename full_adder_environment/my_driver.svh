class my_driver extends uvm_driver#(my_seq_item);
`uvm_component_utils(my_driver)

my_seq_item req;
virtual dut_if vif;
function new (string name , uvm_component parent);
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);

	if(!uvm_config_db #(virtual dut_if)::get(this,"","vif",vif))
	begin
	`uvm_error("","virtual vif is not created")
	end
endfunction


 virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
vif.rst <= 1'b1;
	@(posedge vif.clk)
	 vif.rst <= 1'b0;
forever begin
	seq_item_port.get_next_item(req);
	
	@(posedge vif.clk)
	vif.rst <= req.rst;
	vif.a <= req.a;
	vif.b <= req.b;
	vif.cin <= req.cin;
	@(posedge vif.clk)
`uvm_info("driver to interface",$sformatf("a=%0d,b=%0d,cin=%0d,rst=%0d",req.a,req.b,req.cin,req.rst),UVM_NONE)
	
	seq_item_port.item_done(req);

	

end
endtask
endclass
	


