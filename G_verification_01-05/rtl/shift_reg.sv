`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PSU
// Engineer: Stephano Cetola
// 
// Create Date: 01/23/2019
// Module Name: shift_reg
// Project Name: ECE581 Final Project
// Description: 
// Simple variable width shift register with synchronous reset.
// Default width is 4, shifts in from the LSB.
// 
//////////////////////////////////////////////////////////////////////////////////

module shift_reg #(
	parameter DATA_WIDTH = 4
) (
    input logic dataIn,
    input logic fastClk,
    input logic reset,
    output logic [DATA_WIDTH-1:0] dataOut
);

logic shiftReg[DATA_WIDTH-1:0];
logic slowClk;
logic syncClk;

assign dataOut = shiftReg;

// shift_reg
always_ff@(posedge fastClk) begin
    if(reset) begin
        shiftReg <= '0;
    end
    else begin
        shiftReg <= {shiftReg[DATA_WIDTH-2:0], dataIn};
    end
end

assign dataOut = dataIn;

endmodule