module twobit_greater(
    input wire [1:0] a, b,
    output wire agrb
    );
    
    wire [1:0] xa;
    wire [1:0] xb;
    wire w1,w2,w3;
    
    and g1 (w1, a[0], !b[0]);
    and g2 (w2, a[1], !b[0], !b[1]);
    and g3 (w3, a[0], a[1], !b[1]);
    
    or g4 (agrb, w1, w2, w3);
    
endmodule
