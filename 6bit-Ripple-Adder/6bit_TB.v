`timescale 1ns / 10ps

module sixbit_TB;
    //signal declaration
    reg [5:0] test_in0, test_in1;
    reg selection_in;
    wire [5:0] sum_out;
    wire c_output, overflow_out;
    
    SIXbit_ripple_adder uut (.x(test_in0), .y(test_in1), .sel(selection_in), .sum(sum_out), .overflow(overflow_out), .c_out(c_output));
    
    initial
    begin
        //test vectors
        test_in0 = 6'b000001; //input test vector X here
        test_in1 = 6'b000000; //input test vector Y here
        selection_in = 1'b0; //0 for sum, 1 for subtract
        // stop simulation
        $stop;
    end
    
endmodule