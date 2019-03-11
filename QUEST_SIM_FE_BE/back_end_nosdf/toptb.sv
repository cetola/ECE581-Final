`timescale 1ns / 100ps

  module toptb();
  //default to 1GHz
  parameter CLOCK_CYCLE  = 2;
  parameter CLOCK_WIDTH  = CLOCK_CYCLE/2;
  parameter IDLE_CLOCKS  = 4;
  parameter DATA_WIDTH   = 4;
  typedef enum {FALSE, TRUE} bool_t;
  
  integer i = 0;
  logic [127:0] data, oData;
  bit dataIn, reset, control, clk;
  logic [DATA_WIDTH-1:0] dataOut;

  integer log;
  int err_count;
  int log_count;

  top t1(.dataIn(dataIn),
        .fastClk(clk),
        .reset(reset),
        .control(control),
        .dataOut(dataOut));

  initial
    begin
    //open log file
    log = $fopen("a-data-log.log");
    $display(">>>>>Begin testbench");
    //debugging
    $fdisplay(log, "\t\tdataIn\tdataOut\treset\tcontrol\tclk");
    $fmonitor(log, "\t\t%b\t%b\t%b\t%b\t%b", dataIn, dataOut, reset, control,clk);
    end

  //free running clock
  initial
    begin
    clk = TRUE;
    forever #CLOCK_WIDTH clk = ~clk;
    end


  initial
    begin
    reset = TRUE;
    repeat (IDLE_CLOCKS) @(negedge clk);
    reset = FALSE;
    end

    //----------------------------------------------------
    // Main Test
    //----------------------------------------------------

  initial
    begin
    assert(std::randomize(data));
    $fdisplay(log, "data = %070b", data);
    repeat (3) @(negedge clk); // Reset false
    repeat (1) @(negedge clk); // Reset true
    repeat (1) @(negedge clk); // dataOut ready

    //1 - 4
    repeat (127) begin
        @(negedge clk) begin
            log_err(1'b0); //log no errors for now
            dataIn = data[i];
            $fdisplay(log,"REPEAT %d", i);
        end
        @(posedge clk) begin
            i = i + 1;
        end
    end
    $fclose(log);
    $display(">>>>>There were %d errors.", err_count);
    $display(">>>>>End testbench");
    $stop;
    end

    function automatic void log_err(
      input bit t1);
      log_count++;
      if(t1 === TRUE) //log error
        begin
        err_count++;
        $fdisplay(log, "ERR%d: expected %b got %b", err_count, FALSE, TRUE);
        end
      else
        $fdisplay(log, "check count: %d", log_count);
    endfunction
endmodule
