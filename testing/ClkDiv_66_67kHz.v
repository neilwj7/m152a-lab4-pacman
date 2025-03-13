`timescale 1ns / 1ps

module ClkDiv_66_67kHz(
    CLK,											// 100MHz onbaord clock
    RST,											// Reset
    CLKOUT										// New clock output
    );

	input CLK;
	input RST;
	output CLKOUT;

	reg CLKOUT = 1'b1;

	parameter cntEndVal = 10'b1011101110;
	reg [9:0] count = 10'b0000000000;


	always @(posedge CLK) begin
			if(RST == 1'b1) begin
					CLKOUT <= 1'b0;
					count <= 10'b0000000000;
			end
			else begin
					if(count == cntEndVal) begin
							CLKOUT <= ~CLKOUT;
							count <= 10'b0000000000;
					end
					else begin
							count <= count + 1'b1;
					end
			end

	end

endmodule
