`timescale 1ns / 1ps

module Time_TB();

reg clk, rst, adjust, ENTH, ENTM, updown;
wire [1:0] H1;
wire [3:0] H2;
wire [2:0] M1;
wire [3:0] M2;

Time smh (clk, rst, adjust, ENTH, ENTM, updown, H1, H2, M1, M2);

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin 
rst = 1; # 10
rst = 0; 

// Expected behavior: normal clock
adjust = 0; ENTH = 1; ENTM = 0; updown = 0; //#400

// Expected behavior: up count hours
adjust = 1; ENTH = 1; ENTM = 0; updown = 0; //#400

// Expected behavior: normal clock
 adjust = 0; ENTH = 1; ENTM = 0; updown = 1; //#400

// Expected behavior: up count minutes
 adjust = 1; ENTH = 0; ENTM = 1; updown = 0; //#400

// Expected behavior: nothing
 adjust = 1; ENTH = 0; ENTM = 0; updown = 0; //#400

// Expected behavior: down count minutes
 adjust = 1; ENTH = 0; ENTM = 1; updown = 1; //#400

// Expected behavior: down count hours
 adjust = 1; ENTH = 1; ENTM = 0; updown = 1;


end

endmodule