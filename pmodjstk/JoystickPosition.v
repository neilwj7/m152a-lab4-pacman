`timescale 1ns / 1ps

module JoystickPosition(
    CLK_100MHz,
    RST,
    MISO,
    //SW,
    SS,
    MOSI,
    SCLK,
    DIR,
    );

    input CLK_100MHz;
    input RST;
    input MISO;
    //input [2:0] SW;
    output SS;
    output MOSI;
    output SCLK;
    // output [2:0] LED;
    // output [3:0] AN;
    // output [6:0] SEG;

    output [2:0] DIR;

    // declare wires or regs
    wire SS;
    wire MOSI;				    // master to slave
    wire SCLK;				    // controls communication
    // reg [2:0] LED;			// Status of PmodJSTK buttons displayed on LEDs
    // wire [3:0] AN;			// Anodes for Seven Segment Display
    // wire [6:0] SEG;			// Cathodes for Seven Segment Display
    wire [2:0] DIR;

    wire [9:0] posDataX;
    wire [9:0] posDataY;
    
    // Holds data to be sent to PmodJSTK
    wire [7:0] sndData;

    // Signal to send/receive data to/from PmodJSTK
    wire sndRec;

    // Data read from PmodJSTK
    wire [39:0] jstkData;

    PmodJSTK PmodJSTK_Int(
        .CLK(CLK_100MHz),
        .RST(RST),
        .sndRec(sndRec),
        .DIN(sndData),
        .MISO(MISO),
        .SS(SS),
        .SCLK(SCLK),
        .MOSI(MOSI),
        .DOUT(jstkData)
	);

    ClkDiv_5Hz genSndRec(
        .CLK(CLK_100MHz),
        .RST(RST),
        .CLKOUT(sndRec)
    );

    assign posDataX = {jstkData[9:8], jstkData[23:16]};
    assign posDataY = {jstkData[25:24], jstkData[39:32]};

    assign DIR =    (posDataY > 800) ? 3'b001 :
                    (posDataY < 200) ? 3'b010 :
                    (posDataX > 800) ? 3'b011 :
                    (posDataX < 200) ? 3'b100 : 3'b000 ;

endmodule