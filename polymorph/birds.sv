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

class m_parrot extends parrot;
	string colour = "multi";
	function void properties();
	$display(size,life_time,colour);
	endfunction
endclass


module a;
	birds b;
	parrot p;
	m_parrot m;
	initial begin
	m = new();
	//p = m;
	b = m;
	b.properties();
	end
endmodule
