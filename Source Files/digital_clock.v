`timescale 1ns / 1ps

module digital_clock(input clk, rst, adjust, ENTH, ENTM, ENAH, ENAM, ENS, up, down, 
output [6:0] segments, output [3:0] anode_active, output adjust_out, ENTH_out, ENTM_out, ENAH_out, ENAM_out, ENS_out);
//wire [1:0] en; 
reg [3:0] num;
wire clk_out,  clk_out_2, clk_in;
wire[1:0] count;
wire [1:0] H1, TH1, AH1;
wire [3:0] H2, TH2, AH2;
wire [2:0] M1, TM1, AM1;
wire [3:0] M2, TM2, AM2;

//
assign adjust = adjust_out;
assign ENTH_out = ENTH;
assign ENTM_out = ENTM;
assign ENAH_out = ENAH;
assign ENAM_out = ENAM;
assign ENS_out = ENS;

ClockDivider #(50000)clkdiv (.clk(clk), .rst(rst), .en(1'b1),.clk_out(clk_out));
ClockDivider #(250000) clock (.clk(clk), .rst(rst), .en(1'b1),.clk_out(clk_out_2));

SevenSegDecWithEn seg(.en(count), .num(num), .segments(segments), .anode_active(anode_active)); 
Binary_Counter #(2,4)BC(.clk(clk_out_2), .rst(rst), .en(1'b1), .count(count));
// multiplex clk
assign clk_in = adjust? clk_out_2: clk_out;
Time t(clk_in, rst, adjust, ENTH, ENTM, ENS, up, down, TH1, TH2, TM1, TM2);

AlarmMode alarm(clk_out_2, rst, ENAH, ENAM, down, AH1, AH2, AM1, AM2);

assign H1 = ENAH | ENAM ? AH1: TH1;
assign H2 = ENAH | ENAM? AH2: TH2;
assign M1 = ENAH | ENAM? AM1: TM1;
assign M2 = ENAH | ENAM? AM2: TM2;

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
