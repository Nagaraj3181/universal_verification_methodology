class env extends uvm_env;
`uvm_component_utils(env)

agent agt;

function new(string name="", uvm_component parent);
super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);

agt = agent::type_id::create("agt",this);

endfunction

endclass