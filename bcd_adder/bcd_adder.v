module bcd_adder (

input [3:0] a, b,
input cin,
output cout,
output [3:0] sum

);

wire [3:0] temp_s, temp_w;
wire [2:0] w;
wire temp_cout, carry;

FA f0 (a[0], b[0], cin, w[0], temp_s[0]);
FA f1 (a[1], b[1], w[0], w[1], temp_s[1]);
FA f2 (a[2], b[2], w[1], w[2], temp_s[2]);
FA f3 (a[3], b[3], w[2], temp_cout, temp_s[3]);

assign carry = (temp_s[3] & temp_s[2]) | (temp_s[3] & temp_s[1]);
assign cout = temp_cout | carry;

FA f4 (temp_s[0], 1'b0, 1'b0, temp_w[0], sum[0]);
FA f5 (temp_s[1], cout, temp_w[0], temp_w[1], sum[1]);
FA f6 (temp_s[2], cout, temp_w[1], temp_w[2], sum[2]);
FA f7 (temp_s[3], 1'b0, temp_w[2], temp_w[3], sum[3]);

endmodule

module FA (input a, b, cin, output cout, sum);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (cin & (a ^ b));

endmodule 