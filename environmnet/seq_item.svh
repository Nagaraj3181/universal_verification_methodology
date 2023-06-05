//SEQUENCE ITEM
class seq_item extends uvm_sequence_item;
 `uvm_object_utils(seq_item)

 rand bit cmd;
 rand logic [7:0] addr;
 rand logic [7:0] data;
 
 constraint c_addr { addr>0; addr<100;};
 constraint c_data { data>0; data<100;}; 

 function new( string name = " "); //NAME CAN BE GUVEN HERE
  super.new(name);
 endfunction
endclass:seq_item
