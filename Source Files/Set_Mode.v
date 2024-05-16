module Set_Mode(input clk, rst, adjust, ENTH, ENTM, updown, output [1:0] H1, [3:0]H2, [2:0]M1, [3:0]M2);

//are seconds needed here? taking into consideration they are set to zero in Time_Mode 
//need these values from Time_Mode i.e. the last values before switching to adjust mode 
reg [4:0] H;
reg [5:0] M;

always @ * begin
	if(adjust) begin 
		if(ENTH) begin
			if(updown) 
				H <= H == 2d'00? 2d'23 : H - 1; 
			else
				H <= H == 2d'23? 2d'00 : H + 1; 

			end 
                else if(ENTM) begin 
			if(updown) 
				M <= M == 2d'00? 2d'59 : M - 1;  
			else
				M <= M == 2d'59? 2d'00 : M + 1; 
			end 
	end	 
end

assign {H1, H2} = H; 
assign {M1, M2} = M;

endmodule 