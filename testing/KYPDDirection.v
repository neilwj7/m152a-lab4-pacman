`timescale 1ns / 1ps

module KYPDDirection (
        input Clk_100MHz,
        input [3:0] rows,
        output [3:0] cols,
        output [3:0] lastClicked,
    );

    wire [3:0] lastClicked;

    decoder d(.clk_100MHz(clk_100MHz), .row(rows),
			.col(cols), .dec_out(lastClicked));

endmodule