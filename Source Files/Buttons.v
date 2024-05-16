`timescale 1ns / 1ps

module Buttons(input U, D, R, L, C, clk, rst, output up, down, right, left, center);

// Note that as of now, the push_detector module has a clock divider inside
push_detector push_A(.in(U), .clk(clk), .reset(rst), .out(up));
push_detector push_B(.in(D), .clk(clk), .reset(rst), .out(down));
push_detector push_C(.in(R), .clk(clk), .reset(rst), .out(right));
push_detector push_D(.in(L), .clk(clk), .reset(rst), .out(left));
push_detector push_E(.in(C), .clk(clk), .reset(rst), .out(center));

endmodule
