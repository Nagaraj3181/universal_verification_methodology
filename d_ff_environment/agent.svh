class agent extends uvm_agent;
`uvm_component_utils(agent)

//seq_item seq;
my_driver driv;
monitor mon;
uvm_sequencer #(seq_item) sequencer;

function new (string name , uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
mon = monitor ::type_id::create("mon",this);
driv = my_driver ::type_id::create("driv",this);
sequencer = uvm_sequencer#(seq_item)::type_id::create("sequencer",this);

endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
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
