`timescale 1ns / 1ps

module decoder(
    input clk_100MHz,
    input [3:0] row,
    output reg [3:0] col,
    output reg [3:0] dec_out
    );

    parameter LAG = 10;

	reg [19:0] scan_timer = 0;
	reg [1:0] col_select = 0;
	
	always @(posedge clk_100MHz)
		if(scan_timer == 99_999) begin
			scan_timer <= 0;
			col_select <= col_select + 1;
		end
		else
			scan_timer <= scan_timer + 1;
			
	always @(posedge clk_100MHz)
		case(col_select)
			2'b00 :	begin
					   col = 4'b0111;
					   if(scan_timer == LAG)
						  case(row)
						      4'b0111 :	dec_out = 4'b0001;	// 1
						      4'b1011 :	dec_out = 4'b0100;	// 4
						      4'b1101 :	dec_out = 4'b0111;	// 7
						      4'b1110 :	dec_out = 4'b0000;	// 0
						  endcase
					end
			2'b01 :	begin
					   col = 4'b1011;
					   if(scan_timer == LAG)
						  case(row)    		
						      4'b0111 :	dec_out = 4'b0010;	// 2	
						      4'b1011 :	dec_out = 4'b0101;	// 5	
						      4'b1101 :	dec_out = 4'b1000;	// 8	
					          4'b1110 : dec_out = 4'b1111;	// F
			              endcase
			        end 
			2'b10 :	begin       
					   col = 4'b1101;
					   if(scan_timer == LAG)
						  case(row)    		       
						      4'b0111 :	dec_out = 4'b0011;	// 3 		
						      4'b1011 :	dec_out = 4'b0110;	// 6 		
						      4'b1101 :	dec_out = 4'b1001;	// 9 		
						      4'b1110 : dec_out = 4'b1110;	// E	    
						  endcase      
					end
			2'b11 :	begin
					   col = 4'b1110;
					   if(scan_timer == LAG)
						  case(row)    
						      4'b0111 :	dec_out = 4'b1010;	// A
						      4'b1011 :	dec_out = 4'b1011;	// B
						      4'b1101 :	dec_out = 4'b1100;	// C
						      4'b1110 :	dec_out = 4'b1101;	// D
						  endcase      
					end
		endcase

endmodule