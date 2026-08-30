module text_controller(
    input clk,

    input [5:0] pixel_x,
    input [4:0] pixel_yu,

    input [7:0] ascii0,
    input [7:0] ascii1,
    input [7:0] ascii2,
    input [7:0] ascii3,
    input [7:0] ascii4,
    input [7:0] ascii5,
    input [7:0] ascii6,
    input [7:0] ascii7,

    output reg pixel_up,
    output reg pixel_down
);

    reg [7:0] selected_ascii;
    wire [7:0] rom_bitmap;

    // ------------------------------------------------
    // Select character according to horizontal pixel
    // ------------------------------------------------
    always @(*) begin
        case(pixel_x[5:3])
            3'd0: selected_ascii = ascii0;
            3'd1: selected_ascii = ascii1;
            3'd2: selected_ascii = ascii2;
            3'd3: selected_ascii = ascii3;
            3'd4: selected_ascii = ascii4;
            3'd5: selected_ascii = ascii5;
            3'd6: selected_ascii = ascii6;
            3'd7: selected_ascii = ascii7;
            default: selected_ascii = 8'd32; // Space character fallback
        endcase
    end

    // ------------------------------------------------
    // Instantiate Font ROM Component
    // ------------------------------------------------
    font_rom my_font_rom (
        .ascii_code (selected_ascii),
        .row_addr   (pixel_yu[2:0]),
        .bitmap     (rom_bitmap)
    );

    // ------------------------------------------------
    // Select individual bit from the ROM slice stream
    // ------------------------------------------------
    always @(*) begin
        pixel_up   = rom_bitmap[3'd7 - pixel_x[2:0]];
        pixel_down = pixel_up;
    end

endmodule
