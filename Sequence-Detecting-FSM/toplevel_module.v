module top_module
(
    input CCLK, reset,
    output wire [6:0] LED_out,
    output wire [3:0] anode_select,
    output wire [15:0] count
);

    wire tick_reg, test_bit, clock;
    wire [15:0] Q;

    clock M0 (CCLK, 50000, clock); //Scale clock to 0.5ms, hence 1000 bits from LFSR every second
    // Allows for 65,535 cycles from LFSR in ~65secs, easily visualise counter operating

    // Instantiates the LFSR module
    lfsr M1 (.clk(clock), .rst_n(reset), .Q_out(Q), .max_tick_reg(tick_reg));

    // Instantiates the FSM module
    fsm M2 (.inputSignal(Q[0]), .clk(clock), .rst(reset), .outputSignal(test_bit));

    // Instantiates the Counter module
    bitcounter M3 (.clk(clock), .reset(reset), .max_tick_reg(tick_reg), .test_bit(test_bit), .count(count));

    // Instantiates the 7-Segment Display Controller module
    seven_segment_controller M4 (.clk(CCLK), .reset(reset), .count(count), .anode_select(anode_select), .LED_out(LED_out));

endmodule