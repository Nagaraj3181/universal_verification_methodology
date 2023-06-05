module dff(design_if if1);

always @(posedge if1.clk)
begin
	if(if1.rst)
		if1.qout = 4'b0;
	else
	if1.qout = if1.din;
end
endmodule
