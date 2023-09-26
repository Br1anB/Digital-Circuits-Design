module lfsr
    #(parameter seed = 16'b0100010101011111) // seed given from lab sheet
    (
        input clk, rst_n,
        output [15:0] Q_out,
        output reg max_tick_reg // pos for clock cycles multiples of 2^n-1
    );

    reg [15:0] Q_state;
    wire [15:0] Q_ns;
    reg [15:0] count; // Clock Cycle Counter

    always @ (posedge clk) begin
        if (rst_n) begin // When reset is high
            Q_state <= seed; // Reset seed to "seed"
            count <= 0; // Reset cycle counter
            max_tick_reg = 0; // OutPut Low
        end
        else begin // Else when enable is high
            Q_state <= Q_ns; // Shift Q_state
            count <= count + 1; // Add 1 to count
            if (count == 65534) begin // If current clock cycle is 65,535 (2^16-1)
                count <= 0; //reset counter
                max_tick_reg <= 1; // output high for one clock cycle
            end
            else 
                max_tick_reg <= 0; // output low for every other clock cycle
        end
            
    end

    // Using taps specified in data sheet for N=16, taps used: 16,15,13,4
    assign Q_ns = {Q_state[14:0], (Q_state[15]^Q_state[14]^Q_state[12]^Q_state[3])};
    
    assign Q_out = Q_state; // Output Current state
    
endmodule
