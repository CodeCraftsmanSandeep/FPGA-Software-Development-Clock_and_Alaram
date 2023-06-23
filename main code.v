`timescale 1ns/1ps

// L16 pin has a frequency of 125 MHZ
/*
125000000/2 = 62500000
25 states in counter hour
61 states in counter minutes
61 states in counter secounds
two states in alarm
*/

module generate_1s(input clk, output clk_1s);
  reg [2:0]temp = 3'b000;
  reg clk_temp = 1'b0;
  always @ (posedge clk)
    begin
      temp = temp + 3'b001;
      if(temp > 3'b001) // 62500000
        begin
            clk_temp = ~clk_temp;
            temp <= 3'b000;
        end
    end
  assign clk_1s = clk_temp;
endmodule

module clock(input load_time, load_alarm, off_alarm, clk, reset, input [1:0]H1, input [3:0]H0, input [2:0]M1, input [3:0]M0, output clk_1s, output [1:0]h1out, output [3:0]h0out, output [2:0]m1out, output [3:0]m0out, output [2:0]s1out, output [3:0]s0out, output reg alarm, output reg [6:0]displayH1, displayH0, displayM1, displayM0);
  
  reg alarm_off_state = 1'b0;
  reg alarm_on_state = 1'b1;
  
  reg [1:0]alarm_h1; 
  reg [3:0]alarm_h0;
  reg [2:0]alarm_m1;
  reg [3:0]alarm_m0;
  reg [2:0]alarm_s1;
  reg [3:0]alarm_s0;
  reg [5:0]temp_hour, temp_min, temp_sec;
  
  reg [1:0]temp_h1;
  reg [3:0]temp_h0;
  reg [2:0]temp_m1;
  reg [3:0]temp_m0;
  reg [2:0]temp_s1;
  reg [3:0]temp_s0;
	
  generate_1s Clock(clk, clk_1s);
  
  always @(posedge clk_1s or posedge reset)
 	begin
 		if(reset) 
          begin
 			alarm_h1 <= 2'b11;
 			alarm_h0 <= 4'b0000;
 			alarm_m1 <= 3'b000;
 			alarm_m0 <= 4'b0000;
 			alarm_s1 <= 3'b000;
 			alarm_s0 <= 4'b0000;
 			temp_hour <= H1*10 + H0;
 			temp_min <= M1*10 + M0;
 			temp_sec <= 0;
          end 
      else 
        begin
          if(load_alarm) 
              begin
 				alarm_h1 <= H1;
                alarm_h0 <= H0;
                alarm_m1 <= M1;
                alarm_m0 <= M0;
                alarm_s1 <= 3'b000;
                alarm_s0 <= 4'b0000;
              end
          case(load_time)
              1'b1:
              	begin
                  temp_hour <= H1*10 + H0;
                  temp_min <= M1*10 + M0;
                  temp_sec <= 0;
                end
              1'b0:
              	begin
                  if(temp_sec == 59)
                    begin
                      temp_sec <= 0;
                      if(temp_min == 59)
                        begin
                          temp_min <= 0;
                          if(temp_hour == 23)
                            begin
                              temp_hour <= 0;
                            end
                          else
                            temp_hour <= temp_hour + 1;
                        end
                      else
                        temp_min <= temp_min + 1;
                    end
                  else
                    temp_sec <= temp_sec + 1;
                end
          endcase
        end
    end
  
  always @ (*)
    begin
    	if(temp_hour >= 20)
      		begin
              temp_h1 = 2'b10;
     		end
      	else
        	begin
        		if(temp_hour >= 10)
          			begin
            			temp_h1 = 2'b01;
          			end
      			else
          			begin
            			temp_h1 = 2'b00;
          			end
        	end
      temp_h0 = temp_hour - temp_h1*10;
      temp_m1 = (temp_min >= 50) ? 5 : ((temp_min >= 40) ? 4 : ((temp_min >= 30)?3:((temp_min >= 20)?2:((temp_min >= 10)?1:0))));
      temp_m0 = temp_min - temp_m1*10;
      temp_s1 = (temp_sec >= 50) ? 5 : ((temp_sec >= 40) ? 4 : ((temp_sec >= 30)?3:((temp_sec >= 20)?2:((temp_sec >= 10)?1:0))));          
      temp_s0 = temp_sec - temp_s1*10;
    end
  
  assign h0out = temp_h0;
  assign h1out = temp_h1;
  assign m1out = temp_m1;
  assign m0out = temp_m0;
  assign s1out = temp_s1;
  assign s0out = temp_s0;
  
  always @(posedge clk_1s or posedge reset)
    begin
    	if(reset)
     		 begin
        		alarm <= alarm_off_state;
      		end
  		else	
    		begin
      			if((alarm_h1 == temp_h1) & (alarm_h0 == temp_h0)&(alarm_m1 == temp_m1)&(alarm_m0 == temp_m0) &(alarm_s1  == temp_s1) & (alarm_s0 == temp_s0))
        			begin
          				alarm <= alarm_on_state;
                   end              
              if(off_alarm)
        			begin
          				alarm <= alarm_off_state;
        			end
    		end
    end

    always @ (*)
    	begin
          case(h1out)
        		2'b00: displayH1 = 7'b1111110;
        		2'b01: displayH1 = 7'b0110000;
        		2'b10: displayH1 = 7'b1101101;
        		default: displayH1 = 7'b0000000;
          endcase
        end
  
    always @ (*)
    	begin
          case(h0out)
        		4'b0000: displayH0 = 7'b1111110;
        		4'b0001: displayH0 = 7'b0110000;
        		4'b0010: displayH0 = 7'b1101101;
        		4'b0011: displayH0 = 7'b1111001;
        		4'b0100: displayH0 = 7'b0110011;
        		4'b0101: displayH0 = 7'b1011011;
        		4'b0110: displayH0 = 7'b1011111;
        		4'b0111: displayH0 = 7'b1110000;
            	4'b1000: displayH0 = 7'b1111111;
            	4'b1001: displayH0 = 7'b1111011;
            	default: displayH0 = 7'b0000000;
          endcase
        end
  
      always @ (*)
    	begin
          case(m1out)
        		3'b000: displayM1 = 7'b1111110;
        		3'b001: displayM1 = 7'b0110000;
        		3'b010: displayM1 = 7'b1101101;
        		3'b011: displayM1 = 7'b1111001;
        		3'b100: displayM1 = 7'b0110011;
        		3'b101: displayM1 = 7'b1011011;
        		default: displayM1 = 7'b0000000;
          endcase
        end
  
        always @ (*)
    	begin
          case(m0out)
        		4'b0000: displayM0 = 7'b1111110;
        		4'b0001: displayM0 = 7'b0110000;
        		4'b0010: displayM0 = 7'b1101101;
        		4'b0011: displayM0 = 7'b1111001;
        		4'b0100: displayM0 = 7'b0110011;
        		4'b0101: displayM0 = 7'b1011011;
        		4'b0110: displayM0 = 7'b1011111;
        		4'b0111: displayM0 = 7'b1110000;
            	4'b1000: displayM0 = 7'b1111111;
            	4'b1001: displayM0 = 7'b1111011;
            	default: displayM0 = 7'b0000000;
          endcase
        end
endmodule

