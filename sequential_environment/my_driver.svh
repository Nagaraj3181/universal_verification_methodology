class my_driver extends uvm_driver#(my_seq_item);
  `uvm_component_utils(my_driver)
  
  int val;
  my_seq_item req;
  virtual dut_if vif;

  function new (string name , uvm_component parent);
	super.new(name,parent);
  endfunction


  function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	if(!uvm_config_db #(virtual dut_if)::get(this,"","vif",vif))
	begin
	`uvm_error("","virtual vif is not created")
	end
  endfunction


 virtual task run_phase(uvm_phase phase);
	super.run_phase(phase);

	vif.start <= 1'b1;
	@(posedge vif.clk)
	
     forever begin
		seq_item_port.get_next_item(req);
		@(posedge vif.clk)
		req.start <= 1'b1;
		
		vif.a <= req.a;
		vif.b <= req.b;
		@(posedge vif.clk)
		@(posedge vif.clk)
		@(posedge vif.clk)
		
`uvm_info("driver to interface",$sformatf("start=%0d,a=%0d,b=%0d,lda=%0d,ldb=%0d,ldp=%0d,clrp=%0d,decb=%0d,done=%0d,product=%0d",req.start,req.a,req.b,req.lda,req.ldb,req.ldp,req.clrp,req.decb,req.done,req.product),UVM_NONE)

		val=10*req.b;
		#val;
		seq_item_port.item_done(req);

	

	end
  endtask
endclass
