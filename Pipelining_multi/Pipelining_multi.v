module Pipelining_multi #(parameter M = 4, N = 4) (
input clk,
input rst_n,
input [M-1:0] multi1,
input [N-1:0] multi2,
input en,

output [M+N-1:0] result,
output rdy
);

wire [M+N-1:0] multi1_shift [N-1:0];
wire [N-1:0] multi2_shift [N-1:0];
wire [M+N-1:0] multi_acco [N-1:0];
wire [N-1:0] rdy_temp;

/*************************************************

first multi_cell inputs using real multi1, multi2

**************************************************/

multi_cell #(.M(M), .N(N)) m0(

.clk(clk),
.rst_n(rst_n),
.multi1({{N{1'b0}}, multi1}),
.multi2(multi2),
.en(en),
.multi_acci('d0),
.multi1_shift(multi1_shift[0]),
.multi2_shift(multi2_shift[0]),
.multi_acco(multi_acco[0]),
.rdy(rdy_temp[0])

);

/*************************************************

using generate block to implement multiple module

**************************************************/

genvar i;

generate

for (i=1; i<N; i=i+1)begin : multiple_module
multi_cell #(.M(M), .N(N)) m1 (

.clk(clk),
.rst_n(rst_n),
.multi1(multi1_shift[i-1]),
.multi2(multi2_shift[i-1]),
.en(en),
.multi_acci(multi_acco[i-1]),
.multi1_shift(multi1_shift[i]),
.multi2_shift(multi2_shift[i]),
.multi_acco(multi_acco[i]),
.rdy(rdy_temp[i])

);

end

endgenerate

assign result = multi_acco[N-1];
assign rdy = rdy_temp[N-1];

endmodule 