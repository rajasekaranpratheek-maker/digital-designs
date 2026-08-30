module hub75_top (
    input clk,          // Global master clock
    input rst_n,        // Active-low master reset

    // Static ASCII inputs for your 8-character wide display line
    input [7:0] ascii0, input [7:0] ascii1, input [7:0] ascii2, input [7:0] ascii3,
    input [7:0] ascii4, input [7:0] ascii5, input [7:0] ascii6, input [7:0] ascii7,

    // Physical Outbound Pins to the HUB75 Panel
    output       HUB75_CLK,   // Gated shift register clock
    output [3:0] HUB75_ROW,   // Row address lines (A, B, C, D)
    output       HUB75_LAT,   // Latch/Strobe line (Active-High)
    output       HUB75_OE,    // Output Enable / Blanking (Active-Low)
    
    // Pixel Color Streams (Top & Bottom halves of the display panel)
    output       HUB75_R1, HUB75_G1, HUB75_B1, // Upper half pixel data
    output       HUB75_R2, HUB75_G2, HUB75_B2  // Lower half pixel data
);

    // Internal interconnect wires between controllers
    wire [5:0] w_pixel_x;
    wire [3:0] w_row_addr;
    wire       w_shift_en;
    wire       w_latch_en;
    wire       w_display_en;
    wire       w_pixel_up;
    wire       w_pixel_down;

    // -------------------------------------------------------------------------
    // 1. HUB75 Scan Timing Engine
    // -------------------------------------------------------------------------
    driver u_scan_ctrl (
        .clk           (clk),
        .rst_n         (rst_n),
        .pixel_count   (w_pixel_x),
        .row_addr      (w_row_addr),
        .shift_en      (w_shift_en),
        .latch_en      (w_latch_en),
        .display_en    (w_display_en)
    );

    // -------------------------------------------------------------------------
    // 2. Text Pixel Generator Engine
    // -------------------------------------------------------------------------
    // The scan_controller outputs row_addr (0 to 15) representing the active row.
    // We pass this directly to pixel_yu[3:0] so the text renders line-by-line.
    text_controller u_text_ctrl (
        .clk        (clk),
        .pixel_x    (w_pixel_x),
        .pixel_yu   ({1'b0, w_row_addr}), // Padded to match your 5-bit input layout
        .ascii0     (ascii0), .ascii1 (ascii1), .ascii2 (ascii2), .ascii3 (ascii3),
        .ascii4     (ascii4), .ascii5 (ascii5), .ascii6 (ascii6), .ascii7 (ascii7),
        .pixel_up   (w_pixel_up),
        .pixel_down (w_pixel_down)
    );

    // -------------------------------------------------------------------------
    // 3. Hardware Signal Routing & Phase Adjustments
    // -------------------------------------------------------------------------
    
    // Clock Gating: Only toggle the panel's clock during the actual SHIFT phase.
    // This stops junk/clashing bits from corrupting the panel shift registers.
    assign HUB75_CLK = clk & w_shift_en;

    // Route row addresses directly to physical pins
    assign HUB75_ROW = w_row_addr;

    // Standard HUB75 Latch is active-high
    assign HUB75_LAT = w_latch_en;

    // Standard HUB75 Output Enable is active-low (0 = LEDs On, 1 = LEDs Blanked)
    assign HUB75_OE  = ~w_display_en;

    // Map monochome text streams to Color Outputs (makes text display solid White)
    assign HUB75_R1  = w_pixel_up;
    assign HUB75_G1  = w_pixel_up;
    assign HUB75_B1  = w_pixel_up;

    assign HUB75_R2  = w_pixel_down;
    assign HUB75_G2  = w_pixel_down;
    assign HUB75_B2  = w_pixel_down;

endmodule
