module text_controller(

    input wire clk,
    input wire rst_n,

    // ASCII data from Tiny Tapeout input pins
    input wire [7:0] ascii_in,

    // Character register select
    input wire [2:0] char_sel,

    // Load pulse
    input wire load,

    // Position from driver
    input wire [5:0] pixel_x,
    input wire [4:0] pixel_y,

    // Pixel outputs to driver
    output reg pixel_up,
    output reg pixel_down,

    // ASCII character currently being displayed
    output reg [7:0] ascii_out

);

    // =========================================================
    // 8 character registers
    // =========================================================

    reg [7:0] char_reg [0:7];


    // =========================================================
    // Load ASCII character
    // =========================================================

    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            char_reg[0] <= 8'd32;
            char_reg[1] <= 8'd32;
            char_reg[2] <= 8'd32;
            char_reg[3] <= 8'd32;
            char_reg[4] <= 8'd32;
            char_reg[5] <= 8'd32;
            char_reg[6] <= 8'd32;
            char_reg[7] <= 8'd32;

        end

        else if(load) begin

            case(char_sel)

                3'd0: char_reg[0] <= ascii_in;
                3'd1: char_reg[1] <= ascii_in;
                3'd2: char_reg[2] <= ascii_in;
                3'd3: char_reg[3] <= ascii_in;
                3'd4: char_reg[4] <= ascii_in;
                3'd5: char_reg[5] <= ascii_in;
                3'd6: char_reg[6] <= ascii_in;
                3'd7: char_reg[7] <= ascii_in;

            endcase

        end

    end


    // =========================================================
    // Select character according to horizontal position
    // =========================================================

    always @(*) begin

        case(pixel_x[5:3])

            3'd0: ascii_out = char_reg[0];
            3'd1: ascii_out = char_reg[1];
            3'd2: ascii_out = char_reg[2];
            3'd3: ascii_out = char_reg[3];
            3'd4: ascii_out = char_reg[4];
            3'd5: ascii_out = char_reg[5];
            3'd6: ascii_out = char_reg[6];
            3'd7: ascii_out = char_reg[7];

            default:
                ascii_out = 8'd32;

        endcase

    end


    // =========================================================
    // Font ROM instantiation
    // =========================================================

    wire [7:0] bitmap;

    fontrom u_fontrom (
        .ascii_code(ascii_out),
        .row(pixel_y[2:0]),
        .row_data(bitmap)
    );


    // =========================================================
    // Select current pixel
    // =========================================================

    always @(*) begin

        pixel_up   = bitmap[7 - pixel_x[2:0]];
        pixel_down = pixel_up;

    end

endmodule
