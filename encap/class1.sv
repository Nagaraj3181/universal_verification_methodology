class base;
	local int i;

	task set(int j);
	i = j;
	$display(i);
endtask
endclass

program main;
	initial begin

	base b = new();
	b.set(123);
	end
endprogram


