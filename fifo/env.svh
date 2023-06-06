
`include "transaction.sv"
`include "component_a.sv"
`include "component_b.sv"

class environment extends uvm_env;
  
 
  component_a comp_a;
  component_b comp_b;
  
  uvm_tlm_fifo #(transaction) fifo_ab;
  
  `uvm_component_utils(environment)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    comp_a = component_a::type_id::create("comp_a", this);
    comp_b = component_b::type_id::create("comp_b", this);
    
    fifo_ab = new("fifo_ab", this,16);
  endfunction : build_phase
 
  function void connect_phase(uvm_phase phase);
    comp_a.trans_out.connect(fifo_ab.put_export);
    comp_b.trans_in.connect(fifo_ab.get_export);
  endfunction : connect_phase
  
  virtual task run_phase (uvm_phase phase);
    forever begin
      #10;
      if (fifo_ab.is_full())
        `uvm_info ("FIFO FULL","fifo is full",UVM_MEDIUM)
        if (fifo_ab.is_empty())
          `uvm_info ("FIFO EMPTY","fifo is empty",UVM_MEDIUM)
          end
        endtask
endclass : environment