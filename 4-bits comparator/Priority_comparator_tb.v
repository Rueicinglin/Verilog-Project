`timescale 1ns/100ps

module Priority_comparator_tb;

reg clk, rst_n;
reg [3:0] A, B;
wire Y2, Y1, Y0;

Priority_comparator DUT (.clk(clk), .rst_n(rst_n), .A(A), .B(B), .Y2(Y2), .Y1(Y1), .Y0(Y0));

initial begin

rst_n = 1'b0;
clk = 1'b0;

forever #5 clk = ~clk;

end

initial begin

#16 rst_n = 1'b1;

end

initial
begin : comp_tb

integer i;
integer seed1, seed2;

seed1 = 1;
seed2  =2;

for (i=0; i<100; i=i+1)begin

A = $random(seed1);
B = $random(seed2);
#10;

end
$stop;
#10 $finish;

end

endmodule 