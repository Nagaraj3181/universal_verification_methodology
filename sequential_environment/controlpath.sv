module mul_controlpath(done, lda, ldb, ldp, clrp, decb, clk, start,complete);

    input clk, start, done;

    output reg lda, ldb, ldp, clrp, decb, complete; 

    reg [2:0]state;

    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;

    always @(posedge clk)
        begin
            case(state)
                S0 : if(start) state<= S1;  
                S1 : state<=S2;
                S2 : state<= S3;
                S3 :  #2 if(done) state<=S4;
                S4 : state<= S0;
                default : state<= S0; 
            endcase
        end 

    always @(state)
        begin
           case(state)
               S0: begin 
	             lda = 0; ldb = 0; ldp = 0; clrp = 0; decb = 0; complete = 0;  
		   end
               S1: begin 
	             lda = 1; clrp = 0; 
		   end   
               S2: begin 
		     lda = 0; ldb = 1; clrp = 1;  
		   end  
               S3: begin
                     ldb = 0; clrp =0;ldp = 1;  decb = 1;  
		   end
               S4: begin 
	             complete = 1; ldp = 0;  decb = 0; 
		   end
               default : begin 
		          lda = 0; ldb = 0; ldp = 0; clrp = 0; decb = 0;  
		         end 
           endcase
        end
endmodule
