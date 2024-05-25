# Digital-Alarm-Clock
## Overview
This project was created for the Digital Design I course, taught at the American University in Cairo in the Spring 2024 semester, under the instruction of Dr. Mohamed Shalan.  
It is an implementation of a digital alarm clock on the Basys3 FPGA using Verilog HDL, and is an application of our understanding of sequential circuits, finite state machines and other concepts learned in the course, as well as the applied skills gained through its lab.
## Features
* The Alarm has two main modes of operation: Clock and Adjust
* In the clock mode, the Alarm-Clock works as a normal HH:MM clock, with a blinker for the seconds.
* In the adjust mode, the Alarm-Clock allows the user to either adjust the time of the running clock, or set an alarm that goes off when it reaches the same value as the running clock.
* When the alarm goes off, the right-most LED blinks and, if an active buzzer is connected, it goes off at the same frequency as the LED.
* Whenever the alarm goes off, it can either be stopped or snoozed for 30 seconds.

## Installing and Running the Project
You must have a running version of Vivado. This project was created using the 2022 version and backwards compatibility is not guaranteed.
1. Connect the Basys3 FPGA to your device and power it on.
2. Clone this repository.
3. Open vivado and create a new project.
4. Go to **Flow Manager** and under **Project Manager** select **Add sources.**
5. Select **Add or create design sources** then choose **Add files.**
6. Select the folder titled *Source Files* from this repository and add all the files then press finish.
7. Go to back to **Flow Manager** and under **Project Manager** select **Add or create constraints** then choose **Add files.**
8. Select the folder titled *Constraint Files* from this repository and add all the files then press finish.
9. Go to back to **Flow Manager** and under **Project Manager** select **Generate Bitstream.**
10. Once the process is finished, press cancel then go back to **Project Manager** and under **Generate Bitstream** select **Open Hardware Manager**
11. Select **Open Target** then **Auto connect**
12. After a short wait period, go to te blue bar titled **Hardware Manager** at the top and select **Program Device**.
13. The project is now successfully installed on the FPGA.
14. For buzzer funcionality, connect an active piezzo buzzer to the bottom-right set of pins [JC] on the FPGA, with the shorter side [GND] to pin 5 and the longer side to pin 2.  

![Image of pins](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU4IlqUigt0jltnD6JjE16ZewN7i60rF8OfzQBc0YSpQ&s) 

## How to Use the Project
* Once the FPGA is programmed, the Alarm-Clock goes to the adjust mode (The right-most LED [LD0] is on during this mode), specifically the state of setting the hours of the clock.
* Pressing the right buttons allows you to navigate between 4 states, namely, setting the hours of the clock, setting the minutes of the clock, setting the hours of the alarm and setting the minutes of the alarm in order, indicated by LEDs 15, 14, 13 & 12 respectively. The left buttons does the same but in the opposite direction.
* Pressing the up button in any of the 4 states allows you to increment the value of the respective digit, while the down button decrements
* Pressing the center button allows you to switch between the clock mode and the adjust mode.
* Once the alarm goes off, you can press any of the up | down | right | left buttons to stop and the center button to snooze.
* Once snoozed, the Alarm-Clock waits for 30 seconds before another alarm go off. If any buttons are pressed while in this state, the snooze is cancelled.

## Collaborators
* [Haya Shalaby](https://github.com/HayaShalaby)
* [Rana Taher](https://github.com/rana5679)

## License
Copyright 2024 Yasmina Mahdy  
Copyright 2024 Haya Shalaby  
Copyright 2024 Rana Taher  

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

  
 
