module lfsr
    #(parameter seed = 12'b001101100111) // seed of board number (91) xor with student digits (828)
    //#(parameter seed = 12'b111111111111) // "forbidden" seed value for LFSR using XNOR
    (
        input clk, sh_en, rst_n,
        output [11:0] Q_out,
        output reg max_tick_reg // pos for clock cycles multiples of 2^n-1
    );

    reg [11:0] Q_state;
    wire [11:0] Q_ns;
    reg [11:0] count; // Clock Cycle Counter

    always @ (posedge clk) begin
        if (rst_n) begin // When reset is high
            Q_state <= seed; // Reset seed to "seed"
            count <= 0; // Reset cycle counter
            max_tick_reg = 0; // OutPut Low
        end
        else if (sh_en) begin // Else when enable is high
            Q_state <= Q_ns; // Shift Q_state
            count <= count + 1; // Add 1 to count
            if (count == 4094) begin // If current clock cycle is 4094 (2^12-1)
                count <= 0; //reset counter
                max_tick_reg <= 1; // output high for one clock cycle
            end
            else 
                max_tick_reg <= 0; // output low for every other clock cycle
        end
            
    end

    // Using taps specified in data sheet for N=12, taps used: 12, 6, 4, 1
    assign Q_ns = {Q_state[10:0], ~(Q_state[11]^Q_state[5]^Q_state[3]^Q_state[0])};
    
    assign Q_out = Q_state; // Output Current state
    
endmodule
