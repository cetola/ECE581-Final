`timescale 1ns/1ns
// Testbench for sync_counter with 2 clock multiplexers
// Author: Sanika Balkawade
// Date: 3/5/2019

module tb_sync_counter_fe();

reg rst, cntrlAB, cntrlCD;
reg [1:0] di;
reg clkA = 1'b0;
reg clkB = 1'b0;
reg clkC = 1'b0;
reg clkD = 1'b0;
wire dco;
reg clkAB, clkCD;
reg Result_pass;
reg f_dco = 0; 
reg [1:0] f_dao = 0;


always @(*) begin

clkAB = cntrlAB ? clkB : clkA;
clkCD = cntrlCD ? clkD : clkC;

end

sync_counter sync_counter(.clkA(clkA), .clkB(clkB), .clkC(clkC), .clkD(clkD), .rst(rst),.cntrlAB(cntrlAB), .cntrlCD(cntrlCD),.di(di),.dco(dco));

always #5 clkA = ~clkA;

always #5 clkB = ~clkB;

always #5 clkC = ~clkC;

always #5 clkD = ~clkD;

initial begin
clkA = 1'b1;
clkC = 1'b1;
#1;
clkB = 1'b1;
clkD = 1'b1;

end


function void checkResult();
    if(f_dco == dco )
    begin
	Result_pass = 1;
        $display($time, "PASS");
    end
    else 
    begin
	Result_pass = 0;
        $display($time, "Error");

    end
endfunction


initial begin

#8;
rst = 1; 
di = 0;


for (int i = 0; i < 16; i = i+1, rst = 0, {cntrlAB,cntrlCD} = i,di = i) begin

    @(posedge clkA); 
    begin
        f_dao = di;
        @(posedge clkAB); 
        f_dco = f_dao [0] ^ f_dao[1];
        @(posedge clkCD); 
        checkResult();
    end //end posedge clkA
end // end for loop 

@(posedge clkA); $stop; 

end // end initial

endmodule
