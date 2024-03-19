module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    reg tensssena, onesmmena, tensmmena, hhena;
    dc onesss(clk, reset, ena, ss[3:0], tensssena);
    sixc tensss(clk, reset, tensssena, ss[7:4], onesmmena);
    dc onesmm(clk, reset, onesmmena, mm[3:0], tensmmena);
    sixc tensmm(clk, reset, tensmmena, mm[7:4], hhena);
    hourcounter hc(clk, reset, hhena, hh[7:0]);
    
    always @(posedge clk) begin
        if (reset) 
            pm <= 0;
        else if (ena & (hh == 8'h11) & (mm == 8'h59) & (ss == 8'h59)) 
            pm <= ~pm;
        else 
            pm <= pm;
    end

endmodule

module hourcounter(
    input clk,
    input reset,
    input enable,
    output reg [7:0] q);

    always @(posedge clk) begin
        if (reset)	// Count to 12-hour requires rolling over 12->1 hour
            q <= 8'h12;
        else if (enable & (q == 8'h12))
            q <= 8'h01;
        else if (enable & q == 8'h09)
            q <= 8'h10;
        else if (enable)
            q <= q + 1;
    end
	
endmodule

module sixc(
    input clk,
    input reset,
    input enable,
    output reg [3:0] q,
    output ena);
	
    always @(posedge clk) begin
        if (reset)	// Count to 6 requires rolling over 5->0 instead of the more natural 15->0
            q <= 0;
        else if (enable & (q == 5))
            q <= 0;
        else if (enable)
            q <= q + 1;
    end

    assign ena = enable & (q==5);

endmodule

module dc(
    input clk,
    input reset,
    input enable,
    output reg [3:0] q,
    output ena);

    always @(posedge clk) begin
        if (reset)	// Count to 10 requires rolling over 9->0 instead of the more natural 15->0
            q <= 0;
        else if (enable & (q == 9))
            q <= 0;
        else if (enable)
            q <= q + 1;
    end

    assign ena = enable & (q==9);  

endmodule
