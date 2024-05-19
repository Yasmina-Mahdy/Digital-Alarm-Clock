`timescale 1ns / 1ps

module Display (input clk, rst, input [1:0] H1,input [3:0] H2, input [2:0] M1, input [3:0] M2,
output [6:0] segments, output [3:0] anode_active, DP);

    reg [3:0] num;
    wire[1:0] count;
    wire [1:0] H1;
    wire [3:0] H2;
    wire [2:0] M1;
    wire [3:0] M2;
    wire DP;
    
    // Takes a BCD and produces the equivalent seven segment and pick which digit to display
    SevenSegDecWithEn seg(.en(count), .num(num), .segments(segments), .anode_active(anode_active), .DP(DP)); 
    
    // counter that selects what to display
    Binary_Counter #(2,4)BC(.clk(clk), .rst(rst), .en(1'b1), .count(count));
    
    // picks which value to display
    always @*begin
    
    if(count==0)
    num = M2;
    else if (count == 1)
    num = M1;
    else if (count == 2)
    num = H2;
    else if(count == 3)
    num = H1;
    end
endmodule
