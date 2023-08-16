module multi_cell #(parameter M = 4, N = 4)(
input clk,
input rst_n,
input [M+N-1:0] multi1,
input [N-1:0] multi2,
input en,
input [M+N-1:0] multi_acci,

output reg [M+N-1:0] multi1_shift,
output reg [N-1:0] multi2_shift,
output reg [M+N-1:0] multi_acco,
output reg rdy
);

always @(posedge clk, negedge rst_n)begin

if (!rst_n)begin
multi1_shift <= 'd0;
multi2_shift <= 'd0;
multi_acco <= 'd0;
rdy <= 1'b0;
end

else if (en)begin
multi1_shift <= multi1 << 1;
multi2_shift <= multi2 >> 1;
rdy <= 1'b1;

if (multi2[0])begin
multi_acco <= multi_acci + multi1;
end

else begin
multi_acco <= multi_acci;
end

end

else begin
multi1_shift <= 'd0;
multi2_shift <= 'd0;
multi_acco <= 'd0;
rdy <= 1'b0;
end

end

endmodule 