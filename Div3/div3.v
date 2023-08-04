module div3 (
input clk, rst_n,
output div3_out
);
	
reg [1:0] cnt_p, cnt_n;
reg div_p, div_n;
	
assign div3_out = div_p | div_n;

always @(posedge clk, negedge rst_n)
begin
if (!rst_n)
cnt_p <= 2'd0;
else if(cnt_p == 2'd2)
cnt_p <= 2'd0;
else
cnt_p <= cnt_p + 2'd1;
end
	
always @(posedge clk, negedge rst_n)
begin
if (!rst_n)
div_p <= 1'b1;
else if (cnt_p < 2'd1)
div_p <= 1'b1;
else
div_p <= 1'b0;
end

always @(negedge clk, negedge rst_n)
begin
if (!rst_n)
cnt_n <= 2'd0;
else if(cnt_n == 2'd2)
cnt_n <= 2'd0;
else
cnt_n <= cnt_n + 2'd1;
end
	
always @(negedge clk, negedge rst_n)
begin
if (!rst_n)
div_n <= 1'b1;
else if (cnt_n < 2'd1)
div_n <= 1'b1;
else
div_n <= 1'b0;
end

endmodule	 
