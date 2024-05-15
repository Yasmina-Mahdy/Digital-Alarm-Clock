`timescale 1ns / 1ps

module sync(input sig, clock, output reg sig1);

reg meta;

always @ (posedge clock) begin

meta <= sig;
sig1 <= meta;

end
endmodule

