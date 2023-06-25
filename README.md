# Designing 24-Hr clock and alarm.

## Problem statement:
Objective:   The aim of this project is to generate a 24 hour clock(depicting hours and minutes) and setting an alarm. <br/>
	      Features of mini project to construct design: <br/>
	      1) Setting clock to desired time whenever needed. <br/>
	      2) Clicking second, minute and hours digits after completion of respective cycles. <br/>
	      3) Setting an alarm, alarm rings whenever time is reached. <br/>
	      4) OFF alarm whenever we want to off alarm. <br/>

## Instroduction:
Here, a verilog code is written for 24 hour clock along with alarm, this code is simulated using a test bench in VIVADO software and also implemented on ZYBO 7010 .

![1](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/25a07a1d-05d1-4db1-87c1-b29f5e75a686)

## Clock Generation:

Clock format = H1H0:M1M0 <br/>

Clock description:
	1) 24 hour format
	2) Depicts hours and minutes. (seconds can also be implemented using same logic with few changes in code and using more 7 segment displays).
 
![6) table](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/03a9c500-2703-4bef-867b-dcddc5513314)


### Desription of approach:
3 up counters are used to generate clock. <br/>

Hour count = 10 * H1 + H0 <br/>
Minute count = 10 * M1 + M0 <br/>
Second count = 10 * S1 + S0 <br/>

1st up counter is for clicking seconds from 00 to 59, 2nd up counter form 00 to 59, 3rd up  counter from 00 to 23.
Whenever one complete cycle is completed in one counter, 1 will be incremented in subsequent counter as depicted in below state diagram.

![2) counters ](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/71f58a5b-ecd1-46a0-9145-574d3913d49e)
Minute and seconds counter has 60 states, and hours counter has 24 states.

### Flow chart of clock:
Initially hour count and minute count will be based on input given and second count will be zero.

![3) flow chart](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/fe05ff47-ec77-4abe-ba76-4b5997b79431)

## Alarm:
Alarm which is designed works as follows: <br/>
Whenever we press load_alarm switch, alarm gets loaded with inputs given
1) After reaching into the time given, alarm will ON.
2) Then when we give alarm OFF it will OFF.

Alarm will on whenever the alarm set time is equal to present time, provided alarm off button is off.
Alarm will not on if alarm off button is on even though set alarm time equals present time.
Alarm will have two states they are alarm off and alarm on state with condition checker of present time and alarm set time checker

1) Alarm_on state
2) Alarm_off state

![5) alarm state diagram](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/2975f78d-5c97-46b6-9754-4a845eedf59a)


## Test bench:



### Description of test bench:

### Timing diagram:
Initially we load the time so load_time is high, and time 23:59 is loaded:
![9) -2)](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/a3f5d4ad-2d2d-4dcc-8750-7c94b7fc3962)

After 1 minute from 23:59, the clock goes to the state 00:00:00. This can be inferred from the following diagram. Whenever we reach 23:59:59 the clock clicks to 00:00:00, hence test case is evaluated:

![9) -1)](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/2235e106-dc79-41e6-a7d9-d4ae5578bf8e)


Input is changed to 5:30 and whenever load_alarm is high the alarm will be set:
![9) 1)](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/d50dfea7-2dbe-40de-9cbd-98d374eca740)

Whenever the loaded alarm time is reached the alarm will on, and it will off whenever we off the alarm:
![9) 2)](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/d8f2fd28-8a05-4c91-b0a8-19c7d05c2d2c)

## Zybo implementation:

### Materials required for Zybo-Implementation:
	     1) Zybo Board. <br/>
	     2) 4 seven segment displays(2 for hours, 2 for minutes) <br/>
	     3) Connecting wires, <br/>
	     4) 4 ULN 2003. <br/>
	     5) Breadboards. <br/>


### Display of H1, H0, M1, M0 using 7 segment display:

Connections in seven segment display: <br/>
![7-segment-display-pinout](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/70a2fcb3-5727-45e1-b2b2-35e15217a6f8)

convention followed for representing digits in 7-segment display:
![4) 7 segment display](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/0d7aae1d-60c3-4d63-9a28-486f59129ec1)

### Zybo board:
Here in the following pictures minute seven segment diaply(M0) is shown: <br/>

Initially M0 = 0: <br/>
![min 0](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/f706a169-48bd-4b52-9148-61bdbad4d038)

M0 = 1: (after one minute) <br/>
![min 1](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/8018e1bc-6a14-4422-b599-09da2b6ae85a)

M0 = 2: (after two minutes after starting) <br/>
![min 2](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/212053eb-f0d4-4e31-ae00-9e4a9054bf1f)

M0 = 3: (after three minutes after starting) <br/>
![min 3](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/c78b5603-5e7d-47d4-bed5-78437600366c)

## Further scope:

### Reference:
1) Padmanabhan, T. R._ Bala Tripura Sundari, B. - Design Through Verilog HDL (Padmanabhan_Design Through Verilog HDL) __ (2003, John Wiley & Sons, Inc.) 
2) Digital Design With an Introduction to the Verilog HDL, VHDL, and SystemVerilog(chapter 6).
3) Digital Electronics Principles, Devices and Applications. By Wiley.
4) Online reference: [Link](https://en.wikipedia.org/wiki/Clock_generator), and other online references.
