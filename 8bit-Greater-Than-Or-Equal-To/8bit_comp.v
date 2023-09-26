module eight_bit_comp(
    input wire [7:0] a,b,
    output wire G, Q, L
    );
    
    wire [1:0] g, l, q;
    
    four_bit_comp comp1 (.a(a[7:4]), .b(b[7:4]), .G(g[1]), .Q(q[1]), .L(l[1]));
    four_bit_comp comp2 (.a(a[3:0]), .b(b[3:0]), .G(g[0]), .Q(q[0]), .L(l[0]));
    
    assign G = (g[1])|(q[1]&g[0]);
    assign L = (l[1])|(q[1]&l[0]);
    assign Q = q[0]&q[1];
    
endmodule

module four_bit_comp(
    input wire [3:0] a,b,
    output wire G, Q, L
    );
    
    wire [1:0] g, l, q;
    
    two_bit_comp comp1(.a(a[3:2]), .b(b[3:2]), .G(g[1]), .Q(q[1]), .L(l[1]));
    two_bit_comp comp2(.a(a[1:0]), .b(b[1:0]), .G(g[0]), .Q(q[0]), .L(l[0]));
    
    assign G = (g[1])|(q[1]&g[0]);
    assign L = (l[1])|(q[1]&l[0]);
    assign Q = q[0]&q[1];
    
endmodule
    
    
module two_bit_comp(
    input wire [1:0] a,b,
    output wire G, Q, L
    );
    
    eq2 comp1(.a(a), .b(b), .aeqb(Q));
    twobit_greater comp2(.a(a), .b(b), .agrb(G));
    nor g1 (L, G, Q);
    
endmodule