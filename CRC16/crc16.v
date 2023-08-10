// Data: 8 bits
// Polynomial: X^16+X^12+X^5+1
// Data transfer code: {data, 0000 0000 0000 0000}

module crc16 (

input clk, rst_n,
input [7:0] data,
output reg [15:0] crc_code

);

reg [23:0] temp;

always @(posedge clk, negedge rst_n)
begin
if (!rst_n)
crc_code <= 16'd0;
else
crc_code <= temp[23:8];
end

always @(data, rst_n, temp)
begin : crc_reg

integer i;

temp = {data, {16{1'b0}}};

for (i=0; i<8; i=i+1)
begin
     if (temp[23])
			temp = {temp[22:20], temp[19]^1'b1, temp[18:13], temp[12]^1'b1, temp[11:8], temp[7]^1'b1, temp[6:0], temp[23]^1'b1};
     else
			temp = {temp[22:0], temp[23]};
end
end

endmodule 