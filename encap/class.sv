class base;
	local int i;
	//protected int i;
endclass

program main;
initial begin

base b = new();
b.i = 123;
end
endprogram
