`include "package.sv"
module top();
import uvm_pkg::*;
import pack::*;

  alu_seq_item seq0, seq1, seq3;
  
initial begin

run_test("test");

end
  
  initial begin
    seq0 = alu_seq_item::typed_id::create("seq0", this);
    seq1 = alu_seq_item::typed_id::create("seq1", this);
    seq0.randomize();
    seq0.print();	// print
    seq1.copy(seq0);	//copy
    
    $cast(seq3, seq1.clone());
    
    if(seq3.compare(seq1)) begin
      $display("both sequence items are equal");
    end
    else
      $display("sequence items are NOT equal");
    
  end
endmodule