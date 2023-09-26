module clock(input CCLK, input [31:0] clkscale, output reg clk);

reg [31:0] clkq = 0;			// clock register, initial value of 0
	
always@(posedge CCLK)
	begin
		clkq=clkq+1;			// increment clock register with every posedge of CCLK
			if (clkq>=clkscale)  	// when clock reg is greater/equal
				begin
					clk=~clk;	// Toggle output clk
					clkq=0;		// reset the clock register
				end
	 end

endmodule