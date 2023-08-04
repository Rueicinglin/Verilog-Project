module Adder #(parameter Width = 32) (

input [Width-1:0] a, b,
input cin,
output [Width-1:0] sum,
output cout

);

wire [Width-1:0] co;
FA f0 (a[0], b[0], cin, sum[0], co[0]);

generate

genvar i;

for (i=1; i<Width; i=i+1)
begin : multi_adder

FA f1 (a[i], b[i], co[i-1], sum[i], co[i]);

end

endgenerate

assign cout = co[Width-1];

endmodule

module FA (

input a, b, cin,
output sum, cout

);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | cin & (a ^ b);

endmodule 