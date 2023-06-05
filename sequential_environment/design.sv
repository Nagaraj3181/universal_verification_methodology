module mul_datapath(done, clk, lda, ldb, ldp, clrp, decb,a,b,product);
    input clk, lda, ldb, ldp, clrp, decb;
    input [7:0] a;
    input [7:0] b;
output [7:0]product;
    wire [7:0]a_data,b_out;
    output done;

    rega load_a(a,lda,clk,a_data);

    regp p(a_data,ldp,clrp,clk,product);

    regb b_data(b, clk, ldb, decb,b_out);

    compare comp_b(done, b_out);

endmodule

// loading  a data  

module rega(in,lda,clk,out);  // in is input , ld to load , out is output
input [7:0] in;
input lda,clk;
output reg [7:0] out;
always@(posedge clk)

    if(lda)
	begin
            out<= in;
	end
endmodule


// reg p to clear if clear signal is activated and to add operation 

module regp(in,ldp,clrp,clk,out);  
input [7:0] in;
input ldp,clrp,clk;
output reg [7:0] out;
always@(posedge clk)

    if(clrp)
	out<= 4'b0;

    else if (ldp)     
        out<= out + in;

endmodule

// for comparing if b becomes 0 then to update the done signal

module compare(done,data);

input [7:0] data;

output reg done;

always @(data)
begin
if (data)
   done <= 0;
else 
 done <= 1;   
end

endmodule

// to load b data and to decrement 

module regb(in,clk,ldb,decb,out);  
    input clk, ldb, decb;
    input [7:0] in;
    output reg [7:0]out;
    always @(posedge clk)
        begin
            if(ldb) out <= in;
            else if(decb)
                out <= out-1;
        end
endmodule


//-------------------------------------------------------------

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
                S3 : #2 if(done) state<=S4;
                S4 : state<= S0;
                default : state<= S0; 
            endcase
        end 

    always @(state)
        begin
           case(state)
               S0: begin 
	             lda = 0; ldb = 0; ldp = 0; clrp = 1; decb = 0; complete = 0;  
		   end
               S1: begin 
	             lda = 1; clrp = 0; 
		   end   
               S2: begin 
		     lda = 0; ldb = 1; clrp = 0;  
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

module multiplier(dut_if if1);

	
    	mul_datapath data_path(if1.done, if1.clk, if1.lda, if1.ldb, if1.ldp, if1.clrp, if1.decb,if1.a,if1.b,if1.product); 
    	mul_controlpath control_path(if1.done, if1.lda, if1.ldb, if1.ldp, if1.clrp, if1.decb, if1.clk, if1.start,if1.complete);
 	
endmodule
