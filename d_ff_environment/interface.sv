interface design_if;

bit clk,rst;
logic [3:0] din;
logic [3:0] qout;

modport dff(input clk,rst,din,output qout);

endinterface
