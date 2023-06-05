interface dut_if();
logic clk,rstn;
logic a , b;
logic sum , carry;

modport addder(input clk,rstn,a,b, output sum,carry);

endinterface
