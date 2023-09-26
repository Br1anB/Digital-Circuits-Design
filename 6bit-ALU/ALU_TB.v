`timescale 1 ns/10 ps

module ALU_TB;
    reg [5:0] test_vec1, test_vec2;
    reg [2:0] test_opcode;
    wire [5:0] test_result;

    sixbit_alu uut (.a(test_vec1), .b(test_vec2), .opcode(test_opcode), .result(test_result));

    initial
    begin
        // Board Num: 91, 91 -> 1011011, last 6-bits = 011011
        /*
        //--------------------------
        //  ALU OPCODE 000 => A
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011011;
        test_opcode = 3'b000;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b111111;
        test_opcode = 3'b000;
        # 200;

        // Test 3
        test_vec1 = 6'b111111;
        test_vec2 = 6'b000000;
        test_opcode = 3'b000;
        # 200;

        //--------------------------
        //  ALU OPCODE 001 => B
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011011;
        test_opcode = 3'b001;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b111111;
        test_opcode = 3'b001;
        # 200;

        // Test 3
        test_vec1 = 6'b111111;
        test_vec2 = 6'b000000;
        test_opcode = 3'b001;
        # 200;

        //--------------------------
        //  ALU OPCODE 010 => -A
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b000000;
        test_opcode = 3'b010;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b000000;
        test_opcode = 3'b010;
        # 200;

        // Test 3
        test_vec1 = 6'b011111;
        test_vec2 = 6'b000000;
        test_opcode = 3'b010;
        # 200;

        // Test 4
        test_vec1 = 6'b011111;
        test_vec2 = 6'b011011;
        test_opcode = 3'b010;
        # 200;

        // Test 5
        test_vec1 = 6'b100001;
        test_vec2 = 6'b000000;
        test_opcode = 3'b010;
        # 200;

        //--------------------------
        //  ALU OPCODE 011 => -B
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011011;
        test_opcode = 3'b011;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b000000;
        test_opcode = 3'b011;
        # 200;

        // Test 3
        test_vec1 = 6'b000000;
        test_vec2 = 6'b011111;
        test_opcode = 3'b011;
        # 200;

        // Test 4
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011111;
        test_opcode = 3'b011;
        # 200;

        // Test 5
        test_vec1 = 6'b000000;
        test_vec2 = 6'b100001;
        test_opcode = 3'b011;
        # 200;

        */

        //--------------------------
        //  ALU OPCODE 100 => A<B
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011011;
        test_opcode = 3'b100;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b000000;
        test_opcode = 3'b100;
        # 200;

        // Test 3
        test_vec1 = 6'b001000;
        test_vec2 = 6'b000111;
        test_opcode = 3'b100;
        # 200;

        // Test 4
        test_vec1 = 6'b000111;
        test_vec2 = 6'b001000;
        test_opcode = 3'b100;
        # 200;

        // Test 5
        test_vec1 = 6'b011111;
        test_vec2 = 6'b100001;
        test_opcode = 3'b100;
        # 200;
        
        // Test 6
        test_vec1 = 6'b100001;
        test_vec2 = 6'b011111;
        test_opcode = 3'b100;
        # 200;
        
        // Test 7
        test_vec1 = 6'b111001;
        test_vec2 = 6'b100001;
        test_opcode = 3'b100;
        # 200;
        
        // Test 8
        test_vec1 = 6'b100001;
        test_vec2 = 6'b111001;
        test_opcode = 3'b100;
        # 200;

        /*

        //--------------------------
        //  ALU OPCODE 101 => A XNOR B
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011011;
        test_opcode = 3'b101;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b000000;
        test_opcode = 3'b101;
        # 200;

        // Test 3
        test_vec1 = 6'b111111;
        test_vec2 = 6'b000000;
        test_opcode = 3'b101;
        # 200;

        // Test 4
        test_vec1 = 6'b101010;
        test_vec2 = 6'b010101;
        test_opcode = 3'b101;
        # 200;

        //--------------------------
        //  ALU OPCODE 110 => A + B
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011011;
        test_opcode = 3'b110;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b000000;
        test_opcode = 3'b110;
        # 200;

        // Test 3
        test_vec1 = 6'b111111;
        test_vec2 = 6'b111111;
        test_opcode = 3'b110;
        # 200;

        // Test 4
        test_vec1 = 6'b100001;
        test_vec2 = 6'b100001;
        test_opcode = 3'b110;
        # 200;

        // Test 5
        test_vec1 = 6'b011111;
        test_vec2 = 6'b100001;
        test_opcode = 3'b110;
        # 200;

        //--------------------------
        //  ALU OPCODE 111 => A - B
        //--------------------------

        // Test 1
        test_vec1 = 6'b011011;
        test_vec2 = 6'b011011;
        test_opcode = 3'b111;
        # 200;

        // Test 2
        test_vec1 = 6'b000000;
        test_vec2 = 6'b000000;
        test_opcode = 3'b111;
        # 200;

        // Test 3
        test_vec1 = 6'b111111;
        test_vec2 = 6'b111111;
        test_opcode = 3'b111;
        # 200;

        // Test 4
        test_vec1 = 6'b001101;
        test_vec2 = 6'b000011;
        test_opcode = 3'b111;
        # 200;

        // Test 5
        test_vec1 = 6'b100001;
        test_vec2 = 6'b011111;
        test_opcode = 3'b111;
        # 200;

        // Test 6
        test_vec1 = 6'b011111;
        test_vec2 = 6'b100001;
        test_opcode = 3'b111;
        # 200;

        */

        // stop simulation
        $stop;
    end

endmodule
