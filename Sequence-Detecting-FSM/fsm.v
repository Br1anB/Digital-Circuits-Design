module fsm 
    (
    input inputSignal,
    input clk, rst,
    output outputSignal
    );

    // Initialise all 13 states
    parameter st_0 = 4'b0000, st_1 = 4'b0001, st_2 = 4'b0010,
            st_3 = 4'b0011, st_4 = 4'b0100, st_5 = 4'b0101,
            st_6 = 4'b0110, st_7 = 4'b0111, st_8 = 4'b1000,
            st_9 = 4'b1001, st_10 = 4'b1010, st_11 = 4'b1011 , st_12 = 4'b1100;
    
    // Next state and state
    reg [3:0] nst, st;

    // Output 1 when current state = final state
    // outputs 0 for every other state
    assign outputSignal = (st == st_12);
    
    // Update current state to next state at every posedge of clk
    always @ (posedge clk) begin
        if (rst) st <= st_0;
        else st <= nst;
    end

    // State Tranisitions
    always @(*) begin
        nst = st;
        // Case logic follows that outlined in the state machine diagram found in the report
        case (st)
          st_0: if(inputSignal) nst = st_1; // Only move from idle when inputSignal = 1 else loop back to st_0
          st_1: if(inputSignal) nst = st_1;
                else nst = st_2;
          st_2: if(inputSignal) nst = st_3;
                else nst = st_0;
          st_3: if(inputSignal) nst = st_4;
                else nst = st_2;
          st_4: if(inputSignal) nst = st_1;
                else nst = st_5;
          st_5: if(inputSignal) nst = st_3;
                else nst = st_6;
          st_6: if(inputSignal) nst = st_1;
                else nst = st_7;
          st_7: if(inputSignal) nst = st_1;
                else nst = st_8;
          st_8: if(inputSignal) nst = st_1;
                else nst = st_9;
          st_9: if(inputSignal) nst = st_10;
                else nst = st_0;
         st_10: if(inputSignal) nst = st_1;
                else nst = st_11;
         st_11: if(inputSignal) nst = st_3;
                else nst = st_12;
         st_12: if (inputSignal) nst = st_1;
                else nst = st_0;
         default: nst = st_0; // default if no case is met
        endcase
    end


endmodule