`timescale 1ns / 1ps

module rising_edge(input in, reset, clk, output out);

reg [1:0] state,nextstate;
parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10;
always@* begin
case(state)
    A: if(in==0) nextstate = A;
        else
            nextstate = B;
    B: if(in==0) nextstate = A;
        else
            nextstate = C;
    C: if(in==0) nextstate = A;
        else
            nextstate = C;
endcase
end
always@(posedge clk , posedge reset)begin
    if(reset==1)
        state <=A;
    else
        state <=nextstate;

end
assign out = (state == B);


endmodule
