import uvm_pkg::*;
`include "uvm_macros.svh"
typedef enum {red,blue} colors;

class my_object extends uvm_object;
	rand colors mycolor;
	rand bit [2:0] data;
	string my_class;
	constraint cons {data[2] == 1;}

	function new (string name = "my_object");
	super.new(name);
	my_class = name;
	endfunction

	`uvm_object_utils_begin(my_object)

	`uvm_field_enum(colors,mycolor, UVM_NOPRINT)
	`uvm_field_int(data , UVM_DEFAULT)
	`uvm_field_string(my_class , UVM_DEFAULT)

	`uvm_object_utils_end

endclass
