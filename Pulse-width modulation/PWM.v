module PWM #(parameter duty = 32'd1, Period = 32'd8) (

input clk, rst,
input clr, en,
output reg PWM_out

);

//parameter P = 32'd8;
wire [31:0] cnt;

Counter #(.count(Period)) c1 (.clk(clk), .rst(rst), .clr(clr), .en(en), .cnt(cnt));

always @(posedge clk, posedge rst)
begin
if (rst)
PWM_out <= 1'b0;
else if (cnt < duty)
PWM_out <= 1'b1;
else
PWM_out <= 1'b0;
end

endmodule 