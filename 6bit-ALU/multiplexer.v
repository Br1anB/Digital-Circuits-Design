module multiplexer(
    input wire [5:0] d1,d2,d3,d4,d5,d6,d7,d8, // All input data into the multiplexer
    input wire [2:0] opcode, // The operations Code for the multiplexer
    output reg [5:0] result // Output result
    );
    
    always @(*) begin
        // Depending on opcode output corresponding data
        case (opcode)
            3'b000: result = d1; // If opcode = '000' output data 1
            3'b001: result = d2; // ...
            3'b010: result = d3;
            3'b011: result = d4;
            3'b100: result = d5;
            3'b101: result = d6;
            3'b110: result = d7;
            3'b111: result = d8;
        default: result = 6'b0;
        endcase
    end

endmodule
