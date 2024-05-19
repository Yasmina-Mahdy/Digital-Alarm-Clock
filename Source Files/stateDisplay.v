`timescale 1ns / 1ps

module Top (input U, D, R, L, C, clk, rst, output [6:0] segments, output [3:0] anode_active, output ENTH, ENTM, ENAH, ENAM, output buzzy, LED, blink_DP);
    wire up, down, right, left, center, adjust, DP;
    wire sec_clock, funct_clk, blink, adjust_out;
    wire up_out, down_out, right_out, left_out, center_out;
    wire [1:0] H1;
    wire [3:0] H2; 
    wire [2:0] M1;
    wire [3:0] M2;
    wire [4:0] EN;
    wire [5:0] secs;
    
    // Clocks to enable the modules
    ClockDivider #(50000000) clk_1 (.clk(clk), .rst(rst), .en(1'b1),.clk_out(sec_clock));
    ClockDivider #(250000) clk_2 (.clk(clk), .rst(rst), .en(1'b1),.clk_out(funct_clk));
    ClockDivider #(15000000) clk_3 (.clk(clk), .rst(rst), .en(1'b1),.clk_out(blink));
    
    // module that handles the push buttons
    Buttons fiveButtons(U, D, R, L, C, funct_clk, rst, up, down, right, left, center);
    
    // Finite state machine that provides mode enables and alarm signal
    stateLogic fsm(funct_clk, rst, up, down, right, left, center, Z, secs, adjust, EN, alarm_on);
       
    // mode enables from FSM
    assign ENTH = EN[4];
    assign ENTM = EN[3];
    assign ENAH = EN[2];
    assign ENAM = EN[1];
    
    // a module that combines the Time and Alarm modes, picks which set of values to send to display and computes the Z flag
    Time_Alarm TA (sec_clock, funct_clk, rst, adjust, EN[4], EN[3], EN[2], EN[1], EN[0], up, down, H1, H2, M1, M2, Z, secs);
    
    // a module that handles the 7 segment display
    Display D (funct_clk, rst, H1, H2, M1, M2, segments, anode_active, DP);
    
    // [active low] blinking decimal point: decimal point en if not in adjust and blinks in sequence with seconds clock
    assign blink_DP = ~(DP & sec_clock & ~adjust);
    
    // LD0 
    assign LED = adjust? 1: alarm_on & blink;
    
    // buzzer
    assign buzzy = alarm_on & blink;
   
    
endmodule
