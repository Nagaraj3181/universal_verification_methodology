interface dut_if();
  
  logic clk, start;
  logic [7:0]a,b,product;
  logic done;
  logic  lda, ldb, ldp, clrp,complete, decb;
  modport multiplier(input clk,start,a,b,output done,lda,ldb,ldp,clrp,decb,complete,product);

endinterface
