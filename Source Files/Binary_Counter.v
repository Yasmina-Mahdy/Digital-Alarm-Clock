`timescale 1ns / 1ps

module Binary_Counter # (parameter x =3, n=6)(input clk, rst, en, output [x-1:0] count);
reg [x-1:0] count;
always @ (posedge clk, posedge rst)
begin 
    if(rst == 1)
        count <= 0;
    else if (en == 1)
     if (count== n-1) 
         count <=0;
     else 
         count <=count+1;
    
end 
endmodule
