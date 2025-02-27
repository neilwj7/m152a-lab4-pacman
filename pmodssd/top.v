module top (
    input [3:0] sw,    // 4 switches for digit input (0-9)
    output [6:0] seg   // 7-segment output
);

    // Instantiate the display module
    display disp (
        .digit(sw),    // Use the switch values as the input
        .seg(seg)      // Connect to the 7-segment display
    );

endmodule