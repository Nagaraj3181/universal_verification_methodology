interface dut_if();
logic a,b,cin,clk,rst;
logic  sum,carry;

modport full_adder(input a,b,cin,clk,rst,output sum,carry);

endinterface
