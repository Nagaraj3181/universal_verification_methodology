class alu_seq_item extends uvm_sequence_item;

typedef enum {ADD, SUB, MUL, DIV, LSH, RSH, RR, RL} operation;
rand operation op;
 

rand bit [7:0] A;
rand bit [7:0] B;
	bit [7:0] out;

  `uvm_object_utils_begin(alu_seq_item)
	`uvm_field_int(A, UVM_ALL_ON)
	`uvm_field_int(B, UVM_ALL_ON)
	`uvm_field_int(out, UVM_ALL_ON)
	`uvm_field_enum(operation, op, UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="");
super.new(name);
endfunction

endclass