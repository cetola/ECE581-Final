`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PSU
// Engineer: Stephano Cetola
// 
// Create Date: 01/23/2019
// Module Name: decode_reg
// Project Name: ECE581 Final Project
// Description: 
// A "decode" register. Contains delay logic.
// 
//////////////////////////////////////////////////////////////////////////////////

module decode_reg #(
	parameter DATA_WIDTH = 4
) (
    input logic dataIn,
    input logic slowClk,
    input logic reset,
    output logic [DATA_WIDTH-1:0] dataOut
);

logic [DATA_WIDTH-1:0] data;

// sync_reg
always_ff@(posedge fastClk) begin
    if(reset) begin
        dataOut <= '0;
    end
    else begin
        dataOut <= data;
    end
end

// combination logic
// Invert all the bits of "dataIn"
always_comb begin
    data = ~dataIn;
end

endmodule