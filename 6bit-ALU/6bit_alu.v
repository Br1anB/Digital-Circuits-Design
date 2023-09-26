module sixbit_alu(
    input wire [5:0] a, b,
    input wire [2:0] opcode,
    output wire [5:0] result
    );
    
    wire [5:0] d1,d2,d3,d4,d5,d6,d7,d8; //Initialise wires used to pass results from all blocks into multiplexer
    
    assign d1 = a; // Pass a directly into data1 in multiplexer
    assign d2 = b; // Pass b directly into data2 in multiplexer
    SIXbit_ripple_adder ADDER1 (.x(6'b0),.y(a[5:0]),.sel(1'b1),.overflow(),.c_out(),.sum(d3[5:0])); // Negate a using adder 0 - A = -A, output sum into data3
    SIXbit_ripple_adder ADDER2 (.x(6'b0),.y(b[5:0]),.sel(1'b1),.overflow(),.c_out(),.sum(d4[5:0])); // Negate b using adder 0 - B = -B, output sum into data4

    // Pass Both a and b into 8bit comparator, padd the first 2-bits of 8-bit number with Most Significant Bit from 6-bit input
    // Example: 6-bit input: 100001 => 8-bit input for comparator: 11100001
    // Example: 6-bit input: 011111 => 8-bit input for comparator: 00011111
    // Outputs less than value into data5
    eight_bit_comp COMP1 (.a({a[5], a[5], a}), .b({b[5], b[5], b}), .G(), .Q(), .L(d5));

    sixbit_xnor XNOR (.a(a[5:0]), .b(b[5:0]), .out(d6[5:0])); // Pass a and b into 6-bit XNOR bitwise function, output 'out' into data6

    // Pass both a and b into adder, sel is set to 0 in order to preform adding operation, sum is output into data7
    SIXbit_ripple_adder ADDER3 (.x(a[5:0]),.y(b[5:0]),.sel(1'b0),.overflow(),.c_out(),.sum(d7[5:0]));

    // Pass both a and b into adder, sel is set to 1 in order to preform subtracting operation, sum is output into data8
    SIXbit_ripple_adder ADDER4 (.x(a[5:0]),.y(b[5:0]),.sel(1'b1),.overflow(),.c_out(),.sum(d8[5:0]));
    
    // All data wires are passed into the multiplexer module as well as the operation code, depending on the opcode the corresponding
    // function output will be passed through result
    multiplexer MUX (.d1(d1),.d2(d2),.d3(d3),.d4(d4),.d5(d5),.d6(d6),.d7(d7),.d8(d8),.opcode(opcode[2:0]),.result(result[5:0]));
    
endmodule
