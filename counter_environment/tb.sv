module tb();
reg clk,rst;
wire [3:0]count;

counter dut(.*);

initial begin
clk = 1'b0;
rst = 1'b1;
end

always #5 clk = ~clk;

initial begin
#10 rst = 1'b0;

//#50 rst = 1'b1;

#200 $finish;
end
endmodule
