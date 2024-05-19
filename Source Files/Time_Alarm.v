`timescale 1ns / 1ps

module Time_Alarm(input sec_clock, funct_clk, rst, adjust, ENTH, ENTM, ENAH, ENAM, ENS, up, down, snooze_rst, snoozeEN,
                  output z_s, output [1:0] H1, output [3:0] H2, output [2:0] M1, output [3:0] M2,output Z, [5:0] secs);

    reg [3:0] num;
    wire clk_t;
    wire [4:0] count;
    wire [1:0] H1, TH1, AH1;
    wire [3:0] H2, TH2, AH2;
    wire [2:0] M1, TM1, AM1;
    wire [3:0] M2, TM2, AM2;
    
    
    // pick clock for time based on mode
    assign clk_t = adjust? funct_clk: sec_clock;

    // Time mode
    Time t(clk_t, rst, adjust, ENTH, ENTM, ENS, up, down, TH1, TH2, TM1, TM2, secs);

    // Alarm mode
    AlarmMode alarm(funct_clk, rst, ENAH, ENAM, up, down, AH1, AH2, AM1, AM2);

    // Snooze counter
    Up_Down_Mod_Counter #(5, 30) snooze_count (sec_clock, snooze_rst, snoozeEN, 1'b0, count);
    
    // pick which set of digits to output based on alarm mode enables
    assign H1 = ENAH | ENAM ? AH1: TH1;
    assign H2 = ENAH | ENAM? AH2: TH2;
    assign M1 = ENAH | ENAM? AM1: TM1;
    assign M2 = ENAH | ENAM? AM2: TM2;
    
    // checks for the z flag 
    assign Z = ((AH1 == TH1) && (AH2 == TH2) && (AM1 == TM1) && (AM2 == TM2))? 1 : 0;
    assign z_s= (count == 29)? 1 : 0 ;

endmodule
