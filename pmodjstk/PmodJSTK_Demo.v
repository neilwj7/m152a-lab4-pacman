`timescale 1ns / 1ps

module PmodJSTK_Demo(
    CLK,
    RST,
    MISO,
	 SW,
    SS,
    MOSI,
    SCLK,
    LED,
	 AN,
	 SEG
    );

			input CLK;					// 100Mhz onboard clock
			input RST;					// Button D
			input MISO;					// Master In Slave Out, Pin 3, Port JA
			input [2:0] SW;			// Switches 2, 1, and 0
			output SS;					// Slave Select, Pin 1, Port JA
			output MOSI;				// Master Out Slave In, Pin 2, Port JA
			output SCLK;				// Serial Clock, Pin 4, Port JA
			output [2:0] LED;			// LEDs 2, 1, and 0
			output [3:0] AN;			// Anodes for Seven Segment Display
			output [6:0] SEG;			// Cathodes for Seven Segment Display

			wire SS;						// Active low
			wire MOSI;					// Data transfer from master to slave
			wire SCLK;					// Serial clock that controls communication
			reg [2:0] LED;				// Status of PmodJSTK buttons displayed on LEDs
			wire [3:0] AN;				// Anodes for Seven Segment Display
			wire [6:0] SEG;			// Cathodes for Seven Segment Display

			// Holds data to be sent to PmodJSTK
			wire [7:0] sndData;

			// Signal to send/receive data to/from PmodJSTK
			wire sndRec;

			// Data read from PmodJSTK
			wire [39:0] jstkData;

			// Signal carrying output data that user selected
			wire [9:0] posData;



			PmodJSTK PmodJSTK_Int(
					.CLK(CLK),
					.RST(RST),
					.sndRec(sndRec),
					.DIN(sndData),
					.MISO(MISO),
					.SS(SS),
					.SCLK(SCLK),
					.MOSI(MOSI),
					.DOUT(jstkData)
			);
			


			ssdCtrl DispCtrl(
					.CLK(CLK),
					.RST(RST),
					.DIN(posData),
					.AN(AN),
					.SEG(SEG)
			);
			

			ClkDiv_5Hz genSndRec(
					.CLK(CLK),
					.RST(RST),
					.CLKOUT(sndRec)
			);
			

			// Use state of switch 0 to select output of X position or Y position data to SSD
			//assign posData = (SW[0] == 1'b1) ? {jstkData[9:8], jstkData[23:16]} : {jstkData[25:24], jstkData[39:32]};
			// reg [9:0] xData = {jstkData[9:8], jstkData[23:16]};
			// reg [9:0] yData = {jstdData[25:24], jstkData[39:32]};

			assign posDataX = {jstkData[9:8], jstkData[23:16]};
			assign posDataY = {jstkData[25:24], jstkData[39:32]};

			assign posData = (posDataY > 800) ? 10'b0000000001 :
                			 (posDataY < 200) ? 10'b0000000010 :
                			 (posDataX > 800) ? 10'b0000000011 :
                			 (posDataX < 200) ? 10'b0000000100 :
                                    			10'b0000000000 ;

			// Data to be sent to PmodJSTK, lower two bits will turn on leds on PmodJSTK
			assign sndData = {8'b100000, {SW[1], SW[2]}};

			// Assign PmodJSTK button status to LED[2:0]
			always @(sndRec or RST or jstkData) begin
					if(RST == 1'b1) begin
							LED <= 3'b000;
					end
					else begin
							LED <= {jstkData[1], {jstkData[2], jstkData[0]}};
					end
			end

endmodule
