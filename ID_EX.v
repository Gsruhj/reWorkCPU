module ID_EX (clk, rst, ID_EX_WR,PC_PLUS4_IN,PC_PLUS4_OUT,INSTR_iN,INSTR_OUT,RD1_IN,RD1_OUT,RD2_IN,RD2_OUT,EXT_IN,EXT_OUT,reg_rd_in,reg_rd_out,
            jump_in,jump_out,RegDst_in,RegDst_out,Branch_in,Branch_OUT,MemR_in,MemR_out,Mem2R_in,Mem2R_out,MemW_in,MemW_out,RegW_in,RegW_out,
            Alusrc_in,Alusrc_out,EXTOp_in,EXTOp_out,Aluctrl_in,Aluctrl_out,STALL);
               
   input         clk;
   input         rst;
   input         ID_EX_WR; 
   input [31:0] PC_PLUS4_IN;
   input [31:0] INSTR_iN;
   input [31:0] RD1_IN;
   input [31:0] RD2_IN;
   input [31:0] EXT_IN;
   input [4:0] reg_rd_in;
   input [1:0] jump_in;
   input RegDst_in;
   input [1:0] Branch_in;
   input MemR_in;
   input Mem2R_in;
   input MemW_in;
   input RegW_in;
   input Alusrc_in;
   input [1:0] EXTOp_in;
   input [4:0] Aluctrl_in;
   input STALL;

    output reg [31:0] PC_PLUS4_OUT;
    output reg [31:0] INSTR_OUT;
    output reg [31:0] RD1_OUT;
    output reg [31:0] RD2_OUT;
    output reg [31:0] EXT_OUT;
    output reg [4:0] reg_rd_out;
    output reg [1:0] jump_out;
    output reg RegDst_out;
    output reg [1:0] Branch_OUT;
    output reg MemR_out;
    output reg Mem2R_out;
    output reg MemW_out;
    output reg RegW_out;
    output reg Alusrc_out;
    output reg [1:0] EXTOp_out;
    output reg [4:0] Aluctrl_out;
               
   always @(posedge clk or posedge rst) begin
      if ( rst ) 
        begin
         PC_PLUS4_OUT <= 0;
         INSTR_OUT<= 0;
         RD1_OUT<= 0;
         RD2_OUT<= 0;
         EXT_OUT<=0;
         reg_rd_out<= 0;
         jump_out<= 0;
         RegDst_out<= 0;
         Branch_OUT<= 0;
         MemR_out<= 0;
         Mem2R_out<= 0;
         MemW_out<= 0;
         RegW_out<= 0;
         Alusrc_out<= 0;
         EXTOp_out<= 0;
         Alusrc_out<= 0;
        end
      else if(STALL)
        begin
         jump_out<= 0;
         RegDst_out<= 0;
         Branch_OUT<= 0;
         MemR_out<= 0;
         Mem2R_out<= 0;
         MemW_out<= 0;
         RegW_out<= 0;
         Alusrc_out<= 0;
         EXTOp_out<= 0;
         Alusrc_out<= 0;
        end
      else //if (ID_EX_WR)
        begin
         PC_PLUS4_OUT <= PC_PLUS4_IN;
         INSTR_OUT<= INSTR_iN;
         RD1_OUT<= RD1_IN;
         RD2_OUT<= RD2_IN;
         EXT_OUT<=EXT_IN;
         reg_rd_out<= reg_rd_in;
         jump_out<= jump_in;
         RegDst_out<= RegDst_in;
         Branch_OUT<= Branch_in;
         MemR_out<= MemR_in;
         Mem2R_out<= Mem2R_in;
         MemW_out<= MemW_in;
         RegW_out<= RegW_in;
         Alusrc_out<= Alusrc_in;
         EXTOp_out<= EXTOp_in;
         Aluctrl_out<= Aluctrl_in;
        end
   end // end always
      
endmodule
