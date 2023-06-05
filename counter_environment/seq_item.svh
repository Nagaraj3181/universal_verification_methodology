class my_seq_item extends uvm_sequence_item;
`uvm_object_utils(my_seq_item)
	

rand bit rst;
 logic [3:0] count;

function new (string name = "my_seq_item");
super.new(name);
endfunction

endclass
