`timescale 1ns/100ps

module Unsigned_divider_tb;

reg [3:0] a, b;
wire [3:0] D, R;
wire err;

Unsigned_divider DUT (.a(a), .b(b), .D(D), .R(R), .err(err));

initial
begin
a = 4'd0;
b = 4'd0;
#5;
end

initial
begin : divider_test

integer i;
integer seed1, seed2;
seed1 = 1;
seed2 = 2;

for (i=0; i<20; i=i+1)
begin
a = $random(seed1);
b = $random(seed2);
#5;
end

$stop;
#5 $finish;
end

endmodule 