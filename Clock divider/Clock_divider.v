module Clock_divider (

input clk, rst,
input [15:0] N,
output clk_div

);

reg clk_p, clk_n;
reg [15:0] cnt_p, cnt_n;

assign clk_div = (N[0] == 1'b0) ? clk_p : (clk_p | clk_n);

always @(posedge clk, posedge rst)
begin
if (rst)
cnt_p <= 16'b0;
else if (cnt_p == (N-1))
cnt_p <= 16'd0;
else
cnt_p <= cnt_p + 16'd1;
end

always @(posedge clk, posedge rst)
begin
if (rst)
clk_p <= 1'b1;
else if (cnt_p < (N>>1))
clk_p <= 1'b1;
else
clk_p <= 1'b0;
end

always @(negedge clk, posedge rst)
begin
if (rst)
cnt_n <= 16'd0;
else if (cnt_n == (N-1))
cnt_n <= 16'd0;
else
cnt_n <= cnt_n + 16'd1;
end

always @(negedge clk, posedge rst)
begin
if (rst)
clk_n <= 1'b1;
else if (cnt_n < (N>>1))
clk_n <= 1'b1;
else
clk_n <= 1'b0;
end

endmodule 