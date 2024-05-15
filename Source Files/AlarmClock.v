`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 06:19:44 PM
// Design Name: 
// Module Name: AlarmClock
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


module AlarmClock(input clk,rst,U, D, R, L, C, output [6:0]seg, [3:0] anode);
wire up, down, right, left, center,ENTH, ENTM,ENAH, ENAM;
wire [1:0] TH1;
wire [3:0] TH2;
wire [2:0] TM1;
wire [3:0] TM2;
wire clock_out,clock;
wire [1:0]enable_anode;
reg [2:0] state, nextstate;
parameter [2:0] C=3'b000 , TH=3'b001, TM=3'b010, AH=3'b011, AM=3'b100;
reg en;
ClockDivider #(5000000) cl( .clk(clk), .rst(rst), .en(1'b1), .clk_out(clk_out));
ClockDivider #(250000) cl( .clk(clk), .rst(rst), .en(1'b1), .clk_out(clock));
Buttons pb( U, D, R, L, C, clk_out, rst,up, down, right, left, center);
Time (clock, rst, 1'b0, ENTH, ENTM, updown,TH1,TH2,TM1, TM2);

always @(state)begin
case (state)
C : if(center==0)
nextstate <= C;

default : nextstate <= C;
endcase
end

Binary_Counter #(2,4) count(clock, rst, 1'b1,enable_anode);

 always @ (enable_anode) begin
     case(enable_anode)
        0: mux_out = TM2;
        1: mux_out = TM1;
        2: mux_out = TH2;
        3: mux_out = TH1;
     endcase
     end

BCDto7SEG(1'b1,enable_anode,num,seg,anode);

endmodule
