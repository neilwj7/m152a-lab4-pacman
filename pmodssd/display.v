module display (
    input [3:0] digit,  // 4-bit input for the digit (0-9)
    output reg [6:0] seg // 7-segment output
);

    always @(*) begin
        case (digit)
            4'd0: seg = 7'b1111110;  // Display 0
            4'd1: seg = 7'b0110000;  // Display 1
            4'd2: seg = 7'b1101101;  // Display 2
            4'd3: seg = 7'b1111001;  // Display 3
            4'd4: seg = 7'b0110011;  // Display 4
            4'd5: seg = 7'b1011011;  // Display 5
            4'd6: seg = 7'b1011111;  // Display 6
            4'd7: seg = 7'b1110000;  // Display 7
            4'd8: seg = 7'b1111111;  // Display 8
            4'd9: seg = 7'b1111011;  // Display 9
            default: seg = 7'b0000000; // Blank (for safety)
        endcase
    end

endmodule