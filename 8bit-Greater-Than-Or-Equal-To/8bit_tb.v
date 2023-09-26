
`timescale 1 ns/10 ps

module eightbit_testbench;
   // signal declaration
   reg  [7:0] test_in0, test_in1;
   wire  test_out_g, test_out_l, test_out_eq;

   // instantiate the circuit under test
   //eq2 uut (.a(test_in0), .b(test_in1), .aeqb(test_out));
   eight_bit_comp uut (.a(test_in0), .b(test_in1), .G(test_out_g), .Q(test_out_eq), .L(test_out_l));

   //  test vector generator
   initial
   begin
      // test vector 1
      test_in0 = 8'b00000000;
      test_in1 = 2'b00000000;
      # 200;
      // test vector 2
      test_in0 = 8'b00000000;
      test_in1 = 8'b00000001;
      # 200;
      // test vector 3
      test_in0 = 8'b10000000;
      test_in1 = 8'b00000000;
      # 200;
      // test vector 4
      test_in0 = 8'b00001000;
      test_in1 = 8'b00010000;
      # 200;
      // test vector 5
      test_in0 = 8'b01001000;
      test_in1 = 8'b00011000;
      # 200;
      // test vector 6
      test_in0 = 8'b00011000;
      test_in1 = 8'b00011000;
      # 200;
      // test vector 7
      test_in0 = 8'b11111111;
      test_in1 = 8'b11111111;
      # 200;
      // stop simulation
      $stop;
   end
   

endmodule