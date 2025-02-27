module top(
    input [3:0] sw,  // 4-bit switches for input
    output [6:0] seg1,  // 7-segment display 1 (for the first digit)
    output [6:0] seg2   // 7-segment display 2 (for the second digit)
);

    // Instantiate the display module for both digits
    display display1 (
        .digit(sw),  // The 4-bit input for the first display
        .seg(seg1)    // The 7-segment output for the first display
    );

    display display2 (
        .digit(sw),  // The 4-bit input for the second display
        .seg(seg2)    // The 7-segment output for the second display
    );

endmodule