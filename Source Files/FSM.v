`timescale 1ns / 1ps

module FSM(input clk, rst, left, right, center, output  adjust, output reg [3:0] EN);
    //States Encoding 
    parameter [2:0] TH = 3'b00, TM = 3'b001, AH = 3'b010, AM = 3'b011, Clock = 3'b100;
    reg [2:0] state, nextState;
    
    always @ * begin
        case(state) 
            TH: begin
                EN = 4'b1000;
                if(right) nextState = TM;
                else if(left) nextState = AM;
                else if(center) nextState = Clock;
                else nextState = TH;
                end
             TM: begin
                EN = 4'b0100;
                if(right) nextState = AH;
                else if(left) nextState = TH;
                else if(center) nextState = Clock;
                else nextState = TM;
                end
            AH: begin
                EN = 4'b0010;
                if(right) nextState = AM;
                else if(left) nextState = TM;
                else if(center) nextState = Clock;
                else nextState = AH;
                end
            AM: begin
                EN = 4'b0001;
                if(right) nextState = TH;
                else if(left) nextState = AH;
                else if(center) nextState = Clock;
                else nextState = AM;
                end
            Clock: begin
                    EN = 0;
                   if(center) nextState = TH;
                   else nextState = Clock;
                   end
            default: nextState = TH;
        endcase
    end
    
    always @ (posedge clk or posedge rst) begin
        if(rst) 
            state <= TH; 
        else 
            state <= nextState;
    end
    
    assign adjust = (state == Clock)? 0 : 1;
    
endmodule
