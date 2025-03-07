`timescale 1ns / 1ps


module spiMode0(
    CLK,
    RST,
    sndRec,
    DIN,
    MISO,
    MOSI,
    SCLK,
	 BUSY,
    DOUT
    );


			input CLK;						// 66.67kHz serial clock
			input RST;						// Reset
			input sndRec;					// Send receive, initializes data read/write
			input [7:0] DIN;				// Byte that is to be sent to the slave
			input MISO;						// Master input slave output
			output MOSI;					// Master out slave in
			output SCLK;					// Serial clock
			output BUSY;					// Busy if sending/receiving data
			output [7:0] DOUT;			// Current data byte read from the slave

			wire MOSI;
			wire SCLK;
			wire [7:0] DOUT;
			reg BUSY;

			// FSM States
			parameter [1:0] Idle = 2'd0,
								 Init = 2'd1,
								 RxTx = 2'd2,
								 Done = 2'd3;

			reg [4:0] bitCount;							// Number bits read/written
			reg [7:0] rSR = 8'h00;						// Read shift register
			reg [7:0] wSR = 8'h00;						// Write shift register
			reg [1:0] pState = Idle;					// Present state

			reg CE = 0;										// Clock enable, controls serial
																// clock signal sent to slave


			// Serial clock output, allow if clock enable asserted
			assign SCLK = (CE == 1'b1) ? CLK : 1'b0;
			// Master out slave in, value always stored in MSB of write shift register
			assign MOSI = wSR[7];
			// Connect data output bus to read shift register
			assign DOUT = rSR;

			always @(negedge CLK) begin
					if(RST == 1'b1) begin
							wSR <= 8'h00;
					end
					else begin
							// Enable shift during RxTx state only
							case(pState)
									Idle : begin
											wSR <= DIN;
									end
									
									Init : begin
											wSR <= wSR;
									end
									
									RxTx : begin
											if(CE == 1'b1) begin
													wSR <= {wSR[6:0], 1'b0};
											end
									end
									
									Done : begin
											wSR <= wSR;
									end
							endcase
					end
			end



			always @(posedge CLK) begin
					if(RST == 1'b1) begin
							rSR <= 8'h00;
					end
					else begin
							// Enable shift during RxTx state only
							case(pState)
									Idle : begin
											rSR <= rSR;
									end
									
									Init : begin
											rSR <= rSR;
									end
									
									RxTx : begin
											if(CE == 1'b1) begin
													rSR <= {rSR[6:0], MISO};
											end
									end
									
									Done : begin
											rSR <= rSR;
									end
							endcase
					end
			end



			always @(negedge CLK) begin
			
					// Reset button pressed
					if(RST == 1'b1) begin
							CE <= 1'b0;				// Disable serial clock
							BUSY <= 1'b0;			// Not busy in Idle state
							bitCount <= 4'h0;		// Clear #bits read/written
							pState <= Idle;		// Go back to Idle state
					end
					else begin
							
							case (pState)
							
								// Idle
								Idle : begin

										CE <= 1'b0;				// Disable serial clock
										BUSY <= 1'b0;			// Not busy in Idle state
										bitCount <= 4'd0;		// Clear #bits read/written
										

										// When send receive signal received begin data transmission
										if(sndRec == 1'b1) begin
											pState <= Init;
										end
										else begin
											pState <= Idle;
										end
										
								end

								// Init
								Init : begin
								
										BUSY <= 1'b1;			// Output a busy signal
										bitCount <= 4'h0;		// Have not read/written anything yet
										CE <= 1'b0;				// Disable serial clock
										
										pState <= RxTx;		// Next state receive transmit
										
								end

								// RxTx
								RxTx : begin

										BUSY <= 1'b1;						// Output busy signal
										bitCount <= bitCount + 1'b1;	// Begin counting bits received/written
										
										// Have written all bits to slave so prevent another falling edge
										if(bitCount >= 4'd8) begin
												CE <= 1'b0;
										end
										// Have not written all data, normal operation
										else begin
												CE <= 1'b1;
										end
										
										// Read last bit so data transmission is finished
										if(bitCount == 4'd8) begin
												pState <= Done;
										end
										// Data transmission is not finished
										else begin
												pState <= RxTx;
										end

								end

								// Done
								Done : begin

										CE <= 1'b0;			// Disable serial clock
										BUSY <= 1'b1;		// Still busy
										bitCount <= 4'd0;	// Clear #bits read/written
										
										pState <= Idle;

								end

								// Default State
								default : pState <= Idle;
								
							endcase
					end
			end

endmodule