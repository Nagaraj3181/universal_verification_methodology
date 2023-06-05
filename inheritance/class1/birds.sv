class birds;
	int size = 20;
	int life_time = 10;
	string colour ="brown";

	function void properties();
	$display (size,life_time,colour);
	endfunction
endclass

class parrot extends birds;
	string colour ="green";
	function void properties();
	$display(size,life_time,colour);
	endfunction

endclass


module a;
	birds b;
	parrot p;
	initial begin
	p = new();
	b = p;
	p.properties();
	b.properties();
	end
endmodule
