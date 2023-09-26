`timescale 1ns / 10ps

module test_bench;

    reg clk, rst, d;
    wire q;
    
    d_ff_reset m0 (.clk(clk), .reset(rst), .d(d), .q(q));
    
    initial begin
        clk = 1; // Initialize clk to 0
        forever #10 clk = ~clk; // Toggle clk every 10 time units
    end
    
    initial begin
        rst = 1;
        #30
        rst = 0;
        #90
        rst = 1;
        #30
        rst = 0;
    end
    
    initial begin
        d = 0;
        #20
        d = 1;
        #27
        d = 0;
        #27
        d = 1;
        #100
        d = 0;
    end
    
    
endmodule
