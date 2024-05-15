`timescale 1ns / 1ps

module push_detector(input in,clk,reset, output out);

wire clk_out, w1, w2;
ClockDivider #(500000) cl( .clk(clk), .rst(reset), .en(1'b1), .clk_out(clk_out));

debouncer deb(.clk(clk_out),.rst(reset),.in(in), .out(w1));
sync syncro(.sig(w1),.clock(clk_out),.sig1(w2));
rising_edge rise(.in(w2), .reset(reset), .clk(clk_out), .out(out));

endmodule
