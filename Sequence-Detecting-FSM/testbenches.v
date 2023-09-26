`timescale 1ns / 10ps

// Test Bench for testing top level module
module top_TB;
    reg clk, reset;
    wire [6:0] LED_out;
    wire [3:0] anode_select;
    wire [15:0] count;

    top_module uut (.CCLK(clk), .reset(reset), .LED_out(LED_out), .anode_select(anode_select), .count(count));
    
    initial begin
        clk = 1; // Initialize clk to 0
        forever #10 clk = ~clk; // Toggle clk every 10 time units
    end

    initial begin
        reset = 1;
        #40 // reset high for first two clock cycles
        reset = 0;
        #1310720 // run for the entire sequence of 2^16-1 * clock cycle
        #40 // Allow of an extra 2 clock cycles to confirm LFSR is looping back around
        // stop simulation
        $stop;
    end


endmodule

// Test Bench for testing LFSR module
module lfsr_TB;
    reg clk, reset;
    wire [15:0] Q;
    wire tick_reg;

    initial begin
        clk = 1; // Initialize clk to 0
        forever #10 clk = ~clk; // Toggle clk every 10 time units
    end

    lfsr uut (.clk(clk), .rst_n(reset), .Q_out(Q), .max_tick_reg(tick_reg));

    initial begin
        reset = 1;
        #40
        reset = 0;
        //65,536 * 20ms = 1,310,720
        #1310720
        #40
        // stop simulation
        $stop;
    end

endmodule

// Test Bench for testing Counter module
module counter_TB;
    reg clk, reset, max_tick, test_bit;
    wire [15:0] count;

    initial begin
        clk = 1; // Initialize clk to 0
        forever #10 clk = ~clk; // Toggle clk every 10 time units
    end

    bitcounter uut (.clk(clk), .reset(reset), .max_tick_reg(max_tick), .test_bit(test_bit), .count(count));

    initial begin
        reset = 1;
        test_bit = 0;
        max_tick = 0;
        #40
        // After reset high for 2 clock cycles input test vector
        reset = 0;

        // Test vector input one bit at a time
        // test vector: 100101100111
        test_bit = 1;
        #20
        test_bit = 0;
        #20
        test_bit = 0;
        #20
        test_bit = 1;
        #20
        test_bit = 0;
        #20
        test_bit = 1;
        #20
        max_tick = 1; //ensure max tick resets counter
        test_bit = 0;
        #20
        max_tick = 0;
        test_bit = 1;
        #20
        test_bit = 1;
        #20
        reset = 1; //ensure reset can reset counter
        test_bit = 1;
        #20
        test_bit = 1;
        #20
        
        // stop simulation
        $stop;
    end

endmodule

// Test Bench for testing Finite State Machine module
module fsm_TB;
    reg clk, reset;
    
    reg inputSignal;
    wire outputSignal;

    //lfsr stuff
    //wire [11:0] Q;
    //wire tick_reg;
    
    //lfsr uut (.clk(clk), .rst_n(reset), .Q_out(Q), .max_tick_reg(tick_reg));
    fsm uut (.inputSignal(inputSignal), .clk(clk), .rst(reset), .outputSignal(outputSignal));
    
    initial begin
        clk = 1; // Initialize clk to 0
        forever #10 clk = ~clk; // Toggle clk every 10 time units
    end
    
    initial begin
        reset = 1; //set reset to high for 10 clock cycles (200ns)
        inputSignal = 0;
        #40 //wait the 10 clock cycles
        
        reset = 0; // Set reset to low
        
        // Test Vector #1, test if 1 is output after codeword is input 101100000100
        inputSignal = 1;
        #20
        inputSignal = 0;
        #20
        inputSignal = 1;
        #20
        inputSignal = 1;
        #20
        inputSignal = 0;
        #20
        inputSignal = 0;
        #20
        inputSignal = 0;
        #20
        inputSignal = 0;
        #20
        inputSignal = 0;
        #20
        inputSignal = 1;
        #20
        inputSignal = 0;
        #20
        inputSignal = 0;
        #20
        inputSignal = 1;
        #20
        inputSignal = 0;
        #20
        inputSignal = 0;
        #20
        
        
        // 0
        
        inputSignal = 0;
        #20
        
        
        // stop simulation
        $stop;
    end
    
endmodule