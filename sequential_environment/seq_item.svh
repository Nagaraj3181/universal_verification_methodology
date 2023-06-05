class my_seq_item extends uvm_sequence_item;
  
     `uvm_object_utils(my_seq_item)

  logic clk, start;
  randc logic [7:0]a,b;
  logic done;
  logic  lda, ldb, ldp, clrp, decb;
  logic [7:0] product;

  constraint consta {a<10;}
  constraint constb {b<10;}

  function new (string name = "my_seq_item");
	super.new(name);
  endfunction

endclass







