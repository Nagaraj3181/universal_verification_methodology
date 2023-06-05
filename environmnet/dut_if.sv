//DUT INTERFACE
interface dut_if;
 bit clock,reset;
 bit cmd;
 logic [7:0] addr;
 logic [7:0] data;
endinterface
