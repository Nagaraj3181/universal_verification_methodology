class header;
int id;
function new(int id);
	this.id = id;
endfunction
endclass

class packet;
int addr;
int data;
header hdr;

function new(int addr,int data,int id);
	hdr = new();
	this.addr=addr;
	this.data = data;
endfunction
endclass


module
header h1;
packet p1,p2;

initial begin

endmodule
