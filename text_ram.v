module text_ram(

    input clk,

    input [8:0] addr_u,
    input [8:0] addr_l,

    output reg [7:0] data_u,
    output reg [7:0] data_l

);

reg [7:0] mem [0:31];

integer i;

initial begin

    for(i=0;i<32;i=i+1)
        mem[i]=8'd0;

    mem[0]=8'd65;    // A
    mem[1]=8'd66;    // B
    mem[2]=8'd67;    // C
    mem[3]=8'd68;    // D
    mem[4]=8'd69;    // E
    mem[5]=8'd70;    // F

end

always @(*) begin

    data_u = mem[addr_u];
    data_l = mem[addr_l];

end

endmodule
