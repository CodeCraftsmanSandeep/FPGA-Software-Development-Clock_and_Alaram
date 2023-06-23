# Designing 24-Hr clock and alarm.

## Problem statement:


## hi namaste:
Here, a verilog code is written for 24 hour clock along with alarm, this code is simulated using a test bench in VIVADO software and also implemented on ZYBO 7010 .

![1](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/25a07a1d-05d1-4db1-87c1-b29f5e75a686)

## Clock Generation:

Clock format = H1H0:M1M0 <br/>

Clock description:
	1) 24 hour format
	2) Depicts hours and minutes. (seconds can also be implemented using same logic with few changes in code and using more 7 segment displays).
 
![6) table](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/03a9c500-2703-4bef-867b-dcddc5513314)

### State diagram of counters:

3 counters are used separately for hour, minute and second. <br/>
Hour count = 10 * H1 + H0 <br/>
Minute count = 10 * M1 + M0 <br/>
Second count = 10 * S1 + S0 <br/>

![2) counters ](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/71f58a5b-ecd1-46a0-9145-574d3913d49e)

### Flow chart of clock:
Initially hour count and minute count will be based on input given and second count will be zero.

![3) flow chart](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/fe05ff47-ec77-4abe-ba76-4b5997b79431)

## Alarm:
Alarm which is designed works as follows: <br/>
Whenever we press load_alarm switch, alarm gets loaded with inputs given
1) After reaching into the time given, alarm will ON.
2) Then when we give alarm OFF it will OFF.

### State diagram of alarm:
Here, Alarm designed has two states: <br/>
1) Alarm_on state
2) Alarm_off state

![5) alarm state diagram](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/2975f78d-5c97-46b6-9754-4a845eedf59a)

## Timing diagram:


## Display of H1, H0, M1, M0 using 7 segment display:
![4) 7 segment display](https://github.com/112101011/Designing-24Hr-clock./assets/111628378/0d7aae1d-60c3-4d63-9a28-486f59129ec1)

## Further scope:
