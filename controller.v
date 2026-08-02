module text_controller(
    input clk,
    input [5:0] pixel_x,
    input [3:0] pixel_yu,
    output pixel_up,
    output pixel_down
);
wire [3:0]pixel_yl;
wire [5:0] char_x;
wire [3:0] char_yu;
wire [3:0] char_yl;
wire [5:0] char_xl;
wire [8:0] text_addr_u;
wire [8:0] text_addr_l;
wire [7:0] ascii_u;
wire [7:0] ascii_l;
wire [2:0] local_yu;
wire [2:0] local_yl;
wire [2:0] local_x;
wire [7:0] bitmap_u;
wire [7:0] bitmap_l;

assign pixel_yl = pixel_yu + 5'b1000;
assign char_x = pixel_x >> 3;
assign char_yu = pixel_yu >> 3;
assign char_yl = pixel_yl >> 3;
assign text_addr_u = char_yu * 8 + char_x;
assign text_addr_l = char_yl * 8 + char_x;

text_ram tr(
    .clk(clk),
    .addr_u(text_addr_u),
    .addr_l(text_addr_l),
    .data_u(ascii_u),
    .data_l(ascii_l)
);

assign local_yu = pixel_yu[2:0];
assign local_yl = pixel_yl[2:0];
assign local_x = pixel_x[2:0];


font_rom fr(
    .ascii_u(ascii_u),
    .ascii_l(ascii_l),
    .row_u(local_yu),
    .row_l(local_yl),
    .bitmap_u(bitmap_u),
    .bitmap_l(bitmap_l)
);

assign pixel_up = bitmap_u[7-local_x];
assign pixel_down=bitmap_l[7-local_x];
endmodule
