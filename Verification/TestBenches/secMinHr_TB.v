`timescale 1ns / 1ps

module secMinHr_TB();

reg clk, rst;
wire [3:0] H2, M2, S2;
wire [2:0] M1, S1;
wire [1:0] H1;

Time_Mode smh (.clk(clk), .rst(rst), .H1(H1), .H2(H2), .M1(M1), .M2(M2), .S1(S1), .S2(S2) );

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin 
rst = 1; # 10;
rst = 0;
end

endmodule
