`timescale 1ns/100ps

module lfsr_tb;

reg clk, rst;
wire [3:0] out_r;

lfsr DUT (.clk(clk), .rst(rst), .out_r(out_r));

initial
begin

clk = 1'b0;
rst = 1'b1;

forever #5 clk = ~clk;

end

initial
begin

#10 rst = 1'b0;
#200 $stop;
#10 $finish;

end

endmodule 