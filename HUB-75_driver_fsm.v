module driver(
    input clk,pixel_up,pixel_down,
    output reg [5:0]pixel_count=0,
    output reg hub_clk=0,
    output reg lat=0,
    output reg oe=1,
    output reg [3:0] row_addr=0,
    output reg [2:0] rgb1=0,
    output reg [2:0] rgb2=0
);
parameter SHIFT=2'd0;//FSM states defn
parameter LATCH=2'd1;
parameter DISPLAY=2'd2;
parameter NEXTROW=2'd3;
reg [1:0] state=SHIFT;//Internal reg to count 4 states with initial state SHIFT
reg [7:0] display_count=0;//Internal reg to regulate display time of any two rows
always @(posedge clk)
begin
    case(state)
    SHIFT:
    begin
        oe<=1;
        lat<=0;           
        hub_clk <= ~hub_clk;//clockdivider by 2 for shifting pixels 
        if(hub_clk==0)
        begin
           rgb1<=(pixel_up)? 3'b111 : 3'b000;
           rgb2<=(pixel_down)? 3'b111:3'b000;
            if(pixel_count==63)
            begin
                pixel_count<=0;
                hub_clk<=0;
                state<=LATCH;
            end
            else
            begin
                pixel_count<=pixel_count+1;
            end
        end
    end
    LATCH:
    begin
        lat<=1;
        oe<=1;
        state<=DISPLAY;
    end
    DISPLAY:
    begin
        lat<=0;
        oe<=0;//output is enabled since it is active low here
        if(display_count==100)
        begin
            display_count<=0;
            state<=NEXTROW;
        end
        else
        begin
            display_count<=display_count+1;
        end
    end
    NEXTROW:
    begin
        oe<=1;
        row_addr<=row_addr+1;
        state<=SHIFT;
    end
    endcase
end
endmodule
