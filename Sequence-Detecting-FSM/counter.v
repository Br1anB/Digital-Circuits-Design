module bitcounter(
    input clk, reset, max_tick_reg, test_bit,
    output [15:0] count
    );
    
    reg [15:0] one_count; // store count
    
    always @ (posedge clk) begin
        if (reset) begin
            one_count <= 16'b0000000000000000; //if reset set count back to zero
        end
        else begin
            if (max_tick_reg) begin
                // If the LFSR max_tick reset count to zero
                one_count <= 16'b0000000000000000;
            end
            else begin
                // else if test_bit == 1 add one to count
                if (test_bit) one_count = one_count + 1;
            end
        end
    end
    
    assign count = one_count;
    
endmodule
