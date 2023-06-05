class my_mon extends uvm_monitor;
`uvm_component_utils(my_mon)

my_seq_item seq;
virtual dut_if vif;
uvm_analysis_port#(my_seq_item) mon_analysis;
function new (string name , uvm_component parent);
super.new(name,parent);
//seq = new();
//mon_analysis = new("mon_analysis",this);
endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);
	mon_analysis = new("mon_analysis",this);
	if(!uvm_config_db #(virtual dut_if)::get(this,"","vif",vif))
	begin
	`uvm_error("","virtual vif is not created")
	end
endfunction

virtual task run_phase (uvm_phase phase);
super.run_phase(phase);
seq = my_seq_item::type_id::create("seq",this);


forever begin
	//@(posedge vif.clk)
	@(posedge vif.clk)
	seq.a = vif.a;
	seq.b = vif.b;
	seq.cin = vif.cin;
	seq.sum = vif.sum;
	seq.carry = vif.carry;
//`uvm_info("monitor",$sformatf("a=%0d,b=%0d,cin=%0d,sum=%0d,carry=%0d",seq.a,seq.b,seq.cin,seq.sum,seq.carry),UVM_NONE)
seq.print();
mon_analysis.write(seq);
end

endtask
endclass



