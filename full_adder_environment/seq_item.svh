class my_seq_item extends uvm_sequence_item;
//`uvm_object_utils(my_seq_item)

randc bit a;
randc bit b ;
randc bit cin;
bit clk,rst;
bit sum ,carry;

function new (string name = "my_seq_item");
super.new(name);
endfunction

`uvm_object_utils_begin(my_seq_item)
		`uvm_field_int(a, UVM_ALL_ON)
		`uvm_field_int(b, UVM_ALL_ON)
		`uvm_field_int(cin, UVM_ALL_ON)
	`uvm_object_utils_end

endclass







