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

logic [1:0] c = 2'b00;

assign slowClk = c[1];
assign clkOut = c[0];

always_ff@(posedge fastClk) begin
    c <= c + 1'b1;
end

endmodule
