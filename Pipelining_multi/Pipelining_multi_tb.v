`timescale 1ns/100ps

module Pipelining_multi_tb #(parameter M = 7, N = 4);

reg clk, rst_n;
reg en;
reg [M-1:0] multi1;
reg [N-1:0] multi2;
wire rdy;
wire [N+M-1:0] result;

Pipelining_multi #(.M(M), .N(N)) DUT (
.clk(clk),
.rst_n(rst_n),
.multi1(multi1),
.multi2(multi2),
.en(en),

.result(result),
.rdy(rdy)
);

//clock generation
initial begin
clk = 1'b0;
rst_n = 1'b0;

forever #5 clk = ~clk;
end

//data driver
initial begin
#50;
rst_n = 1'b1;
#5;
@(negedge clk ) ;
en = 1'b1 ;
multi1 = 25; multi2 = 5;
#10 ; multi1 = 16; multi2 = 10;
#10 ; multi1 = 10; multi2 = 4;
#10 ; multi1 = 15; multi2 = 7;
multi2 = 7;   repeat(32) #10 multi1 = multi1 + 1 ;
multi2 = 1;   repeat(32) #10 multi1 = multi1 + 1 ;
multi2 = 15;  repeat(32) #10 multi1 = multi1 + 1 ;
multi2 = 3;   repeat(32) #10 multi1 = multi1 + 1 ;
multi2 = 11;  repeat(32) #10 multi1 = multi1 + 1 ;
multi2 = 4;   repeat(32) #10 multi1 = multi1 + 1 ;
multi2 = 9;   repeat(32) #10 multi1 = multi1 + 1 ;

#10 $stop;
#10 $finish;
end

endmodule 