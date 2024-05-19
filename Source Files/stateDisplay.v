`timescale 1ns / 1ps

module stateDisplay(input U, D, R, L, C, clk, rst, output [6:0] segments, output [3:0] anode_active, output ENTH, ENTM, ENAH, ENAM, output buzzy, LD0, blink);
    wire up, down, right, left, center, adjust, DP;
    wire sec_clock, funct_clk, blink_clk, adjust_out;
    wire up_out, down_out, right_out, left_out, center_out;
    wire [1:0] H1;
    wire [3:0] H2; 
    wire [2:0] M1;
    wire [3:0] M2;
    wire [4:0] EN;
    
    // adjust clock later
    ClockDivider #(50000000) clk_1 (.clk(clk), .rst(rst), .en(1'b1),.clk_out(sec_clock));
    ClockDivider #(250000) clk_2 (.clk(clk), .rst(rst), .en(1'b1),.clk_out(funct_clk));
    ClockDivider #(25000000) clk_3 (.clk(clk), .rst(rst), .en(1'b1),.clk_out(blink_clk));
    
    Buttons fiveButtons(U, D, R, L, C, funct_clk, rst, up, down, right, left, center);
    FSM fsm(funct_clk, rst,up, down, right, left, center, Z, adjust, EN, led);
    
    assign adjust_out = adjust;
    assign up_out = up;
    assign down_out = down;
    assign right_out = right;
    assign left_out = left;
    assign center_out = center;
    
    assign ENTH = EN[4];
    assign ENTM = EN[3];
    assign ENAH = EN[2];
    assign ENAM = EN[1];
    
    Time_Alarm TA (sec_clock, funct_clk, rst, adjust, EN[4], EN[3], EN[2], EN[1], EN[0], up, down, H1, H2, M1, M2, Z);
    digital_clock display (funct_clk, rst, H1, H2, M1, M2, segments, anode_active, DP);
    assign blink = ~(DP & sec_clock & ~adjust);
    
    assign LD0 = adjust? 1: led & blink_clk;
    
    assign buzzy = led & blink_clk;
   
    
endmodule
