module SIXbit_ripple_adder(
    input wire [5:0] x, y,
    input wire sel,
    output wire overflow, c_out,
    output wire [5:0] sum
    );
    
    wire [5:0] y2;
    //if sel is set to one flip all the bits of the second number
    assign y2[0] = y[0] ^ sel;// '^' = XOR
    assign y2[1] = y[1] ^ sel;
    assign y2[2] = y[2] ^ sel;
    assign y2[3] = y[3] ^ sel;
    assign y2[4] = y[4] ^ sel;
    assign y2[5] = y[5] ^ sel;
    
    wire c0, c1, c2, c3, c4, c5;//wires see block diagram

    //sum all individual bits with previous carry bit
    FullAdder bit0 (.a(x[0]), .b(y2[0]), .cin(sel), .cout(c0), .s(sum[0]) );
    FullAdder bit1 (.a(x[1]), .b(y2[1]), .cin(c0), .cout(c1), .s(sum[1]) );
    FullAdder bit2 (.a(x[2]), .b(y2[2]), .cin(c1), .cout(c2), .s(sum[2]) );
    FullAdder bit3 (.a(x[3]), .b(y2[3]), .cin(c2), .cout(c3), .s(sum[3]) );
    FullAdder bit4 (.a(x[4]), .b(y2[4]), .cin(c3), .cout(c4), .s(sum[4]) );
    FullAdder bit5 (.a(x[5]), .b(y2[5]), .cin(c4), .cout(c5), .s(sum[5]) );
    
    xor g7 (overflow, c5, c4); //overflow based off last two carry bits
    assign c_out = c5;
    
    
endmodule
