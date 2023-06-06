
`include "environment.sv"

class basic_test extends uvm_test;

  `uvm_component_utils(basic_test)
  

  environment env;


  function new(string name = "basic_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);


    env = environment::type_id::create("env", this);
  endfunction : build_phase

  
  virtual function void end_of_elaboration();
    //print's the topology
    print();  
  endfunction 
endclass : basic_test