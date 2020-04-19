module EX_MEM (clk, rst, EX_MEM_WR, NPC_IN,NPC_OUT,ALU_C_IN,ALU_C_OUT,ZERO_IN,ZERO_OUT,
                     jump_in,jump_out,RT_DATA_IN,INSTR_iN,INSTR_OUT,RT_DATA_OUT,reg_rd_in,reg_rd_out,Branch_IN,Branch_OUT,
                MEMR_IN,MEMR_OUT,MEMW_IN,MEMW_OUT,REGW_IN,REGW_OUT,MEM2R_IN,MEM2R_OUT,Flush);
               
   input         clk;
   input         rst;
   input         EX_MEM_WR; 
   input Flush;
   input ZERO_IN;
   input [1:0] Branch_IN;
   input [1:0] jump_in;
   input  [31:0] NPC_IN;
   input  [31:0] ALU_C_IN;
   input  [31:0] RT_DATA_IN;
   input [4:0] reg_rd_in;
   input [31:0] INSTR_iN;
   input MEMR_IN;
   input MEMW_IN;
   input REGW_IN;
   input MEM2R_IN;

  output reg   [31:0] INSTR_OUT;
  output reg ZERO_OUT;
  output reg [1:0] jump_out;
  output reg [1:0] Branch_OUT;
   output reg  [31:0] NPC_OUT;
   output reg  [31:0] ALU_C_OUT;
   output reg  [31:0] RT_DATA_OUT;
   output reg [4:0] reg_rd_out;
   output reg MEMR_OUT;
   output reg MEMW_OUT;
   output reg REGW_OUT;
   output reg MEM2R_OUT;
               
   always @(posedge clk or posedge rst) begin
      if ( rst ||Flush) 
        begin
        ZERO_OUT<=0;
        jump_out<=0;
        Branch_OUT<=0;
            NPC_OUT<= 0;
            ALU_C_OUT<= 0;
             RT_DATA_OUT<= 0;
            reg_rd_out<= 0;
            MEMR_OUT<= 0;
            MEMW_OUT<= 0;
            REGW_OUT<= 0;
            MEM2R_OUT<= 0;
            INSTR_OUT<=0;
        end
      else //if (EX_MEM_WR)
        begin
        ZERO_OUT<=ZERO_IN;
        Branch_OUT<=Branch_IN;
        jump_out<=jump_in;
            NPC_OUT<= NPC_IN;
            ALU_C_OUT<= ALU_C_IN;
             RT_DATA_OUT<= RT_DATA_IN;
            reg_rd_out<= reg_rd_in;
            MEMR_OUT<= MEMR_IN;
            MEMW_OUT<= MEMW_IN;
            REGW_OUT<= REGW_IN;
            MEM2R_OUT<= MEM2R_IN;
            INSTR_OUT<=INSTR_iN;
        end
   end // end always
      
endmodule
