module addder(dut_if if1);

	always @(posedge if1.clk)
		begin
		if(if1.rstn)
			begin
			if1.sum <= 0;
			if1.carry <= 0;
			end
		else
			begin
			if1.sum <= if1.a ^ if1.b;
			if1.carry <= if1.a & if1.b;	
			end				
		end
endmodule
