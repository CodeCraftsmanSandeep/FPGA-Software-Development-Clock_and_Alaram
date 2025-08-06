`timescale 1ns / 1ps

/*
testing cases
time - 23:59
testing load alarm
testing off_alarm
*/

module test_bench;
  reg load_time, load_alarm, off_alarm, clk, reset;
  reg [1:0]H1;
  reg [3:0]H0; 
  reg [2:0]M1;
  reg [3:0]M0;
  wire clk_1s, alarm;
  wire [1:0]h1out;
  wire [3:0]h0out;
  wire [2:0]m1out;
  wire [3:0]m0out;
  wire [2:0]s1out; 
  wire [3:0]s0out;
  wire [6:0]displayH1, displayH0, displayM1, displayM0;
  
  clock uut(load_time, load_alarm, off_alarm, clk, reset, H1, H0, M1, M0, clk_1s, h1out, h0out, m1out, m0out, s1out, s0out, alarm, displayH1, displayH0, displayM1, displayM0);
  
  initial
    begin
      reset = 1'b1;
      clk = 1'b0;
      load_alarm = 1'b0;
      off_alarm = 1'b0;
      load_time = 1'b1;
      H1 = 2'b10;   // 2
      H0 = 4'b0011; // 3
      M1 = 3'b101; // 5
      M0 = 4'b1001; // 9
      #2 reset = ~reset;
      #4 load_time = load_time + 1'b1;
      H1 = 2'b00;   // 0
      H0 = 4'b0101; // 5
      M1 = 3'b011; // 3
      M0 = 4'b0000; // 0
      #900 load_alarm = ~load_alarm;
      #2 load_alarm = ~load_alarm;
      #158060 off_alarm = ~off_alarm;
      #10 off_alarm = ~off_alarm;
    end
  
  always #1 clk = clk + 1'b1;
  
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
    end
 
endmodule
