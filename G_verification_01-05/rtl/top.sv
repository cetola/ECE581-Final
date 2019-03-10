`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PSU
// Engineer: Stephano Cetola
// 
// Create Date: 01/23/2019
// Module Name: top
// Project Name: ECE581 Final Project
// Description: 
// 
//////////////////////////////////////////////////////////////////////////////////

module top #(
	parameter DATA_WIDTH = 4
) (
    input logic dataIn,
    input logic fastClk,
    input logic reset,
    input logic control,
    output logic [DATA_WIDTH-1:0] dataOut
);

logic [DATA_WIDTH-1:0] shiftOut, syncOut, decodeOut, multiplyOut;
logic slowClk, clkOut, enable;

assign enable = clkOut & slowClk;
assign dataOut = multiplyOut;

shift_reg #(DATA_WIDTH) sr1 (   .dataIn(dataIn),
                                .fastClk(fastClk),
                                .reset(reset),
                                .dataOut(shiftOut));

div_cnt c1 (.fastClk(fastClk),
            .reset(reset),
            .slowClk(slowClk),
            .clkOut(clkOut));

//Synchronize reg, contains combinational logic
sync_reg #(DATA_WIDTH) synch1 ( .dataIn(shiftOut),
                                .fastClk(fastClk),
                                .enable(enable),
                                .reset(reset),
                                .dataOut(syncOut));

//"Decode" reg, contains combinational logic
decode_reg #(DATA_WIDTH) d1 (   .dataIn(syncOut),
                                .slowClk(slowClk),
                                .reset(reset),
                                .dataOut(decodeOut));

//"Multiply" register. Contains no logic.
multiply_reg #(DATA_WIDTH) m1 ( .dataIn(decodeOut),
                                .slowClk(slowClk),
                                .reset(reset),
                                .dataOut(multiplyOut));

endmodule
