module driver(
    input clk,
    input rst_n, // Renamed to rst_n to standardise active-low naming

    output reg [5:0] pixel_count,
    output reg [3:0] row_addr,

    output reg shift_en,
    output reg latch_en,
    output reg display_en
);

    reg [6:0] display_count;

    // Fixed-width binary states
    localparam SHIFT   = 2'd0;
    localparam LATCH   = 2'd1;
    localparam DISPLAY = 2'd2;

    reg [1:0] state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state         <= SHIFT;
            pixel_count   <= 6'd0;
            row_addr      <= 4'd0;
            display_count <= 7'd0;
        end
        else begin
            case(state)
                SHIFT: begin
                    // Count up to 63 to clock exactly 64 pixels
                    if(pixel_count == 6'd63) begin
                        pixel_count <= 6'd0;
                        state       <= LATCH; 
                    end
                    else begin
                        pixel_count <= pixel_count + 1'b1;
                    end
                end

                LATCH: begin
                    // Holds latch_en high for exactly 1 clock cycle
                    state         <= DISPLAY;
                    display_count <= 7'd0;
                end

                DISPLAY: begin
                    if(display_count == 7'd100) begin
                        display_count <= 7'd0;
                        // Safely increment row address while display is blanked next cycle
                        if(row_addr == 4'd15)
                            row_addr <= 4'd0;
                        else
                            row_addr <= row_addr + 1'b1;
                        
                        state <= SHIFT;
                    end
                    else begin
                        display_count <= display_count + 1'b1;
                    end
                end
                
                default: state <= SHIFT;
            endcase
        end
    end

    // Combinational Output Assignments
    always @(*) begin
        shift_en   = 1'b0;
        latch_en   = 1'b0;
        display_en = 1'b0;

        case(state)
            SHIFT: begin
                shift_en   = 1'b1;
            end
            LATCH: begin
                latch_en   = 1'b1; // Pulled high for 1 cycle after shifting ends
            end
            DISPLAY: begin
                display_en = 1'b1; // Turn on display only during this window
            end
        endcase
    end

endmodule
