`timescale 1ns/100ps
module Adder_tb;

reg [31:0]a, b;
reg cin;
wire cout;
wire [31:0]sum;

Adder a1 (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

initial
begin : adder_test

integer i;
integer seed1, seed2, seed3;

seed1 = 1;
seed2 = 2;
seed3 = 3;

for (i=0; i<100; i=i+1)
begin

a = $random(seed1);
b = $random(seed2);
cin = $random(seed3);
#5;

end

#5 $stop;
#5 $finish;

end

initial
begin
$monitor ($time, " a=%h b=%h cin=%d sum=%h cout=%d\n", a, b, cin, sum, cout);
end

endmodule 