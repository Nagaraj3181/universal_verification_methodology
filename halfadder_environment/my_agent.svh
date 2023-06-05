class my_agent extends uvm_agent;

`uvm_component_utils(my_agent)
my_driver driv;
my_mon mon;
uvm_sequencer #(my_seq_item) sequencer;

function new(string name , uvm_component parent);
super.new(name , parent);
endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);
driv = my_driver::type_id::create("driv",this);
mon = my_mon::type_id::create("mon",this);
sequencer = uvm_sequencer#(my_seq_item)::type_id::create("sequencer",this);
endfunction

function void connect_phase(uvm_phase phase);
driv.seq_item_port.connect(sequencer.seq_item_export);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);

begin
	   my_sequence seq;
	   seq = my_sequence::type_id::create("seq");
	   seq.start(sequencer);
end
phase.drop_objection(this);

endtask
endclass






