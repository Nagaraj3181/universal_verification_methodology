import uvm_pkg::*;
class seq_item extends uvm_sequence_item;
	randc bit p,q,r,s,t,u;
	randc byte v,w,x,y,z;
	typedef enum {a=1,b,c,d} State;
	State state;
	
	`uvm_object_utils_begin(seq_item)
		`uvm_field_int(p,UVM_ALL_ON)
		`uvm_field_int(q,UVM_ALL_ON)
		`uvm_field_int(r,UVM_ALL_ON)
		`uvm_field_int(s,UVM_ALL_ON)
		`uvm_field_int(t,UVM_ALL_ON)
		`uvm_field_int(u,UVM_ALL_ON)
		`uvm_field_int(v,UVM_ALL_ON)
		`uvm_field_int(w,UVM_ALL_ON)
		`uvm_field_int(x,UVM_NOPRINT)
		`uvm_field_int(y,UVM_NOCOMPARE)
		`uvm_field_int(z,UVM_NOCOPY)
		
	`uvm_object_utils_end
		
	function new(string name="mem_seq_item");
		super.new(name);
	endfunction
	
endclass
		
