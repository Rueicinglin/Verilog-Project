`timescale 1ns/100ps

module CLA_tb;

reg [7:0] A;
reg [7:0] B;
reg C_in;

wire [7:0] S;
wire C_out;

CLA #(.Width(8)) DUT (
                     .A(A),
		     .B(B),
		     .C_in(C_in),
		     .S(S),
		     .C_out(C_out)
		     );

initial begin

C_in = 1'b0;

forever #25 C_in = ~C_in;

end

initial begin : data

integer i;
integer seed1, seed2;

seed1 = 1;
seed2 = 2;

for(i=0; i<100; i=i+1)begin
A = $random(seed1);
B = $random(seed2);
#5;
end

$stop;
#5 $finish;

end

endmodule 
