module lfsr (input clk, rst, output reg [3:0] out_r);

wire feedback;

assign feedback = ~(out_r[3] ^ out_r[2]);

always @(posedge clk, posedge rst)
begin
if (rst)
out_r <= 4'b0000;
else
out_r <= {out_r[2:0], feedback};
end

endmodule 