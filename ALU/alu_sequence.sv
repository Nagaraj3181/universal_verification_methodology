class alu_sequence extends uvm_sequence #(alu_seq_item);
`uvm_object_utils(alu_sequence)

alu_seq_item seq;

function new(string name = "");
super.new(name);
endfunction

task body();
seq = alu_seq_item::type_id::create("seq");
begin
	repeat(5) begin
	`uvm_do(seq)
end
end
endtask

endclass