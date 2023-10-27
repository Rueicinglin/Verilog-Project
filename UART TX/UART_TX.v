/********************************

Baud rate : 9600 Hz
Clk = 50MHz, 50M/9600 = 5208.33
Low-active reset

*********************************/

module UART_TX(

               input clk_50M,
               input rst_n,
               input write_en,
               input [7:0] write_data,
               output reg uart_txd,
               output busy

              );

wire load_en, shift_en, TX_H, cnt_en, cnt_rst;
reg [7:0] reg_data;
reg [2:0] count;
reg [12:0] count_baud;
reg baud_tick;

/******UART_SM Instantation******/

UART_SM U0 (.clk_50M(clk_50M),
            .rst_n(rst_n),
				.baud(baud_tick),
				.en(write_en),
				.cnt(count),
				.load_en(load_en),
				.shift_en(shift_en),
				.TX_H(TX_H),
				.cnt_en(cnt_en),
				.cnt_rst(cnt_rst),
				.busy(busy));
				
/******Load & Shift data******/

always @(posedge clk_50M, negedge rst_n)begin
    if (!rst_n)begin
	    reg_data <= 8'd0;
	 end
	 else begin
	    if (baud_tick)begin
		    if (load_en)
			    reg_data <= write_data;
			 else if (shift_en)
			    reg_data <= reg_data >> 1;
			 else
			    reg_data <= reg_data;
		 end
		 else begin
		    reg_data <= reg_data;
		 end
	 end
end

/******Counter 8******/

always @(posedge clk_50M, negedge rst_n)begin
    if (!rst_n)begin
	    count <= 3'd0;
	 end
	 else begin
	    if (baud_tick)begin
		    if (cnt_en)
		       count <= count + 3'd1;
		    else if (cnt_rst)
		       count <= 3'd0;
		    else
		       count <= count;
		 end
	 end
end

/******Counter 5208******/

always @(posedge clk_50M, negedge rst_n)begin
    if (!rst_n)begin
	    count_baud <= 13'd0;
	 end
	 else begin
	    if (count_baud < 13'd5207)begin
		    count_baud <= count_baud + 13'd1;
			 baud_tick <= 1'b0;
		 end
		 else begin
		    count_baud <= 13'd0;
			 baud_tick <= 1'b1;
		 end
	 end
end

/******UART_TX Data Output******/
always @(posedge clk_50M, negedge rst_n)begin
    if (!rst_n)begin
	    uart_txd <= 1'b1;
	 end
	 else begin
	    if (baud_tick)begin
		    if (shift_en)
			    uart_txd <= reg_data[0];
			 else
			    uart_txd <= TX_H;
		 end
		 else
		    uart_txd <= uart_txd;
	 end
end

endmodule	

/******UART State Mechine******/

module UART_SM(

               input clk_50M,
               input rst_n,
               input baud,
               input en,
               input [2:0] cnt,
               output reg load_en,
               output reg shift_en,
               output reg TX_H,
               output reg cnt_en,
               output reg cnt_rst,
               output reg busy

              );

/******state parameter******/

localparam IDLE  = 2'd0;
localparam START = 2'd1;
localparam SHIFT = 2'd2;
localparam STOP  = 2'd3;

reg [1:0] state, nstate;

//assign busy = (state != IDLE);
always @(posedge clk_50M, negedge rst_n)begin
    if (!rst_n)begin
	    busy <= 1'b0;
	 end
	 else begin
	    if (baud)
		    busy <= (state == IDLE) ? 1'b0 : 1'b1;
		 else
		    busy <= busy;
	 end
end

/******State Flow Diagram******/

always @(*)begin
    case (state)
	     IDLE: nstate = (en) ? START : IDLE;
		  START: nstate = SHIFT;
		  SHIFT: nstate = (cnt == 3'd7) ? STOP : SHIFT;
		  STOP: nstate = IDLE;
		  default: nstate = IDLE;
	 endcase
end

/******State to Next_state******/

always @(posedge clk_50M, negedge rst_n)begin
    if (!rst_n)begin
	    state <= IDLE;
	 end
	 else begin
	    if (baud)begin
		    state <= nstate;
		 end
		 else begin
		    state <= state;
		 end
	 end
end

/******Control Signals******/

always @(*)begin
    if (!rst_n)begin
      load_en  = 1'b0;
      shift_en = 1'b0;
      TX_H     = 1'b1;
      cnt_en   = 1'b0;
      cnt_rst  = 1'b1;
	 end
    else begin
	     case (state)
		      IDLE: begin
                  load_en  = 1'b0;
                  shift_en = 1'b0;
                  TX_H     = 1'b1;
                  cnt_en   = 1'b0;
                  cnt_rst  = 1'b1;
            end
		      START: begin
                  load_en  = 1'b1;
                  shift_en = 1'b0;
                  TX_H     = 1'b0;
                  cnt_en   = 1'b0;
                  cnt_rst  = 1'b1;
            end
		      SHIFT: begin
                  load_en  = 1'b0;
                  shift_en = 1'b1;
                  TX_H     = 1'b0;
                  cnt_en   = 1'b1;
                  cnt_rst  = (cnt == 3'd7) ? 1'b1 : 1'b0;
            end
		      STOP: begin
                  load_en  = 1'b0;
                  shift_en = 1'b0;
                  TX_H     = 1'b1;
                  cnt_en   = 1'b0;
                  cnt_rst  = 1'b0;
            end
				default: begin
                  load_en  = 1'b0;
                  shift_en = 1'b0;
                  TX_H     = 1'b1;
                  cnt_en   = 1'b0;
                  cnt_rst  = 1'b0;
            end
	     endcase
    end
end

endmodule  