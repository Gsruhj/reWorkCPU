module bubble(clk,rst, MEMR_ID, RT_ID, RS_IF, RT_IF, STALL );

    input clk;
    input rst;
    input MEMR_ID;
    input [4:0] RT_ID;
    input [4:0] RS_IF;
    input [4:0] RT_IF;

    output reg STALL;

    always@(posedge clk or posedge rst)
    begin
        if(MEMR_ID and (RT_ID==RS_IF or RT_ID==RT_IF) )STALL=1;
        else STALL=0;
    end




endmodule