`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: PSU
// Engineer: Stephano Cetola
// 
// Create Date: 01/23/2019
// Module Name: multiply_reg
// Project Name: ECE581 Final Project
// Description: 
// A "multiply" register. Contains no logic delay. Essentially just where the data
// ends up?
// 
//////////////////////////////////////////////////////////////////////////////////

module multiply_reg #(
	parameter DATA_WIDTH = 4
) (
    input logic dataIn,
    input logic slowClk,
    input logic reset,
    output logic [DATA_WIDTH-1:0] dataOut
);

// sync_reg
always_ff@(posedge slowClk) begin
    if(reset) begin
        dataOut <= '0;
    end
    else begin
        dataOut <= dataIn;
    end
end

endmodule
