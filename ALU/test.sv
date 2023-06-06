class test extends uvm_test;
`uvm_component_utils(test)

env envv; 

function new(string name="", uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);

envv = env::type_id::create("envv",this);

endfunction

endclass
