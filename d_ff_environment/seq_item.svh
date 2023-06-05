class seq_item extends uvm_sequence_item;


randc logic[3:0]din;
logic [3:0] qout;
bit rst,clk;

`uvm_object_utils_begin(seq_item)
`uvm_field_int(din,UVM_ALL_ON)
`uvm_field_int(qout,UVM_ALL_ON)

`uvm_object_utils_end

function new(string name = "seq_item");
super.new(name);
endfunction



endclass


