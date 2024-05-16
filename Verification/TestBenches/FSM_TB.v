`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 07:52:14 PM
// Design Name: 
// Module Name: FSM_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FSM_TB();
    reg clk, rst, left, right, center;
    wire adjust; 
    wire [4:0] EN; 
    
    FSM DUT(clk, rst, left, right, center, adjust, EN);
    
    initial begin 
        rst = 1; left = 0; right = 0; center = 0;
        # 50 
        rst = 0; left = 0; right = 1; center = 0;
        # 50 
        rst = 0; left = 0; right = 1; center = 0;
        # 50 
        rst = 0; left = 1; right = 0; center = 0;
        # 50 
        rst = 0; left = 0; right = 0; center = 1;
        # 50 
        rst = 0; left = 0; right = 0; center = 0;
    end
    
endmodule
