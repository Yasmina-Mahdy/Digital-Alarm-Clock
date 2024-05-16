`timescale 1ns / 1ps

module FSM_TB();
    reg clk, rst, left, right, center;
    wire adjust; 
    wire [3:0] EN;
    
    FSM DUT(clk, rst, left, right, center, adjust, EN);
    
    initial begin 
        clk = 1;
        forever #5 clk = ~clk;
    end
    
    initial begin 
          rst = 1; left = 0; right = 0; center = 0;
          #50 
          rst = 0; left = 0; right = 1; center = 0;
          #50 
          rst = 0; left = 0; right = 1; center = 0;
          #50 
          rst =0 ; left = 1; right = 0; center = 0; 
          #50 
          rst =0 ; left = 0; right = 0; center = 1;
          #55
          rst =0 ; left = 0; right = 0; center = 0;
//          #10
//          rst =0 ; left = 0; right = 0; center = 0;
    end

endmodule
