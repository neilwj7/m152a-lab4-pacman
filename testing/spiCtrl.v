`timescale 1ns / 1ps

module spiCtrl(
			CLK,
			RST,
			sndRec,
			BUSY,
			DIN,
			RxData,
			SS,
			getByte,
			sndData,
			DOUT
    );


			input CLK;
			input RST;
			input sndRec;
			input BUSY;
			input [7:0] DIN;
			input [7:0] RxData;
			output SS;
			output getByte;
			output [7:0] sndData;
			output [39:0] DOUT;

			reg SS = 1'b1;
			reg getByte = 1'b0;
			reg [7:0] sndData = 8'h00;
			reg [39:0] DOUT = 40'h0000000000;

			parameter [2:0] Idle = 3'd0,
								 Init = 3'd1,
								 Wait = 3'd2,
								 Check = 3'd3,
								 Done = 3'd4;
			
			reg [2:0] pState = Idle;

			reg [2:0] byteCnt = 3'd0;
			parameter byteEndVal = 3'd5;
			reg [39:0] tmpSR = 40'h0000000000;


	always @(negedge CLK) begin
			if(RST == 1'b1) begin
					SS <= 1'b1;
					getByte <= 1'b0;
					sndData <= 8'h00;
					tmpSR <= 40'h0000000000;
					DOUT <= 40'h0000000000;
					byteCnt <= 3'd0;
					pState <= Idle;
			end
			else begin
					
					case(pState)
								Idle : begin

										SS <= 1'b1;
										getByte <= 1'b0;
										sndData <= 8'h00;
										tmpSR <= 40'h0000000000;
										DOUT <= DOUT;
										byteCnt <= 3'd0;

										if(sndRec == 1'b1) begin
											pState <= Init;
										end
										else begin
											pState <= Idle;
										end
										
								end
								Init : begin
								
										SS <= 1'b0;
										getByte <= 1'b1;
										sndData <= DIN;
										tmpSR <= tmpSR;
										DOUT <= DOUT;
										
										if(BUSY == 1'b1) begin
												pState <= Wait;
												byteCnt <= byteCnt + 1'b1;
										end
										else begin
												pState <= Init;
										end
										
								end
								Wait : begin

										SS <= 1'b0;
										getByte <= 1'b0;
										sndData <= sndData;
										tmpSR <= tmpSR;
										DOUT <= DOUT;
										byteCnt <= byteCnt;

										if(BUSY == 1'b0) begin
												pState <= Check;
										end
										else begin
												pState <= Wait;
										end

								end
								Check : begin

										SS <= 1'b0;
										getByte <= 1'b0;
										sndData <= sndData;
										tmpSR <= {tmpSR[31:0], RxData};
										DOUT <= DOUT;
										byteCnt <= byteCnt;

										if(byteCnt == 3'd5) begin
												pState <= Done;
										end
										else begin
												pState <= Init;
										end
								end
								Done : begin

										SS <= 1'b1;
										getByte <= 1'b0;
										sndData <= 8'h00;
										tmpSR <= tmpSR;
										DOUT[39:0] <= tmpSR[39:0];
										byteCnt <= byteCnt;
									
										if(sndRec == 1'b0) begin
												pState <= Idle;
										end
										else begin
												pState <= Done;
										end

								end
								default : pState <= Idle;
						endcase
			end
	end

endmodule
