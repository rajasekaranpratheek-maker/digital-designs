module font_rom(
    input [7:0] ascii_code,
    input [2:0] row_addr,
    output reg [7:0] bitmap
);

    always @(*) begin
        bitmap = 8'b00000000;

        case(ascii_code)
            // A
            8'd65: begin
                case(row_addr)
                    3'd0: bitmap = 8'b00111100;
                    3'd1: bitmap = 8'b01000010;
                    3'd2: bitmap = 8'b01000010;
                    3'd3: bitmap = 8'b01111110;
                    3'd4: bitmap = 8'b01000010;
                    3'd5: bitmap = 8'b01000010;
                    3'd6: bitmap = 8'b01000010;
                    default: bitmap = 8'b00000000;
                endcase
            end

            // B
            8'd66: begin
                case(row_addr)
                    3'd0: bitmap = 8'b01111100;
                    3'd1: bitmap = 8'b01000010;
                    3'd2: bitmap = 8'b01000010;
                    3'd3: bitmap = 8'b01111100;
                    3'd4: bitmap = 8'b01000010;
                    3'd5: bitmap = 8'b01000010;
                    3'd6: bitmap = 8'b01111100;
                    default: bitmap = 8'b00000000;
                endcase
            end

            // C
            8'd67: begin
                case(row_addr)
                    3'd0: bitmap = 8'b00111100;
                    3'd1: bitmap = 8'b01000010;
                    3'd2: bitmap = 8'b01000000;
                    3'd3: bitmap = 8'b01000000;
                    3'd4: bitmap = 8'b01000000;
                    3'd5: bitmap = 8'b01000010;
                    3'd6: bitmap = 8'b00111100;
                    default: bitmap = 8'b00000000;
                endcase
            end

            // D
            8'd68: begin
                case(row_addr)
                    3'd0: bitmap = 8'b01111000;
                    3'd1: bitmap = 8'b01000100;
                    3'd2: bitmap = 8'b01000010;
                    3'd3: bitmap = 8'b01000010;
                    3'd4: bitmap = 8'b01000010;
                    3'd5: bitmap = 8'b01000100;
                    3'd6: bitmap = 8'b01111000;
                    default: bitmap = 8'b00000000;
                endcase
            end

            // E
            8'd69: begin
                case(row_addr)
                    3'd0: bitmap = 8'b01111110;
                    3'd1: bitmap = 8'b01000000;
                    3'd2: bitmap = 8'b01000000;
                    3'd3: bitmap = 8'b01111100;
                    3'd4: bitmap = 8'b01000000;
                    3'd5: bitmap = 8'b01000000;
                    3'd6: bitmap = 8'b01111110;
                    default: bitmap = 8'b00000000;
                endcase
            end

            // F
            8'd70: begin
                case(row_addr)
                    3'd0: bitmap = 8'b01111110;
                    3'd1: bitmap = 8'b01000000;
                    3'd2: bitmap = 8'b01000000;
                    3'd3: bitmap = 8'b01111100;
                    3'd4: bitmap = 8'b01000000;
                    3'd5: bitmap = 8'b01000000;
                    3'd6: bitmap = 8'b01000000;
                    default: bitmap = 8'b00000000;
                endcase
            end

            // SPACE (8'd32) & Default fallback
            default: begin
                bitmap = 8'b00000000;
            end
        endcase
    end

endmodule
