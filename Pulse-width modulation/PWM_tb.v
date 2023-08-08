`timescale 1ns/100ps

module PWM_tb;

reg clk, rst;
reg clr, en;

wire PWM_out;

/*
duty=0, 0%
duty=1, 12.5%
duty=2, 25%
duty=3, 37.5%
duty=4, 50%
duty=5, 62.5%
duty=6, 75%
duty=7, 87.5%
duty=8, 100%
*/
PWM #(.duty(32'd4), .Period(32'd7)) DUT (.clk(clk), .rst(rst), .clr(clr), .en(en), .PWM_out(PWM_out));

initial
begin
clk = 1'b0;
rst = 1'b0;
clr = 1'b0;
en = 1'b1;

forever #5 clk = ~clk;

end

initial
begin
#10 rst = 1'b1;
#10 rst = 1'b0;
#1045 $stop;
#10 $finish;
end

endmodule 