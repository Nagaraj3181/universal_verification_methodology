class agent extends uvm_agent;
`uvm_component_utils(agent)

driver drv;
uvm_sequencer #(alu_seq_item) seqr;
alu_sequence seq;

function new(string name="", uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);

drv = driver::type_id::create("drv", this);
seqr = uvm_sequencer#(seq_item)::type_id::create("seqr",this);

seq = alu_sequence::type_id::create("seq",this);
endfunction



task run_phase(uvm_phase phase);
phase.raise_objection(this);

seq.start(seqr);

phase.drop_objection(this);

endtask

function void connect_phase(uvm_phase phase);
drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass