//`include "data.sv"
//`include "controlpath.sv"

module seq_multiplier();
	reg clk, start;
	reg [7:0]a,b;
	wire done;
        wire  lda, ldb, ldp, clrp, decb;
	
    	mul_datapath data_path(done, clk, lda, ldb, ldp, clrp, decb,a,b); 
 
    	mul_controlpath control_path(done, lda, ldb, ldp, clrp, decb, clk, start,complete);
 
		
	initial 
	begin clk = 0;
	start = 1'b1;
	forever #3 clk = ~clk;
	end

	initial begin
	
	 #8 a = 8;
	#10 b = 5;
	
	#39 a = 7;
	#10 b = 6;

	#50 a = 10;
	#10 b = 5;
	
	#44 a = 7;
	#8  b = 8;	

	#70 $finish;
	end
	
endmodule
