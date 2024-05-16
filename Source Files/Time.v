`timescale 1ns / 1ps

module Time (input clk, rst, adjust, ENTH, ENTM, ENS, up, down, output [1:0] H1, [3:0] H2, [2:0] M1, [3:0] M2);

// different clks need to be input depending on the current state
// updown set before depending on mode

wire enm, enh, updown;
wire  [5:0] secs, s;
wire  [5:0] mins;
wire  [4:0] hours;

assign updown = adjust? down: 0;

Up_Down_Mod_Counter #(6,60) sec (.clk(clk), .rst(rst), .en(ENS),.upDown(0), .count(s));
Up_Down_Mod_Counter #(6,60) min (.clk(clk), .rst(rst), .en(enm),.upDown(updown), .count(mins));
Up_Down_Mod_Counter #(5,24) hour (.clk(clk), .rst(rst), .en(enh), .upDown(updown),.count(hours));

assign enm = adjust ?  ENTM & (up | down) : secs == 59;
assign enh = adjust ?  ENTH & (up | down) : mins == 59 & secs == 59;

assign H1 = hours / 10;
assign H2 = hours % 10;
assign M1 = mins / 10;
assign M2 = mins % 10;
assign S1 = secs / 10;
assign S2 = secs % 10;

assign secs = adjust? 0 : s;

endmodule
