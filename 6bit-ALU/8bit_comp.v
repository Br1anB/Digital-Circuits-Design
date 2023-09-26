module eight_bit_comp(
    input wire [7:0] a,b,
    output wire G, Q, L
    );
    
    wire [1:0] g, l, q;
    wire great, eq, less;
    
    // Pass the 4 most significant bits into a 4-bit comparator
    four_bit_comp comp1 (.a(a[7:4]), .b(b[7:4]), .G(g[1]), .Q(q[1]), .L(l[1]));
    // Pass the 4 least significant bits into a 4-bit comparator
    four_bit_comp comp2 (.a(a[3:0]), .b(b[3:0]), .G(g[0]), .Q(q[0]), .L(l[0]));
    
    // Greater is 1 when: The 4 MSBs are greater than those of B, also 1 when the MSBs are equal but A's LSBs are greater than those of B
    assign great = (g[1])|(q[1]&g[0]);
    // Less is 1 when: The 4 MSBs are less than those of B, also 1 when the the MSBs are equal but A's LSBs are less than those of B
    assign less = (l[1])|(q[1]&l[0]);
    // Equal is 1 when: Both the MSBs and LSBs of both A and B are identical
    assign eq = q[0]&q[1];
    
    wire sign_check;

    xnor (sign_check, a[7], b[7]); // sign_check is 1 when both numbers signs are equal ie both negative or both positive

    // A < B when:
    // both numbers are negative (Most significant bit of each number is 1, sign_check & a[7]) and a is greater than b
    // both numbers are positive (Most significant bit of each number is 0, sign_check & ~a[7]) and a is less than b
    // if a is negative and b is positive
    or (L, (sign_check & a[7] & great), (sign_check & ~a[7] & less), ~(sign_check | b[7]));

    // A > B when:
    // both numbers are negative (Most significant bit of each number is 1, sign_check & a[7]) and a is less than b
    // both numbers are positive (Most significant bit of each number is 0, sign_check & ~a[7]) and a is greater than b
    // if a is positive and b is negative
    or (G, (sign_check & a[7] & less), (sign_check & ~a[7] & great), ~(sign_check | a[7]));
    
    assign Q = eq; // EQ is only every true when all bits equal

endmodule


module four_bit_comp(
    input wire [3:0] a,b,
    output wire G, Q, L
    );
    
    wire [1:0] g, l, q;
    
    // Pass the 2 MSBs into a two bit comparator
    two_bit_comp comp1(.a(a[3:2]), .b(b[3:2]), .G(g[1]), .Q(q[1]), .L(l[1]));
    // Pass the 2 LSBs into a two bit comparator
    two_bit_comp comp2(.a(a[1:0]), .b(b[1:0]), .G(g[0]), .Q(q[0]), .L(l[0]));
    
    // G is 1 when: The 2 MSBs are greater than those of B, also 1 when the MSBs are equal but A's LSBs are greater than those of B
    assign G = (g[1])|(q[1]&g[0]);
    // L is 1 when: The 2 MSBs are less than those of B, also 1 when the MSBs are equal but A's LSBs are less than those of B
    assign L = (l[1])|(q[1]&l[0]);
    // Q is 1 when: When both numbers are identical
    assign Q = q[0]&q[1];
    
endmodule
    
    
module two_bit_comp(
    input wire [1:0] a,b,
    output wire G, Q, L
    );
    
    eq2 comp1(.a(a), .b(b), .aeqb(Q)); // Returns Q = 1 if numbers are the same
    twobit_less comp2(.a(a), .b(b), .alsb(L)); // Returns alsb = 1 when a is less than b
    nor g1 (G, L, Q); // If neither A=B or A<B then A>B, hence set G = 1
    
endmodule


module twobit_less(
    input wire [1:0] a, b,
    output wire alsb
    );
    
    wire [1:0] xa;
    wire [1:0] xb;
    wire w1,w2,w3;
    
    and g1 (w1, a[0], !b[0]);
    and g2 (w2, a[1], !b[0], !b[1]);
    and g3 (w3, a[0], a[1], !b[1]);
    
    or g4 (alsb, w1, w2, w3);
  
endmodule


module eq2
   (
    input  wire[1:0] a, b,			// a adn b are the two 2-bit numbers to compare
    output wire aeqb				// single bit output. Should be high if a adn b the same
   );

   // internal signal declaration, used to wire outpus of the 1 bit comparators
   wire e0, e1;

   // body
   // instantiate two 1-bit comparators that we already know are tested and work
   // named instantiation allows us to change order of ports.
   eq1 eq_bit0_unit (.i0(a[0]), .i1(b[0]), .eq(e0));
   eq1 eq_bit1_unit (.eq(e1), .i0(a[1]), .i1(b[1]));
   //changed 'eq3' to 'eq1', also added a ';' to end of line 15

   // a and b are equal if individual bits are equal, which comes from the 1-bit comparators
   assign aeqb = e0 & e1; //Changed from '^' to '&'

endmodule


module eq1
   // I/O ports
   (
    input wire i0, i1,
    output wire eq
   );

   // signal declaration
   wire p0, p1;

   // body
   // sum of two product terms
   assign eq = p0 | p1;
   // product terms
   assign p0 = ~i0 & ~i1;
   assign p1 = i0 & i1;

endmodule