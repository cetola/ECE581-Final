//sync counter provided by Kushal Shah and Dr. Ataur Patwary

module sync_counter
(   input logic       clkA, clkB,
    input logic       rst,
    input logic       cntrl,
    input logic       di,
    output logic      dco);

    logic clkAB, clkCD;
    logic dao;
    logic dco;

    always_comb begin
        clkAB = cntrl? clkB : clkA;
        dbo = dao | di;
    end

    always_ff @ (posedge clkAB) begin
        if(rst)
            dao <= 1'b0;
        else begin
            dao <= di;
        end
    end

    always_ff @ (posedge clkAB) begin
        if(rst)
            dco <= 1'b0;
        else begin
            dco <= dbo;
        end
    end
endmodule