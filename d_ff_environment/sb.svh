class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)

seq_item item;
uvm_analysis_imp #(seq_item,scoreboard) sb_analysis;

function new (string name , uvm_component ujwal);
super.new(name,ujwal);
endfunction


virtual function void build_phase (uvm_phase phase);
super.build_phase(phase);
sb_analysis = new("sb_analysis",this);

endfunction

 virtual function void write(seq_item tr);
 
	`uvm_info("sco",$sformatf("rst:%0d din:%0d dout:%0d",tr.rst,tr.din,tr.qout),UVM_NONE);
	if(tr.rst == 1'b1 && tr.qout== 0)
		`uvm_info("sco","DFF reset",UVM_NONE)
	else if(tr.rst == 1'b0 && tr.din == tr.qout)
		`uvm_info("sco","TEST PASSED",UVM_NONE)
	else begin
		`uvm_info("sco","TEST FAILED",UVM_NONE)
	$display("---------------------------------------------------------------");
	end
	endfunction
	endclass


