`include "ctrl_encode_def.v"
`include "instruction_def.v"

module Ctrl(jump,RegDst,Branch,MemR,Mem2R,MemW,RegW,Alusrc,EXTOp,Aluctrl,OpCode,Funct);
    input [31:26] OpCode;//op:高6
    input [5:0] Funct;//funct:低6位
    
    output reg jump;
    output reg RegDst;
    output reg Branch;
    output reg MemR;
    output reg Mem2R;
    output reg MemW;
    output reg RegW;
    output reg Alusrc;
    output reg [1:0] EXTOp;
    output reg [4:0] Aluctrl;//这里，根据示例中ALUOp系列的定义，应该是5位。
    
    always@(OpCode or Funct)
    begin
        case(OpCode)
            `INSTR_RTYPE_OP:
                begin
                    assign Branch=0;
                    assign jump=0;
                    assign Mem2R=0;
                    assign MemR=0;
                    assign MemW=0;
                    assign Alusrc=0;
                    assign EXTOp=`EXT_ZERO;
                    assign RegDst=0;
                    case(Funct)
                        //addu
                        `INSTR_ADDU_FUNCT:
                            begin
                                assign RegW=1;
                                assign Aluctrl=`ALUOp_ADDU;
                            end
                        //ADD
                        `INSTR_ADD_FUNCT:
                            begin
                                assign RegW=1;
                                assign Aluctrl=`ALUOp_ADD;
                            end
                        //subu
                        `INSTR_SUBU_FUNCT:
                            begin
                                assign RegW=1;
                                assign Aluctrl=`ALUOp_SUBU;
                            end
                        `INSTR_SUB_FUNCT:
                            begin
                                assign RegW=1;
                                assign Aluctrl=`ALUOp_SUB;
                            end
                        default:
                            begin
                                assign RegW=0;
                                assign Alusrc=`ALUOp_NOP;
                            end
                    endcase
                end
            `INSTR_ORI_OP:
                begin
                    assign jump=0;
                    assign RegDst=1;
                    assign Branch=0;
                    assign MemR=0;
                    assign Mem2R=0;
                    assign MemW=0;
                    assign RegW=1;
                    assign Alusrc=1;
                    assign Aluctrl=`ALUOp_OR;
                    assign EXTOp=`EXT_ZERO;
                end
            `INSTR_LW_OP:
                begin
                    assign jump=0;
                    assign RegDst=1;
                    assign Branch=0;
                    assign MemR=1;
                    assign Mem2R=1;
                    assign MemW=0;
                    assign RegW=1;
                    assign Alusrc=1;
                    assign Aluctrl=`ALUOp_ADD;//这里应该是ADD
                    assign EXTOp=`EXT_SIGNED;//所以此时的拓展应该是zero拓展
                end
            `INSTR_SW_OP:
                begin
                    assign jump=0;
                    assign RegDst=1;
                    assign Branch=0;
                    assign MemR=0;
                    assign Mem2R=0;
                    assign MemW=1;
                    assign RegW=0;
                    assign Alusrc=1;
                    assign Aluctrl=`ALUOp_ADD;
                    assign EXTOp=`EXT_SIGNED;
                end
            `INSTR_BEQ_OP:
                begin
                    assign jump=0;//不确定
                    assign RegDst=0;
                    assign Branch=1;
                    assign MemR=0;
                    assign Mem2R=0;
                    assign MemW=0;
                    assign RegW=0;
                    assign Alusrc=0;
                    assign Aluctrl=`ALUOp_SUB;
                    assign EXTOp=`EXT_SIGNED;
                end
            `INSTR_LUI_OP: 
                begin 
                    assign jump=0;
                    assign RegDst=1;
                    assign Branch=0;
                    assign MemR=0;
                    assign Mem2R=0;
                    assign MemW=0;
                    assign RegW=1;
                    assign Alusrc=1;
                    assign Aluctrl=`ALUOp_SUB;
                    assign EXTOp=`EXT_SIGNED;
				    assign EXTOp = `EXT_HIGHPOS;
				    assign Aluctrl = `ALUOp_OR;
			end
        endcase
    end
endmodule