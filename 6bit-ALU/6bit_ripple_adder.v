module FullAdder(a, b, cin, s, cout);
  // 3C7 LabD 2010
  // a and b are the bits to add
  // cin is carry in
  input wire a, b, cin;
  
  // s is the sum of a and b. cout is any carry out bit
  // wires since just using assign here
  output wire s, cout;

  // logic for sum and carry
  assign s = cin ^ a ^ b;
  assign cout = (b & cin) | (a & cin) | (a & b); 
  
endmodule

module SIXbit_ripple_adder(
    input wire [5:0] x, y,
    input wire sel,
    output wire overflow, c_out,
    output wire [5:0] sum
    );
    
    // XOR gates to preform negation if sel = 1 and subtraction is desired
    // Flip all bits in y, and add one if subtraction

    wire [5:0] y2;
    // To flip bits when selection is 1 ie. selection = substitution, XOR y with selection
    assign y2[0] = y[0] ^ sel;
    assign y2[1] = y[1] ^ sel;
    assign y2[2] = y[2] ^ sel;
    assign y2[3] = y[3] ^ sel;
    assign y2[4] = y[4] ^ sel;
    assign y2[5] = y[5] ^ sel;
    
    // After flipping bits 1 must be added in order to convert to a 2's compliment neg number
    // This is done by inputting selection as the carry input for the first adder
    wire c0, c1, c2, c3, c4, c5;
    FullAdder bit0 (.a(x[0]), .b(y2[0]), .cin(sel), .cout(c0), .s(sum[0]) ); // First adder, Carry in = selection

    // Ripple add by setting carry in as the previous adder's carry out
    FullAdder bit1 (.a(x[1]), .b(y2[1]), .cin(c0), .cout(c1), .s(sum[1]) );
    FullAdder bit2 (.a(x[2]), .b(y2[2]), .cin(c1), .cout(c2), .s(sum[2]) );
    FullAdder bit3 (.a(x[3]), .b(y2[3]), .cin(c2), .cout(c3), .s(sum[3]) );
    FullAdder bit4 (.a(x[4]), .b(y2[4]), .cin(c3), .cout(c4), .s(sum[4]) );
    FullAdder bit5 (.a(x[5]), .b(y2[5]), .cin(c4), .cout(c5), .s(sum[5]) );
    
    xor g7 (overflow, c5, c4); // Overflow
    assign c_out = c5; // Carry out
    
endmodule
