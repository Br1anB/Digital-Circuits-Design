`timescale 1ns / 10ps

module lfsr_TB;
    reg clk, sh, reset;
    wire [11:0] Q;
    wire tick_reg;
    
    lfsr uut (.clk(clk), .sh_en(sh), .rst_n(reset), .Q_out(Q), .max_tick_reg(tick_reg));
    
    initial begin
        clk = 1; // Initialize clk to 0
        forever #10 clk = ~clk; // Toggle clk every 10 time units
    end
    
    initial begin
        reset = 1; //set reset to high for 10 clock cycles (200ns)
        sh = 1;
        #200 //wait the 10 clock cycles
        reset = 0; // Set reset to low
        #82000; // wait over 4095 (2^12-1) clock cycles, allows us to see the LFSR wrap back around
        //#81900; //wait another 4095 cycles and check if its the same
        // stop simulation
        $stop;
    end
    
    
endmodule
