class environment extends uvm_env;
`uvm_component_utils(environment)

agent ag;
scoreboard sb;
function new (string name , uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
ag = agent ::type_id ::create("ag",this);
sb = scoreboard ::type_id::create("sb",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
ag.mon.mon_analysis.connect(sb.sb_analysis);
endfunction
endclass
