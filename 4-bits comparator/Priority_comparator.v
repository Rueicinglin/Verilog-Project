/**************************************

Using bits slide construction

input: 4 bits A, B
output: Y2 (A > B)
        Y1 (A = B)
		  Y0 (A < B)

**************************************/
module Priority_comparator(

input clk, rst_n,
input [3:0] A,
input [3:0] B,

output reg Y2, Y1, Y0

);

wire [3:0] Y2_reg, Y1_reg, Y0_reg;

//MSB first Compare

Priority p3 (.A(A[3]),
             .B(B[3]),
             .last_Y2(1'b0),
             .last_Y1(1'b0),
             .last_Y0(1'b0),
             .Y2(Y2_reg[3]),
             .Y1(Y1_reg[3]),
             .Y0(Y0_reg[3]));

//Compared register

always @(posedge clk, negedge rst_n)
begin

if (!rst_n)begin
{Y2, Y1 ,Y0} <= 3'b000;
end
else begin
{Y2, Y1, Y0} <= {Y2_reg[0], Y1_reg[0], Y0_reg[0]};
end
end

// Compare other bits

genvar i;

generate

for (i=2; i>=0; i=i-1)begin : priority_compare
    
    Priority p1 (.A(A[i]),
                 .B(B[i]),
                 .last_Y2(Y2_reg[i+1]),
                 .last_Y1(Y1_reg[i+1]),
                 .last_Y0(Y0_reg[i+1]),
                 .Y2(Y2_reg[i]),
                 .Y1(Y1_reg[i]),
                 .Y0(Y0_reg[i]));
end

endgenerate

endmodule

module Priority (

input A,
input B,
input last_Y2, last_Y1, last_Y0,

output reg Y2, Y1, Y0

);

always @(A, B, last_Y2, last_Y1, last_Y0)
begin

if (last_Y2)begin
   {Y2, Y1, Y0} = 3'b100;
end
else if (last_Y1)begin
   if (A > B)
	   {Y2, Y1, Y0} = 3'b100;
   else if (A == B)
	   {Y2, Y1, Y0} = 3'b010;
	else 
	   {Y2, Y1, Y0} = 3'b001;
end
else if (last_Y0)begin
   {Y2, Y1, Y0} = 3'b001;
end
else begin
   if (A > B)
	   {Y2, Y1, Y0} = 3'b100;
   else if (A == B)
	   {Y2, Y1, Y0} = 3'b010;
	else 
	   {Y2, Y1, Y0} = 3'b001;
end

end

endmodule 