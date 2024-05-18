`timescale 1ns / 1ps

module push_detector(input in,clk,reset, output out);

wire  w1, w2;


debouncer deb(.clk(clk),.rst(reset),.in(in), .out(w1));
sync syncro(.sig(w1),.clock(clk),.sig1(w2));
rising_edge rise(.in(w2), .reset(reset), .clk(clk), .out(out));

endmodule
