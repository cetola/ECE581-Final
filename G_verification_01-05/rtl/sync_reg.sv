`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PSU
// Engineer: Stephano Cetola
// 
// Create Date: 01/23/2019
// Module Name: sync_reg
// Project Name: ECE581 Final Project
// Description: 
// A synchronization register. Contains delay logic.
// 
//////////////////////////////////////////////////////////////////////////////////

module sync_reg #(
	parameter DATA_WIDTH = 4
) (
    input logic fastClk,
    input logic enable,
    input logic reset,
    input logic [DATA_WIDTH-1:0] dataIn,
    output logic [DATA_WIDTH-1:0] dataOut
);

logic [DATA_WIDTH-1:0] data;

always_ff@(posedge fastClk) begin
    if(reset) begin
        dataOut <= '0;
    end
    else if(enable) begin
        dataOut <= data;
    end
end

// combination logic
// Invert all the bits of "dataIn"
always_comb begin
    data = ~dataIn;
end

endmodule
