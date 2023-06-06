
class component_a extends uvm_component;
  
  transaction trans;
  uvm_blocking_put_port#(transaction) trans_out; 
  
  `uvm_component_utils(component_a)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    trans_out = new("trans_out", this); 
  endfunction : new

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    repeat (20) 
	begin
    trans = transaction::type_id::create("trans", this);

    void'(trans.randomize());
    `uvm_info(get_type_name(),$sformatf(" tranaction randomized"),UVM_LOW)
    `uvm_info(get_type_name(),$sformatf(" Printing trans, \n %s",trans.sprint()),UVM_LOW)
    
    `uvm_info(get_type_name(),$sformatf(" Before calling port put method"),UVM_LOW)
    trans_out.put(trans);
    `uvm_info(get_type_name(),$sformatf(" After  calling port put method"),UVM_LOW)
    #5;
end
    phase.drop_objection(this);
  endtask : run_phase

endclass : component_a