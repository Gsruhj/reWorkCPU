module byPass(clk,rst, RS_ID, RT_ID, RD_EX, RD_MEM,ForwardA,ForwardB);

    input clk;
    input rst;
    input [4:0] RS_ID;
    input [4:0] RT_ID;
    input [4:0] RD_EX;
    input [4:0] RD_MEM;

    output reg [1:0] ForwardA;
    output reg [1:0] ForwardB;
    //wire [1:0] ForwardA;
    //wire [1:0] ForwardB;

    always@(clk or rst or RS_ID or RD_MEM or RD_EX )
    begin
        if(rst)ForwardA<=0;
        else if(RD_EX!=0 and RD_EX==RS_ID)ForwardA=2'b10;
        else if(RD_MEM!=0 and RD_MEM==RS_ID)ForwardA=2'b01;
        else ForwardA=2'b00;
    end

    always@(clk or rst or RT_ID or RD_MEM or RD_EX)
    begin
        if(rst)ForwardB<=0;
        else if(RD_EX!=0 and RD_EX==RT_ID)ForwardB=2'b10;
        else if(RD_MEM!=0 and RD_MEM==RT_ID)ForwardB=2'b01;
        else ForwardB=2'b00;
    end

endmodule