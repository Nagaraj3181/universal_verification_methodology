class my_mon extends uvm_monitor;
   `uvm_component_utils(my_mon)

  int val;
  my_seq_item seq;
  virtual dut_if vif;

  uvm_analysis_port#(my_seq_item) mon_analysis;

  function new (string name , uvm_component parent);
	super.new(name,parent);
  endfunction


  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	mon_analysis = new("mon_analysis",this);
	if(!uvm_config_db #(virtual dut_if)::get(this,"","vif",vif))
	begin
	      `uvm_error("","virtual vif is not created")
	end
  endfunction

  virtual task run_phase (uvm_phase phase);
	super.run_phase(phase);
	seq = my_seq_item::type_id::create("seq",this);


	forever begin
		//@(posedge vif.clk)
		@(posedge vif.clk)
		seq.start <= vif.start;
		seq.a <= vif.a;
		seq.b <=vif.b;
		seq.lda <=vif.lda;
		seq.ldb <=vif.ldb;
		seq.ldp <=vif.ldp;
		seq.clrp <=vif.clrp;
		seq.decb <=vif.decb;
		seq.done <= vif.done;
		seq.product <= vif.product;
	
`uvm_info("monitor",$sformatf("a=%0d,b=%0d,lda=%0d,ldb=%0d,ldp=%0d,clrp=%0d,decb=%0d,done=%0d,product=%0d",seq.a,seq.b,seq.lda,seq.ldb,seq.ldp,seq.clrp,seq.decb,seq.done,seq.product),UVM_NONE)

		mon_analysis.write(seq);
    end

endtask
endclass



