module font_rom (
    input wire [7:0] ascii_code,
    input wire [2:0] row,
    output reg [7:0] row_data
);

    always @(*) begin

        row_data = 8'b00000000;

        case(ascii_code)

            // A
            8'd65: begin
                case(row)
                    3'd0: row_data = 8'b00111100;
                    3'd1: row_data = 8'b01000010;
                    3'd2: row_data = 8'b01000010;
                    3'd3: row_data = 8'b01111110;
                    3'd4: row_data = 8'b01000010;
                    3'd5: row_data = 8'b01000010;
                    3'd6: row_data = 8'b01000010;
                    3'd7: row_data = 8'b00000000;
                endcase
            end

            // B
            8'd66: begin
                case(row)
                    3'd0: row_data = 8'b01111100;
                    3'd1: row_data = 8'b01000010;
                    3'd2: row_data = 8'b01000010;
                    3'd3: row_data = 8'b01111100;
                    3'd4: row_data = 8'b01000010;
                    3'd5: row_data = 8'b01000010;
                    3'd6: row_data = 8'b01111100;
                    3'd7: row_data = 8'b00000000;
                endcase
            end

            // C
            8'd67: begin
                case(row)
                    3'd0: row_data = 8'b00111100;
                    3'd1: row_data = 8'b01000010;
                    3'd2: row_data = 8'b01000000;
                    3'd3: row_data = 8'b01000000;
                    3'd4: row_data = 8'b01000000;
                    3'd5: row_data = 8'b01000010;
                    3'd6: row_data = 8'b00111100;
                    3'd7: row_data = 8'b00000000;
                endcase
            end

            // D
            8'd68: begin
                case(row)
                    3'd0: row_data = 8'b01111000;
                    3'd1: row_data = 8'b01000100;
                    3'd2: row_data = 8'b01000010;
                    3'd3: row_data = 8'b01000010;
                    3'd4: row_data = 8'b01000010;
                    3'd5: row_data = 8'b01000100;
                    3'd6: row_data = 8'b01111000;
                    3'd7: row_data = 8'b00000000;
                endcase
            end

            // E
            8'd69: begin
                case(row)
                    3'd0: row_data = 8'b01111110;
                    3'd1: row_data = 8'b01000000;
                    3'd2: row_data = 8'b01000000;
                    3'd3: row_data = 8'b01111100;
                    3'd4: row_data = 8'b01000000;
                    3'd5: row_data = 8'b01000000;
                    3'd6: row_data = 8'b01111110;
                    3'd7: row_data = 8'b00000000;
                endcase
            end

            // F
            8'd70: begin
                case(row)
                    3'd0: row_data = 8'b01111110;
                    3'd1: row_data = 8'b01000000;
                    3'd2: row_data = 8'b01000000;
                    3'd3: row_data = 8'b01111100;
                    3'd4: row_data = 8'b01000000;
                    3'd5: row_data = 8'b01000000;
                    3'd6: row_data = 8'b01000000;
                    3'd7: row_data = 8'b00000000;
                endcase
            end

            // SPACE
            8'd32: begin
                row_data = 8'b00000000;
            end

            default: begin
                row_data = 8'b00000000;
            end

        endcase

    end

endmodule