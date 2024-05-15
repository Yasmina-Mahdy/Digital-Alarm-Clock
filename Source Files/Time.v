`timescale 1ns / 1ps

module Time (input clk, rst, adjust, ENTH, ENTM, updown, output [1:0] H1, [3:0] H2, [2:0] M1, [3:0] M2, [2:0] S1, [3:0] S2);

// different clks need to be input depending on the current state
// updown set before depending on mode

wire enm, enh;
wire  [5:0] secs;
wire  [5:0] mins;
wire  [4:0] hours;

Up_Down_Mod_Counter #(6,60) s (.clk(clk), .rst(rst), .en(~adjust),.upDown(0), .count(secs));
Up_Down_Mod_Counter #(6,60) m (.clk(clk), .rst(rst), .en(enm),.upDown(updown), .count(mins));
Up_Down_Mod_Counter #(5,24) h (.clk(clk), .rst(rst), .en(enh), .upDown(updown),.count(hours));

assign enm = adjust ?  ENTM : secs == 59;
assign enh = adjust ?  ENTH : mins == 59 & secs == 59;

assign H1 = hours / 10;
assign H2 = hours % 10;
assign M1 = mins / 10;
assign M2 = mins % 10;

  // test correctness
always @* begin
  if (adjust == 1)
    secs = 0;
end

endmodule
