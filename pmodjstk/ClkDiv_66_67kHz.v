`timescale 1ns / 1ps

module ClkDiv_66_67kHz(
    CLK,											// 100MHz onbaord clock
    RST,											// Reset
    CLKOUT										// New clock output
    );

	input CLK;
	input RST;
	output CLKOUT;

	// Output register
	reg CLKOUT = 1'b1;

	// Value to toggle output clock at
	parameter cntEndVal = 10'b1011101110;
	// Current count
	reg [9:0] clkCount = 10'b0000000000;


	always @(posedge CLK) begin

			// Reset clock
			if(RST == 1'b1) begin
					CLKOUT <= 1'b0;
					clkCount <= 10'b0000000000;
			end
			// Count/toggle normally
			else begin

					if(clkCount == cntEndVal) begin
							CLKOUT <= ~CLKOUT;
							clkCount <= 10'b0000000000;
					end
					else begin
							clkCount <= clkCount + 1'b1;
					end

			end

	end

endmodule
