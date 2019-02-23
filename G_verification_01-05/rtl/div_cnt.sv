`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PSU
// Engineer: Stephano Cetola
// 
// Create Date: 01/23/2019
// Module Name: div_cnt
// Project Name: ECE581 Final Project
// Description: 
// A clock divider using a counter.
// 
//////////////////////////////////////////////////////////////////////////////////

module div_cnt (
    input logic fastClk,
    output logic slowClk,
    output logic clkOut
);

logic count[1:0];

assign slowClk = count[1];
assign clkOut = count [0];

// shift_reg
always_ff@(posedge fastClk) begin
    count <= count + 1;
end

assign dataOut = dataIn;

endmodule