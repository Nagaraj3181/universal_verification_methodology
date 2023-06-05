module mul_datapath(done, clk, lda, ldb, ldp, clrp, decb,a,b);
    input clk, lda, ldb, ldp, clrp, decb;
    input [7:0] a;
    input [7:0] b;
    wire [7:0]a_data,product,b_out;
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




