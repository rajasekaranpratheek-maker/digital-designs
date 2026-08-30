module hub75_top (

    input clk,
    input rst_n,

    // 8 character ASCII inputs
    input [7:0] ascii0,
    input [7:0] ascii1,
    input [7:0] ascii2,
    input [7:0] ascii3,
    input [7:0] ascii4,
    input [7:0] ascii5,
    input [7:0] ascii6,
    input [7:0] ascii7,

    // HUB75 outputs
    output HUB75_CLK,
    output [3:0] HUB75_ROW,
    output HUB75_LAT,
    output HUB75_OE,

    output HUB75_R1,
    output HUB75_G1,
    output HUB75_B1,

    output HUB75_R2,
    output HUB75_G2,
    output HUB75_B2

);


    // =========================================================
    // Driver signals
    // =========================================================

    wire [5:0] w_pixel_x;
    wire [3:0] w_row_addr;

    wire w_shift_en;
    wire w_latch_en;
    wire w_display_en;


    // =========================================================
    // Text controller signals
    // =========================================================

    wire w_pixel_up;
    wire w_pixel_down;

    reg [7:0] w_ascii_in;
    reg [2:0] w_char_sel;
    reg w_load;


    // =========================================================
    // Character loading counter
    // =========================================================

    reg [3:0] load_count;


    always @(posedge clk or negedge rst_n) begin

        if(!rst_n) begin

            load_count <= 4'd0;

        end

        else begin

            if(load_count == 4'd7)
                load_count <= 4'd0;
            else
                load_count <= load_count + 1'b1;

        end

    end


    // =========================================================
    // Select which ASCII character to load
    // =========================================================

    always @(*) begin

        w_load = 1'b1;

        case(load_count)

            4'd0: w_ascii_in = ascii0;
            4'd1: w_ascii_in = ascii1;
            4'd2: w_ascii_in = ascii2;
            4'd3: w_ascii_in = ascii3;
            4'd4: w_ascii_in = ascii4;
            4'd5: w_ascii_in = ascii5;
            4'd6: w_ascii_in = ascii6;
            4'd7: w_ascii_in = ascii7;

            default: w_ascii_in = 8'd32;

        endcase


        if(load_count <= 4'd7)
            w_char_sel = load_count[2:0];
        else
            w_char_sel = 3'd0;

    end


    // =========================================================
    // HUB75 scan timing engine
    // =========================================================

    driver u_scan_ctrl (

        .clk         (clk),
        .rst_n       (rst_n),

        .pixel_count (w_pixel_x),
        .row_addr    (w_row_addr),

        .shift_en    (w_shift_en),
        .latch_en    (w_latch_en),
        .display_en  (w_display_en)

    );


    // =========================================================
    // Text pixel generator
    // =========================================================

    text_controller tc (

        .clk       (clk),
        .rst_n     (rst_n),

        .ascii_in  (w_ascii_in),
        .char_sel  (w_char_sel),
        .load      (w_load),

        .pixel_x   (w_pixel_x),

        .pixel_y   ({1'b0, w_row_addr}),

        .pixel_up  (w_pixel_up),
        .pixel_down(w_pixel_down),

        .ascii_out ()

    );


    // =========================================================
    // HUB75 connections
    // =========================================================

    assign HUB75_CLK = clk & w_shift_en;

    assign HUB75_ROW = w_row_addr;

    assign HUB75_LAT = w_latch_en;

    assign HUB75_OE = ~w_display_en;


    // =========================================================
    // Monochrome → RGB
    // =========================================================

    assign HUB75_R1 = w_pixel_up;
    assign HUB75_G1 = w_pixel_up;
    assign HUB75_B1 = w_pixel_up;

    assign HUB75_R2 = w_pixel_down;
    assign HUB75_G2 = w_pixel_down;
    assign HUB75_B2 = w_pixel_down;


endmodule