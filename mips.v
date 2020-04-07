module mips();
   reg clk, rst;

   initial begin
      $readmemh( "D:/appDate/QQrefile/testCode/signal6/Test_6_Instr.txt" , U_IM.imem ) ;
      $monitor("PC = 0x%8X, IR = 0x%8X", U_PC.PC, instr ); 
      clk = 1 ;
      rst = 0 ;
      #5 ;
      rst = 1 ;
      #20 ;
      rst = 0 ;
   end
   
   always
	   #(50) clk = ~clk;
   //PC
   wire [31:0] NPC;
   wire [31:0] PC;
   wire PCWr;
   //assign PCWr=((Branch&&Zero)==1)?1:0;

   //EXT
   wire [15:0] Imm16;
   wire [31:0] Imm32;

   //IM
   wire [4:0] rs,rt,rd;
   wire [5:0] Op,Funct;
   wire [31:0] im_dout;
   wire [31:0] instr;
   assign instr=im_dout;
   assign Op = instr[31:26];
   assign Funct = instr[5:0];
   assign rs = instr[25:21];
   assign rt = instr[20:16];
   assign rd = instr[15:11];
   assign Imm16 = instr[15:0];
  // assign IMM = instr[25:0];

   //RF
   //assign A3=(RegDst==1)?instr[20:16]:instr[15:11];
   wire [31:0] WD;
   //assign WD= (Mem2R==1)?dm_dout:alu_c;
   wire  [31:0] RD1;
   wire [31:0] RD2;
   wire [4:0] A3;

   //ALU
   wire Zero;
   wire [31:0] alu_c;
   wire [31:0] alu_b;
   //assign alu_b = (Alusrc==1)?Imm32:RD2;
   //DM
   wire [31:0] dm_dout;
   wire [9:0] dm_addr;
   //assign dm_addr=alu_c[11:2];
   //CTRL
   wire 		jump;						//指令跳转
	wire 		RegDst;						
	wire 		Branch;						//分支
	wire 		MemR;						//读存储器
	wire 		Mem2R;						//数据存储器到寄存器堆
	wire 		MemW;						//写数据存储器
	wire 		RegW;						//寄存器堆写入数据
	wire		Alusrc;						//运算器操作数选择
	wire [1:0]		EXTOp;						//位扩展/符号扩展选择
	wire [4:0]  Aluctrl;						//Alu运算选择


   //mips_tb U_mips_tb();
   //PC：PCWr:input,branch有效且零信号有效为1，决定分支有效。NPC：input,由EXT传来的基于原PC的分支地址。PC：output,当前指令地址，传给im以读出指令。
   assign NPC=Imm32;
   assign PCWr=((Branch&&Zero)==1)?1:0;
   PC U_PC (
      .clk(clk), .rst(rst), .PCWr(PCWr), .NPC(NPC), .PC(PC)
   ); 
   //IM
   im_4k U_IM ( 
      .addr(PC[11:2]) , .dout(im_dout)
   );
   
   //RF
   assign A3=(RegDst==1)?instr[20:16]:instr[15:11];
   assign WD= (Mem2R==1)?dm_dout:alu_c;
   RF U_RF (
      .A1(rs), .A2(rt), .A3(A3), .WD(WD), .clk(clk), 
      .RFWr(RegW), .RD1(RD1), .RD2(RD2)
   );

   //EXT
   assign Imm16 = instr[15:0];
   EXT U_EXT( .Imm16(Imm16), .EXTOp(EXTOp), .Imm32(Imm32) );

   //ALU
   assign alu_b = (Alusrc==1)?Imm32:RD2;
   alu U_alu (.A(RD1), .B(alu_b), .ALUOp(Aluctrl), .C(alu_c), .Zero(Zero));
   //DM
   assign dm_addr=alu_c[11:2];
   dm_4k U_dm_4k( .addr(dm_addr), .din(RD2), .DMWr(MemW), .clk(clk), .dout(dm_dout),.dread(MemR) );
   //CTRL
  	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemW),.RegW(RegW),.Alusrc(Alusrc),.EXTOp(EXTOp),.Aluctrl(Aluctrl)
				,.OpCode(Op),.Funct(Funct));

            
endmodule