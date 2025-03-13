`timescale 1ns / 1ps


module PmodJSTK(
			CLK,
			RST,
			sndRec,
			DIN,
			MISO,
			SS,
			SCLK,
			MOSI,
			DOUT
    );

			input CLK;
			input RST;
			input sndRec;
			input [7:0] DIN;
			input MISO;
			output SS;
			output SCLK;
			output MOSI;
			output [39:0] DOUT;

			wire SS;
			wire SCLK;
			wire MOSI;
			wire [39:0] DOUT;

			wire getByte;
			wire [7:0] sndData;
			wire [7:0] RxData;
			wire BUSY;
			
			wire iSCLK;

			spiCtrl SPI_Ctrl(
					.CLK(iSCLK),
					.RST(RST),
					.sndRec(sndRec),
					.BUSY(BUSY),
					.DIN(DIN),
					.RxData(RxData),
					.SS(SS),
					.getByte(getByte),
					.sndData(sndData),
					.DOUT(DOUT)
			);

			spiMode0 SPI_Int(
					.CLK(iSCLK),
					.RST(RST),
					.sndRec(getByte),
					.DIN(sndData),
					.MISO(MISO),
					.MOSI(MOSI),
					.SCLK(SCLK),
					.BUSY(BUSY),
					.DOUT(RxData)
			);

			ClkDiv_66_67kHz SerialClock(
					.CLK(CLK),
					.RST(RST),
					.CLKOUT(iSCLK)
			);

endmodule
