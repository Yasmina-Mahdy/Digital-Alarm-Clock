`timescale 1ns / 1ps

module Up_Down_Mod_TB();
reg clk, rst, en, upDown;
wire [2:0] count;
Up_Down_Mod_Counter counter(.clk(clk),.rst(rst),.en(en),.upDown(upDown),.count(count));
initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin
    rst = 1;
    upDown = 0;
    en = 1;
    #100
    rst = 0;
    #100
    en = 0;
    #100
    en = 1;
    upDown = 1;
    
end
endmodule
