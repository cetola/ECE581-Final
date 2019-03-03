//sync counter provided by Kushal Shah and Dr. Ataur Patwary

module sync_counter2
(   input logic       clkA, clkB, clkC, clkD,
    input logic       rst,
    input logic       cntrlAB, cntrlCD,
    input logic       di,
    output logic      dco);

    logic clkAB, clkCD;
    logic [1:0] dao;

    always_comb begin
        clkAB = cntrlAB? clkB : clkA;
        clkCD = cntrlCD? clkD : clkC;
    end

    always_ff @ (posedge clkAB) begin
        if(rst)
            dao <= 1'b0;
        else begin
            dao <= di;
        end
    end

    always_ff @ (posedge clkCD) begin
        if(rst)
            dco <= 1'b0;
        else begin
            dco <= (dao[0] ^ dao[1]);
        end
    end
endmodule
