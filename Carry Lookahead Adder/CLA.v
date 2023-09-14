/************************************
Carry Lookahead Adder
Width: initial 4-bits
Input: A, B
Output: S, C_out
************************************/

module CLA #(parameter Width = 4) (

input [Width-1:0] A,
input [Width-1:0] B,
input C_in,

output reg [Width-1:0] S,
output C_out

);

wire [Width-1:0] G, P;
reg [Width:0] C;

//calculate G, P

genvar i;
generate

for (i=0; i<Width; i=i+1)begin : gen_pro_cal
gen_pro m0 (.A(A[i]),
            .B(B[i]),
				.G(G[i]),
				.P(P[i]));

end

endgenerate

always @(P, C)begin : Sum_cal

integer j;

for (j=0; j<Width; j=j+1)
S[j] = P[j] ^ C[j];

end

//calculate C

always @(G, C, P)begin : Carry_cal

integer k;

C[0] = C_in;
for (k=1; k<=Width; k=k+1)
C[k] = G[k-1] | (C[k-1] & P[k-1]);

end

assign C_out = C[Width];

endmodule

module gen_pro (

input A, B,
output G, P

);

assign G = A & B;
assign P = A ^ B;

endmodule 