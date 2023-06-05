///////////////////////////////////////RTL///////////////////////////////////////////////////////
module mul_datapath(done, clk, lda, ldb, ldp, clrp, decb,a,b,product);
    input clk, lda, ldb, ldp, clrp, decb;
    input [7:0] a;
    input [7:0] b;
output [7:0]product;
    wire [7:0]a_data,b_out;
    output done;

    rega load_a(a,lda,clk,a_data);

    regp p(a_data,ldp,clrp,clk,product);

    regb b_data(b, clk, ldb, decb,b_out);

    compare comp_b(done, b_out);

endmodule

// loading  a data  

module rega(in,lda,clk,out);  // in is input , ld to load , out is output
input [7:0] in;
input lda,clk;
output reg [7:0] out;
always@(posedge clk)

    if(lda)
	begin
            out<= in;
	end
endmodule


// reg p to clear if clear signal is activated and to add operation 

module regp(in,ldp,clrp,clk,out);  
input [7:0] in;
input ldp,clrp,clk;
output reg [7:0] out;
always@(posedge clk)

    if(clrp)
	out<= 4'b0;

    else if (ldp)     
        out<= out + in;

endmodule

// for comparing if b becomes 0 then to update the done signal

module compare(done,data);

input [7:0] data;

output reg done;

always @(data)
begin
if (data)
   done <= 0;
else 
 done <= 1;   
end

endmodule

// to load b data and to decrement 

module regb(in,clk,ldb,decb,out);  
    input clk, ldb, decb;
    input [7:0] in;
    output reg [7:0]out;
    always @(posedge clk)
        begin
            if(ldb) out <= in;
            else if(decb)
                out <= out-1;
        end
endmodule


//-------------------------------------------------------------

module mul_controlpath(done, lda, ldb, ldp, clrp, decb, clk, start,complete);

    input clk, start, done;

    output reg lda, ldb, ldp, clrp, decb, complete; 

    reg [2:0]state;

    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;

    always @(posedge clk)
        begin
            case(state)
                S0 : if(start) state<= S1;  
                S1 : state<=S2;
                S2 : state<= S3;
                S3 : #2 if(done) state<=S4;
                S4 : state<= S0;
                default : state<= S0; 
            endcase
        end 

    always @(state)
        begin
           case(state)
               S0: begin 
	             lda = 0; ldb = 0; ldp = 0; clrp = 1; decb = 0; complete = 0;  
		   end
               S1: begin 
	             lda = 1; clrp = 0; 
		   end   
               S2: begin 
		     lda = 0; ldb = 1; clrp = 0;  
		   end  
               S3: begin
                     ldb = 0; clrp =0;ldp = 1;  decb = 1;  
		   end
               S4: begin 
	             complete = 1; ldp = 0;  decb = 0; 
		   end
               default : begin 
		          lda = 0; ldb = 0; ldp = 0; clrp = 0; decb = 0;  
		         end 
           endcase
        end
endmodule

module multiplier(dut_if if1);

	
    	mul_datapath data_path(if1.done, if1.clk, if1.lda, if1.ldb, if1.ldp, if1.clrp, if1.decb,if1.a,if1.b,if1.product); 
    	mul_controlpath control_path(if1.done, if1.lda, if1.ldb, if1.ldp, if1.clrp, if1.decb, if1.clk, if1.start,if1.complete);
 	
endmodule

///////////////////////////////////////INTERFACE///////////////////////////////////////////////////////
interface dut_if();
  
  logic clk, start;
  logic [7:0]a,b,product;
  logic done;
  logic  lda, ldb, ldp, clrp,complete, decb;
  modport multiplier(input clk,start,a,b,output done,lda,ldb,ldp,clrp,decb,complete,product);

endinterface

///////////////////////////////////////SEQ_ITEM///////////////////////////////////////////////////////
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

///////////////////////////////////////SEQUENCE///////////////////////////////////////////////////////
class my_sequence extends uvm_sequence#(my_seq_item);
   `uvm_object_utils(my_sequence)

  my_seq_item req;
  int val;


  function new(string name = "my_sequence");
	super.new(name);
  endfunction


  task body;
   repeat(4)  
    begin
	req = my_seq_item::type_id::create("req");
	start_item(req);
	if(!req.randomize())
		`uvm_error("sequence","sequence item not recognized")
		//val=10*req.b;
		//#val;
        finish_item(req);

     end
  endtask
endclass

///////////////////////////////////////DRIVER///////////////////////////////////////////////////////



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

///////////////////////////////////////MONITOR///////////////////////////////////////////////////////
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

///////////////////////////////////////AGENT///////////////////////////////////////////////////////
class my_agent extends uvm_agent;

  `uvm_component_utils(my_agent)

  my_driver driv;
  my_mon mon;

  uvm_sequencer #(my_seq_item) sequencer;

  function new(string name , uvm_component parent);
	super.new(name , parent);
  endfunction


  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	driv = my_driver::type_id::create("driv",this);
	mon = my_mon::type_id::create("mon",this);
	sequencer = uvm_sequencer#(my_seq_item)::type_id::create("sequencer",this);
  endfunction

  function void connect_phase(uvm_phase phase);
	driv.seq_item_port.connect(sequencer.seq_item_export);
  endfunction

  task run_phase(uvm_phase phase);
	phase.raise_objection(this);
     begin
	   my_sequence seq;
	   seq = my_sequence::type_id::create("seq");
	   seq.start(sequencer);
	end
	phase.drop_objection(this);

  endtask
endclass


///////////////////////////////////////ENVIRONMENT///////////////////////////////////////////////////////


class my_env extends uvm_env;

  `uvm_component_utils(my_env)
   my_agent agent;

  function new(string name , uvm_component parent);
	super.new(name,parent);
  endfunction


  function void build_phase(uvm_phase phase);
	super.build_phase(phase);

	agent = my_agent::type_id::create("agent",this);

  endfunction

endclass



///////////////////////////////////////TEST_FILE///////////////////////////////////////////////////////
class my_test extends uvm_test;

   `uvm_component_utils(my_test)
   
   my_env env;

  function new(string name , uvm_component parent);
	super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = my_env::type_id::create("env",this);
  endfunction

  task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	begin
	
	  #10
	  `uvm_warning("from TEST","HI, I AM UVM")
	end
 	 phase.drop_objection(this);

 endtask


endclass


///////////////////////////////////////PACKAGE///////////////////////////////////////////////////////
package my_package;

	`include "uvm_macros.svh"
	 import uvm_pkg::*;
     `include "seq_item.svh"
	`include "my_sequence.svh"
	`include "my_driver.svh"
	`include "my_monitor.svh"
	`include "my_agent.svh"	
	`include "my_env.svh"
	`sinclude "my_test.svh"

endpackage



///////////////////////////////////////TOP///////////////////////////////////////////////////////


`include "my_package.svh"
`include "design.sv"
`include "dut_if.sv"


module top();

 import uvm_pkg::*;
 import my_package::*;

 dut_if if1();
 multiplier fl(if1);

 initial begin
   if1.clk = 1'b0;
   forever #5 if1.clk = ~if1.clk;
 end

 initial begin
   uvm_config_db#(virtual dut_if) :: set(null,"*","vif",if1);
   run_test("my_test");
  #600 $finish;
 end


endmodule
