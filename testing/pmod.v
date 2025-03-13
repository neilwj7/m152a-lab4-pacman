`timescale 1ns / 1ps

module pmod (
        input CLK,
//        input [3:0] rows,
//        output [3:0] cols,

        input RST,
        input MISO,
        //SW,
        output wire SS,
        output wire MOSI,
        output wire SCLK,
       
        output reg [2:0] LED

//        output wire [3:0] lastClicked,
       // output wire [2:0] jstkDir
    );
    wire [2:0] jstkDir;

//    KYPDDirection kpad(.Clk_100MHz(CLK), .rows(rows),
// .cols(cols), .lastClicked(lastClicked));

    JoystickPosition jstk(.CLK_100MHz(CLK), .RST(RST), .MISO(MISO), .SS(SS),
                           .MOSI(MOSI), .SCLK(SCLK), .DIR(jstkDir));
//initial begin
//    #20;
//    $display("hello");
//end
//always @(lastClicked) begin
//  $display("lastClicked: %b", lastClicked);
//end

//always @(jstkDir) begin
//  $display("kypdDir: %b", kypdDir);
//end

always @(jstkDir) begin
    if (RST == 1'b1) begin
        LED <= 3'b000;
    end else begin
        LED <= jstkDir;
    end
end
endmodule