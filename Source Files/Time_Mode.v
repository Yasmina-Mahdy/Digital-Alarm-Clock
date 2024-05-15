`timescale 1ns / 1ps

module Time_Mode(input clk, rst, output [1:0] H1, [3:0] H2, [2:0] M1, [3:0] M2, [2:0] S1, [3:0] S2 );

reg ldh1, ldh2;
reg [4:0] en;
reg [1:0] inh1;
reg [3:0] inh2;

// up down signal temporarily set to 0 (up). Signal to be adjusted later
// en to TS2 is actually [not adjust] which is a T flip flop enabled by center button
Binary_Counter #(4,10) TS2 (.clk(clk), .rst(rst), .en(1'b1), .count(S2));
Binary_Counter #(3,6) TS1 (.clk(clk), .rst(rst), .en(en[0]), .count(S1));
Up_Down_Mod_Counter #(4,10) TM2 (.clk(clk), .rst(rst), .en(en[1]),.upDown(0),.ld(0), .in(0), .count(M2));
Up_Down_Mod_Counter #(3,6) TM1 (.clk(clk), .rst(rst), .en(en[2]),.upDown(0),.ld(0), .in(0), .count(M1));
Up_Down_Mod_Counter #(4,10) TH2 (.clk(clk), .rst(rst), .en(en[3]), .upDown(0),.ld(ldh2), .in(inh2), .count(H2));
Up_Down_Mod_Counter #(2,3) TH1 (.clk(clk), .rst(rst), .en(en[4]),.upDown(0),.ld(ldh1), .in(inh1), .count(H1));

// Time enables
always @(H1 or H2 or M1 or M2 or S1 or S2) begin
     // Clock enables
        if (S2 == 9) 
        begin 
            en[0] <= 1'b1;
            if (S1 == 5) 
            begin 
                en[1] <=1'b1;
                if (M2 == 9) 
                begin
                en[2] <=1'b1;
                    if(M1 == 5)
                    begin
                    en[3] <=1'b1;
                        if(H2 == 9 || H1 == 2 && H2 == 3)
                        begin
                        en[4] <=1'b1;
                            if(H1 == 2 && H2 == 3) 
                            begin
                            ldh1 <= 1; ldh2 <= 1;
                            inh1 <= 0; inh2 <= 0;
                            end 
                        end 
                        else en[4] <=1'b0; 
                    end
                    else en[3] <=1'b0;
                end
                else en[2] <= 1'b0;
            end
            else en[1] <= 1'b0;
        end 
        else en <= 0;
    
end 
endmodule