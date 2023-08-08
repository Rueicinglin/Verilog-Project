`timescale 1ns/100ps
module Counter_tb;

reg clk, rst;
reg clr, en;
wire [31:0] cnt;

Counter #(.count(32'd15)) DUT (.clk(clk), .rst(rst), .clr(clr), .en(en), .cnt(cnt));

initial
begin
clk = 1'b0;
rst = 1'b0;
clr = 1'b0;
en = 1'b1;
forever #5 clk = ~clk;
end

initial
begin
#10 rst = 1'b1;
#10 rst = 1'b0;
#100 clr = 1'b1;
#10 clr = 1'b0;
#50 en = 1'b0;
#50 en = 1'b1;
#200 rst = 1'b1;
#10 rst = 1'b0;
#200 $stop;
#10 $finish;
end

endmodule 