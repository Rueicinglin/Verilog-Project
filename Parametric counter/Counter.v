module Counter #(parameter count = 32'd99) (

input clk, rst,
input clr, en,
output reg [31:0] cnt

);

always @(posedge clk, posedge rst)
begin
if (rst)
cnt <= 32'd0;
else if (clr)
cnt <= 32'd0;
else if (en)
cnt <= (cnt == count) ? 32'd0 : (cnt + 32'd1);
end

endmodule 