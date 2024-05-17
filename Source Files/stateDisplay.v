`timescale 1ns / 1ps

module stateDisplay(input U, D, R, L, C, clk, rst, output segments, anode_active, adjust_out, ENTH_out, ENTM_out, ENAH_out, ENAM_out, ENS_out);
    wire up, down, right, left, center, adjust, clk_out_2;
    wire [4:0] EN; 
    
    ClockDivider #(250000) clock (.clk(clk), .rst(rst), .en(1'b1),.clk_out(clk_out_2));
    Buttons fiveButtons(U, D, R, L, C, clk_out_2, rst, up, down, right, left, center);
    FSM fsm(clk, rst, left, right, center, adjust, EN);
    
    assign ENTH = EN[0];
    assign ENTM = EN[1];
    assign ENAH = EN[2];
    assign ENAM = EN[3];
    assign ENS = EN[4];
    
    digital_clock(clk, rst, adjust, ENTH, ENTM, ENAH, ENAM, ENS, up, down, segments, anode_active, adjust_out, ENTH_out, ENTM_out, ENAH_out, ENAM_out, ENS_out);
endmodule

