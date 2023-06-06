
class component_b extends uvm_component;
  
  transaction trans;
  uvm_blocking_get_port#(transaction) trans_in;  

  `uvm_component_utils(component_b)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_in = new("trans_in", this);
  endfunction : new

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    repeat (20)
begin
    `uvm_info(get_type_name(),$sformatf(" Before calling port get method"),UVM_LOW)
    trans_in.get(trans);
    `uvm_info(get_type_name(),$sformatf(" After  calling port get method"),UVM_LOW)
    `uvm_info(get_type_name(),$sformatf(" Printing trans, \n %s",trans.sprint()),UVM_LOW)
    #20;
end
    phase.drop_objection(this);
  endtask : run_phase

endclass : component_b