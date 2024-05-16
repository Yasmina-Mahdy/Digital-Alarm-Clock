`timescale 1ns / 1ps
module AlarmMode(input clk,rst,ENAH,ENAM,up,down,output [1:0]H1,output [3:0]H2,output [2:0]M1,output [3:0]M2);
reg [3:0] loadH2;
reg [1:0] loadH1;
reg ld;
reg [1:0]en;
wire [5:0] mins;
wire [4:0] hours;

 Up_Down_Mod_Counter #(6,60)AM(.clk(clk),.rst(rst),.en(ENAM & (up | down)),.upDown(down),.count(mins));
 Up_Down_Mod_Counter # (5,24)AH(.clk(clk),.rst(rst),.en(ENAH & (up | down)),.upDown(down),.count(hours));
 
 assign M2=mins % 10;
 assign M1=mins / 10;
 assign H2=hours % 10;
 assign H1=hours / 10;
 
endmodule
