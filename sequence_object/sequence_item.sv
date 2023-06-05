import uvm_pkg::*;
`include "uvm_macros.svh"
class mem_seq_item extends uvm_sequence_item;

	rand bit [3:0] addr;
	rand bit wr_en;
	rand bit rd_en;

	rand bit [7:0] w_data;
	
	bit [7:0] r_data;

	`uvm_object_utils_begin(mem_seq_item)

	`uvm_field_int(addr,UVM_ALL_ON)
	`uvm_field_int(wr_en,UVM_ALL_ON)
	`uvm_field_int(rd_en,UVM_ALL_ON)
	`uvm_field_int(w_data,UVM_ALL_ON)

	`uvm_object_utils_end

	function new (string name = "mem_seq_item");
	super.new(name);
	endfunction

	constraint wr_en_c { wr_en == rd_en; };

endclass



module seq_item_tb;

	mem_seq_item seq_item0;
	mem_seq_item seq_item1;

	initial begin
	seq_item0 = mem_seq_item::type_id::create("seq_item0");
	seq_item1 = mem_seq_item::type_id::create("seq_item1");

	seq_item0.randomize();
	seq_item1.randomize();

	seq_item0.print();
	seq_item1.print();

	if(seq_item0.compare(seq_item1))
	`uvm_info("","seq_item0 is matching with seq_item1",UVM_LOW)
	else
	`uvm_error("","seq_item0 is not matching with seq_item1")
	
	//`uvm_info("","COPYING THE ITEMS OF SEQ0 TO SEQ1",UVM_ALL_ON)

	seq_item1.copy(seq_item0);
	$display("COPYING THE ITEMS OF SEQ0 TO SEQ1");
	seq_item0.print();
	seq_item1.print();
	
	if(seq_item0.compare(seq_item1))
	`uvm_info("","seq_item0 is matching with seq_item1",UVM_LOW)
	else
	`uvm_error("","seq_item0 is not matching with seq_item1")
	
	end

endmodule
