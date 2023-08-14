module ALU (

input [15:0] a, b,
input [2:0]  ALU_control,
output reg [15:0] result,
output zero

);

always @(a ,b, ALU_control)
begin

case (ALU_control)
3'b000: result = a + b;
3'b001: result = a - b;
3'b010: result = a & b;
3'b011: result = a | b;
3'b100: result = (a < b) ? 16'd1 : 16'd0;
default: result = 16'd0;
endcase

end

assign zero = (result == 16'd0) ? 1'b1 : 1'b0;

endmodule 