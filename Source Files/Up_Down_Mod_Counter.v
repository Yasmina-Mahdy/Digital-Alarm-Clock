`timescale 1ns / 1ps

module Up_Down_Mod_Counter # (parameter x = 3, n = 6)(input clk, rst, en, upDown, [x-1:0] in, output [x-1:0] count);
reg [x-1:0] count;
always @ (posedge clk, posedge rst)
begin 
    if (rst == 1)
        count <= 0;
    else if (en == 1)begin
        if (upDown == 0)
             if (count == n-1) 
                 count <=0;
             else 
                 count <=count+1;
        else begin
             if (count == 0)
                count <= n-1;
             else 
                count <=count-1;
                end
     end
     else
        count <= count;
end 
endmodule
