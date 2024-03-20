`timescale 1ns / 1ps

module tb_clock ();
    // clock and reset signals
    reg clk;
    reg reset;
    
    // design inputs and outputs
    reg ena;
    wire pm;
    wire [7:0] hh;
    wire [7:0] mm;
    wire [7:0] ss;
    
    // DUT instantiation
    example_design dut (
        .clk (clk),
        .reset (reset),
        .ena (ena),
        .pm (pm),
        .hh (hh),
        .mm (mm),
        .ss (ss)
  );
    
    // generate the clock
    initial begin
        clk = 1'b0;
        forever #1 clk = ~clk;
    end

    // generate the reset
    initial begin
        reset = 1'b1;
        #10
        reset = 1'b0;
        #1000
        reset = 1'b1;
        #10
        reset = 1'b0;
        #5000
        reset = 1'b1;
        #10
        reset = 1'b0;
    end

    // generate the enable
    initial begin
        // task to display the FPGA IO
        $monitor("time=%3d, ena=%b, pm=%b, hh=%2d, mm=%2d, ss=%2d \n",
              $time, ena, pm, hh, mm, ss);

        // generate enable input with a 20 ns delay
        ena = 1'b0;
        #20
        ena = 1'b1;
        #20
        ena = 1'b0;
        #20
        ena = 1'b1;
    end

endmodule : tb_clock
