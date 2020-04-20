module byPass(clk,rst, RD_EX, RS_ID, RT_ID_A3,RT_ID, RD_MEM,ForwardA,ForwardB,Alusrc,rt,instr_if,ForwardC);

    input clk;
    input rst;
    input Alusrc;
    input [4:0] RS_ID;
    input [4:0] RT_ID_A3;
    input [4:0] RT_ID;
    input [4:0] RD_EX;
    input [4:0] RD_MEM;
    input [4:0] rt;//用于支持sw转发。
    input [31:0] instr_if;

    output reg [1:0] ForwardA;
    output reg [1:0] ForwardB;
    output reg ForwardC;
    assign myoutofRS_ID=RS_ID;
    //wire [1:0] ForwardA;
    //wire [1:0] ForwardB;

    //always@(posedge clk)
    always@(*)
    begin
        if(rst)ForwardA<=0;
        else if(RD_EX==RS_ID)
        begin
            if(RD_EX==0)ForwardA=2'b00;
            else ForwardA=2'b10;
        end
        else if(RD_MEM==RS_ID)
        begin
            if(RD_MEM==0)ForwardA=2'b00;
            else ForwardA=2'b01;
        end
        else ForwardA=2'b00;
        if(rst)ForwardC=0;
        if(RT_ID_A3==rt && instr_if[31:26]==6'b101011) ForwardC=1;
        //if(RT_ID==rt) ForwardC=1;
        else ForwardC=0;
    end

    //always@(posedge clk)
    always@(*)
    begin
        if(rst)ForwardB<=0;
        else if(RD_EX==RT_ID)
        begin
            if(RD_EX==0)ForwardB=2'b00;
            else ForwardB=2'b10;
        end
        else if(RD_MEM==RT_ID)
        begin
            if (RD_MEM==0)ForwardB=2'b00;
            else ForwardB=2'b01;
        end
        else ForwardB=2'b00;
        if(Alusrc==1)ForwardB=2'b00;
    end

endmodule