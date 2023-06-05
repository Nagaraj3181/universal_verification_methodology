`include "uvm_macros.svh"
`include "sequence.sv"
module top;
	initial begin
		seq_item sq1,sq2,sq3;
		sq1=seq_item::type_id::create();		
		sq1.randomize();
		sq1.print();		//PRINTING					
		sq2=seq_item::type_id::create();
		sq2.copy(sq1);	  //COPYING SEQ1 TO SEQ2				
		sq2.print();
		
		$cast(sq3,sq1.clone());		//CLONE			
		sq3.print();
		
		
		if(sq1.compare(sq2))
		`uvm_info("","sq2 is matching with sq1",UVM_LOW)
		else
		`uvm_error("","sq2 is not matching with sq1")
		
		end

endmodule
