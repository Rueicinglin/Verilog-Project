/////////////////////////////////////////////////////////
//UART_TX Implementation
/////////////////////////////////////////////////////////
//
// baud_rate_cnt = (Frequency of clk)/(Frequency of UART)
// Ex. clock = 50MHz, baud_rate = 9600;
// baud_rate_cnt = 100M/9600 = 5208


module UART_RX 
  #(parameter baud_rate_cnt = 5208)
  (
   input clk,
	input rst_n,
	input data_serial,
	output out_RX_D,
	output [7:0] out_RX_byte
	);
	
	localparam IDLE = 3'b000;
	localparam START = 3'b001;
	localparam DATA_BIT = 3'b010;
	localparam STOP = 3'b011;
	localparam DONE = 3'b100;
	
	reg r_RX_data1;
	reg r_RX_data;
	
	reg [15:0] baud_cnt;
	reg [2:0] state;
	reg [2:0] data_index;
	reg [7:0] r_RX_byte;
	reg r_done;
	
	//Two-stage register
	//Propose: To synchronize data for avoiding metastable;	
	always @(posedge clk, negedge rst_n)
	begin
	  if (!rst_n)
	  begin
	    r_RX_data1 <= 1'b0;
	    r_RX_data <= 1'b0;
	  end
	  else
	  begin
	    r_RX_data1 <= data_serial;
	    r_RX_data <= r_RX_data1;
	  end
	end
	
	//State transition
	//Baud_rate counter (Usually sample the data at middle of the data_serial);
   always @(posedge clk, negedge rst_n)
   begin
	  if (!rst_n)
	  begin
	    state <= IDLE;
		 baud_cnt <= 16'd0;
	    data_index <= 3'd0;
	    r_RX_byte <= 8'd0;
	    r_done <= 1'b0;
	  end
	  else
	  begin
	  
	    case (state)
		 IDLE:
		   begin
			  baud_cnt <= 16'd0;
			  data_index <= 3'd0;
			  r_RX_byte <= 8'd0;
			  r_done <= 1'b0;
			  
			  if (r_RX_data == 1'b0)
			    state <= START;
			  else
			    state <= IDLE;
			end
		 
		 START:
		   begin
			  if (baud_cnt == (baud_rate_cnt-1)/2)
			  begin
			    if (r_RX_data == 1'b0)
				 begin
			      baud_cnt <= 16'd0; //reset counter for sampling dtat_serial at middle
					state <= DATA_BIT;
				 end
				 else
				   state <= IDLE;
			  end
			  else
			  begin
			    baud_cnt <= baud_cnt + 16'd1;
				 state <= START;
			  end
			end
			
		 DATA_BIT:
		   begin
			  if (baud_cnt < (baud_rate_cnt-1))
			  begin
			    baud_cnt <= baud_cnt + 16'd1;
				 state <= DATA_BIT;
			  end
			  else
			    begin
				 baud_cnt <= 16'd0;
				 r_RX_byte[data_index] <= r_RX_data;
				 
				 if (data_index < 3'd7)
				 begin
				   data_index <= data_index + 3'd1;
					state <= DATA_BIT;
				 end
				 else
				 begin
				   data_index <= 3'd0;
				   state <= STOP;
				 end
			  end
			end

		  STOP:
		    begin
			   if (baud_cnt < (baud_rate_cnt-1))
				begin
				  baud_cnt <= baud_cnt + 16'd1;
				  state <= STOP;
				end
				else
				begin
				  if (r_RX_data)
				  begin
				    baud_cnt <= 16'd0;
					 r_done <= 1'b1;
					 state <= DONE;
				  end
				  else
				  begin
				    baud_cnt <= 16'd0;
					 r_done <= 1'b0;
					 state <= IDLE;
				  end
				end
			 end
			 
		  DONE:
		    begin
			   if (r_RX_data)
				begin
			     r_done <= 1'b1;
				  state <= DONE;
				end
				else
				begin
				  r_done <= 1'b0;
				  r_RX_byte <= 8'd0;
				  state <= START;
				end
			 end
		  
		  default: state <= IDLE;
		  
		  endcase
		  
	   end
	 end
	 
  assign out_RX_D = (state == DONE) ? r_done : 1'b0;
  assign out_RX_byte = (state == DONE) ? r_RX_byte : 8'd0;
				 
	
	endmodule 