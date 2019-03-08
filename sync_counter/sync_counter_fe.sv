`timescale 1ns/1ns
/*################################################################
# Name        : sync_counter.sv
# Author      : Kushal Shah
# Guide       : Dr. Ataur Patwary
# School      : Portland State University
# Date        : 1/27/2019
# Description : Counter with  2 clocks
################################################################
*/

module sync_counter
(
	input logic 		clkA, clkB, clkC, clkD,
	input logic 		rst,
	input logic     	cntrlAB, cntrlCD,
	input logic [1:0]	di,
	output logic 		dco
);

logic clkAB, clkCD;
logic [1:0] dao;

always_comb
begin	
	clkAB = cntrlAB ? clkB : clkA;
 	clkCD = cntrlCD ? clkD : clkC;
		
end

always_ff @(posedge clkAB)
begin 
	if(rst)			//Synchronour reset
		dao <= '0;
	else
		dao <= di;


end

always_ff @(posedge clkCD)
begin
	if(rst)
		dco <= '0;
	else
	begin
		dco <= (dao[0] ^ dao[1] );
	end
end


endmodule

