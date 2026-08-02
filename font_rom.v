module font_rom(

input [7:0] ascii_u,
input [7:0] ascii_l,

input [2:0] row_u,
input [2:0] row_l,

output reg [7:0] bitmap_u,
output reg [7:0] bitmap_l

);


//----------------------
// Upper Half
//----------------------

always @(*) begin

case(ascii_u)

8'd65:
begin
    case(row_u)
        3'd0: bitmap_u = 8'b00111100;
        3'd1: bitmap_u = 8'b01000010;
        3'd2: bitmap_u = 8'b01000010;
        3'd3: bitmap_u = 8'b01111110;
        3'd4: bitmap_u = 8'b01000010;
        3'd5: bitmap_u = 8'b01000010;
        3'd6: bitmap_u = 8'b01000010;
        default: bitmap_u = 8'b00000000;
    endcase
end

8'd66:
begin
    case(row_u)
        3'd0: bitmap_u = 8'b01111100;
        3'd1: bitmap_u = 8'b01000010;
        3'd2: bitmap_u = 8'b01000010;
        3'd3: bitmap_u = 8'b01111100;
        3'd4: bitmap_u = 8'b01000010;
        3'd5: bitmap_u = 8'b01000010;
        3'd6: bitmap_u = 8'b01111100;
        default: bitmap_u = 8'b00000000;
    endcase
end

8'd67:
begin
    case(row_u)
        3'd0: bitmap_u = 8'b00111100;
        3'd1: bitmap_u = 8'b01000010;
        3'd2: bitmap_u = 8'b01000000;
        3'd3: bitmap_u = 8'b01000000;
        3'd4: bitmap_u = 8'b01000000;
        3'd5: bitmap_u = 8'b01000010;
        3'd6: bitmap_u = 8'b00111100;
        default: bitmap_u = 8'b00000000;
    endcase
end

8'd68:
begin
    case(row_u)
        3'd0: bitmap_u = 8'b01111000;
        3'd1: bitmap_u = 8'b01000100;
        3'd2: bitmap_u = 8'b01000010;
        3'd3: bitmap_u = 8'b01000010;
        3'd4: bitmap_u = 8'b01000010;
        3'd5: bitmap_u = 8'b01000100;
        3'd6: bitmap_u = 8'b01111000;
        default: bitmap_u = 8'b00000000;
    endcase
end

8'd69:
begin
    case(row_u)
        3'd0: bitmap_u = 8'b01111110;
        3'd1: bitmap_u = 8'b01000000;
        3'd2: bitmap_u = 8'b01000000;
        3'd3: bitmap_u = 8'b01111100;
        3'd4: bitmap_u = 8'b01000000;
        3'd5: bitmap_u = 8'b01000000;
        3'd6: bitmap_u = 8'b01111110;
        default: bitmap_u = 8'b00000000;
    endcase
end

8'd70:
begin
    case(row_u)
        3'd0: bitmap_u = 8'b01111110;
        3'd1: bitmap_u = 8'b01000000;
        3'd2: bitmap_u = 8'b01000000;
        3'd3: bitmap_u = 8'b01111100;
        3'd4: bitmap_u = 8'b01000000;
        3'd5: bitmap_u = 8'b01000000;
        3'd6: bitmap_u = 8'b01000000;
        default: bitmap_u = 8'b00000000;
    endcase
end

default:
    bitmap_u = 8'b00000000;

endcase

end


//----------------------
// Lower Half
//----------------------

always @(*) begin

case(ascii_l)

8'd65:
begin
    case(row_l)
        3'd0: bitmap_l = 8'b00111100;
        3'd1: bitmap_l = 8'b01000010;
        3'd2: bitmap_l = 8'b01000010;
        3'd3: bitmap_l = 8'b01111110;
        3'd4: bitmap_l = 8'b01000010;
        3'd5: bitmap_l = 8'b01000010;
        3'd6: bitmap_l = 8'b01000010;
        default: bitmap_l = 8'b00000000;
    endcase
end

8'd66:
begin
    case(row_l)
        3'd0: bitmap_l = 8'b01111100;
        3'd1: bitmap_l = 8'b01000010;
        3'd2: bitmap_l = 8'b01000010;
        3'd3: bitmap_l = 8'b01111100;
        3'd4: bitmap_l = 8'b01000010;
        3'd5: bitmap_l = 8'b01000010;
        3'd6: bitmap_l = 8'b01111100;
        default: bitmap_l = 8'b00000000;
    endcase
end

8'd67:
begin
    case(row_l)
        3'd0: bitmap_l = 8'b00111100;
        3'd1: bitmap_l = 8'b01000010;
        3'd2: bitmap_l = 8'b01000000;
        3'd3: bitmap_l = 8'b01000000;
        3'd4: bitmap_l = 8'b01000000;
        3'd5: bitmap_l = 8'b01000010;
        3'd6: bitmap_l = 8'b00111100;
        default: bitmap_l = 8'b00000000;
    endcase
end

8'd68:
begin
    case(row_l)
        3'd0: bitmap_l = 8'b01111000;
        3'd1: bitmap_l = 8'b01000100;
        3'd2: bitmap_l = 8'b01000010;
        3'd3: bitmap_l = 8'b01000010;
        3'd4: bitmap_l = 8'b01000010;
        3'd5: bitmap_l = 8'b01000100;
        3'd6: bitmap_l = 8'b01111000;
        default: bitmap_l = 8'b00000000;
    endcase
end

8'd69:
begin
    case(row_l)
        3'd0: bitmap_l = 8'b01111110;
        3'd1: bitmap_l = 8'b01000000;
        3'd2: bitmap_l = 8'b01000000;
        3'd3: bitmap_l = 8'b01111100;
        3'd4: bitmap_l = 8'b01000000;
        3'd5: bitmap_l = 8'b01000000;
        3'd6: bitmap_l = 8'b01111110;
        default: bitmap_l = 8'b00000000;
    endcase
end

8'd70:
begin
    case(row_l)
        3'd0: bitmap_l = 8'b01111110;
        3'd1: bitmap_l = 8'b01000000;
        3'd2: bitmap_l = 8'b01000000;
        3'd3: bitmap_l = 8'b01111100;
        3'd4: bitmap_l = 8'b01000000;
        3'd5: bitmap_l = 8'b01000000;
        3'd6: bitmap_l = 8'b01000000;
        default: bitmap_l = 8'b00000000;
    endcase
end

default:
    bitmap_l = 8'b00000000;

endcase

end

endmodule
