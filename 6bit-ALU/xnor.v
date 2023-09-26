module sixbit_xnor(
    input wire [5:0] a, b,
    output wire [5:0] out
    );

    // Using the mystery module which we discovered in LAB A to be an XNOR gate
    
    // Use this module to preform a bitwise XNOR operation on all bits
    mystery_module bit0 (.i0(a[0]), .i1(b[0]), .op(out[0]));
    mystery_module bit1 (.i0(a[1]), .i1(b[1]), .op(out[1]));
    mystery_module bit2 (.i0(a[2]), .i1(b[2]), .op(out[2]));
    mystery_module bit3 (.i0(a[3]), .i1(b[3]), .op(out[3]));
    mystery_module bit4 (.i0(a[4]), .i1(b[4]), .op(out[4]));
    mystery_module bit5 (.i0(a[5]), .i1(b[5]), .op(out[5]));
    
endmodule


module mystery_module
   // I/O ports
   (
    input wire i0, i1,
    output wire op
   );

   // signal declaration
   wire p0, p1;

   // body
   // sum of two product terms
   assign op = p0 | p1;
   // product terms
   assign p0 = ~i0 & ~i1;
   assign p1 = i0 & i1;

endmodule