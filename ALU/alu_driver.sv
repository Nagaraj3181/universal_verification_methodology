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
  if(seq.op == 0) begin

`uvm_info("DRV", "ADD operation", UVM_MEDIUM)
end

  if(seq.op == 1) begin

`uvm_info("DRV", "SUB operation", UVM_MEDIUM)
 
end

  if( seq.op == 2) begin

`uvm_info("DRV", "MUL operation", UVM_MEDIUM)
end
  if( seq.op == 3) begin


`uvm_info("DRV", "DIV operation", UVM_MEDIUM)
end
  if( seq.op == 4) begin

`uvm_info("DRV", "LSH operation", UVM_MEDIUM)
end

  if( seq.op == 5) begin

`uvm_info("DRV", "RSH operation", UVM_MEDIUM)
end

  if( seq.op == 6) begin


`uvm_info("DRV", "RR operation", UVM_MEDIUM)
end

  if( seq.op == 7) begin

`uvm_info("DRV", "RL operation", UVM_MEDIUM)
end
endtask

endclass