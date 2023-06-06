class driver extends uvm_driver #(alu_seq_item);
`uvm_component_utils(driver)

alu_seq_item seq;

function new(string name= "", uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

seq = alu_seq_item::type_id::create("seq");

endfunction

task run_phase(uvm_phase phase);
forever begin
	seq_item_port.get_next_item(seq);
	drive();
	seq.print();
	seq_item_port.item_done(seq);
	$display("this is driver......................");
	
end
endtask

task drive();
if(seq.op == ADD) begin
// Do not fill anything

// these comments been added for your understanding, remove them after reading

// (Just say by mouth)send A and B both to dut
// Update the control signal ( like in dut --> enabling the add_en signal )

`uvm_info("DRV", "ADD operation", UVM_MEDIUM)
end

if(seq.op == SUB) begin
// send A and B
// update the control signal related to sub
`uvm_info("DRV", "SUB operation", UVM_MEDIUM)
 
end

if( seq.op == MUL) begin

// send A and B both to DUT
//update the control signal related to mul
`uvm_info("DRV", "MUL operation", UVM_MEDIUM)
end
if( seq.op == DIV) begin

// send A and B both to DUT
//update the control signal related to div
`uvm_info("DRV", "DIV operation", UVM_MEDIUM)
end
if( seq.op == LSH) begin

// send only A to dut
//update the control signal related to Left shift
`uvm_info("DRV", "LSH operation", UVM_MEDIUM)
end

if( seq.op == RSH) begin

// send A 
//update the control signal related to RSH
`uvm_info("DRV", "RSH operation", UVM_MEDIUM)
end

if( seq.op == RR) begin

// send A 
//update the control signal related to Rotate Right
`uvm_info("DRV", "RR operation", UVM_MEDIUM)
end

if( seq.op == RL) begin

// send A
//update the control signal related to RL
`uvm_info("DRV", "RL operation", UVM_MEDIUM)
end
endtask

endclass
