class my_sequence extends uvm_sequence#(seq_item);
`uvm_object_utils(my_sequence)

seq_item seq;

function new(string name ="my_sequence");
super.new(name);
endfunction

task body;
repeat(4)
begin

`uvm_do(seq);
/*seq = seq_item::type_id::create("seq");
start_item(seq);
if(!seq.randomize())
	`uvm_error("","sequence item not recognized")
finish_item(seq);*/

end
endtask

endclass
