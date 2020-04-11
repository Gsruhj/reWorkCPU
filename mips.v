module mips();
   reg clk, rst;
//C:/Users/lpdink/Desktop/code.txt
//D:/appDate/QQrefile/testCode/Project1/Test_6_Instr.txt
   initial begin
      $readmemh( "C:/Users/lpdink/Desktop/code.txt" , U_IM.imem ) ;
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
   reg [1:0] PCWr;
   
   //assign PCWr=((Branch&&Zero)==1)?1:0;

   //EXT
   wire [15:0] Imm16;
   wire [31:0] Imm32;
   wire [25:0] IMM;

   //IM
   wire [4:0] rs,rt,rd,shamt;
   wire [5:0] Op,Funct;
   wire [31:0] im_dout;
   wire [31:0] instr;
   assign instr=im_dout;
   assign Op = instr[31:26];
   assign Funct = instr[5:0];
   assign rs = instr[25:21];
   assign rt = instr[20:16];
   assign rd = instr[15:11];
   assign shamt=instr[10:6];
   assign Imm16 = instr[15:0];
   assign IMM = instr[25:0];//支持J指令。

   //RF
   //assign A3=(RegDst==1)?instr[20:16]:instr[15:11];
   wire [31:0] WD;
   //assign WD= (Mem2R==1)?dm_dout:alu_c;
   wire  [31:0] RD1;
   wire [31:0] RD2;
   wire [31:0] ra;//用于读出32号寄存器存储的PC值
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
   wire[1:0] 		jump;						//指令跳转
	wire 		RegDst;						
	wire[1:0] 		Branch;						//分支
	wire 		MemR;						//读存储器
	wire 		Mem2R;						//数据存储器到寄存器堆
	wire 		MemW;						//写数据存储器
	wire 		RegW;						//寄存器堆写入数据
	wire		Alusrc;						//运算器操作数选择
	wire [1:0]		EXTOp;						//位扩展/符号扩展选择
	wire [4:0]  Aluctrl;						//Alu运算选择


   //mips_tb U_mips_tb();
   //PC：PCWr:input,branch有效且零信号有效为1，决定分支有效。NPC：input,由EXT传来的基于原PC的分支地址。PC：output,当前指令地址，传给im以读出指令。
   assign NPC=(jump==2'b11)?ra:Imm32;
   //if(Branch==2'b01&&Zero)assign PCWr=1;
   //if(Branch==2'b10&&Zero==0)assign PCWr=1;
   //assign PCWr=(((Branch==2'b01&&Zero)||(Branch==2'b10&&Zero==0))==1)?2'b01:2'b00;
   always@(Branch or Zero or jump)begin
   if((Branch==2'b01&&Zero)||(Branch==2'b10&&Zero==0)) PCWr=2'b01;
   else if(Branch==2'b11&&(jump==2'b01||jump==2'b10)) PCWr=2'b10;
   else if(jump==2'b11)PCWr=2'b11;
   else  PCWr=2'b00;
   end
   //assign PCWr=((Branch==2'b10&&Zero==0)==1)?1:0;
   //else assign PCWr=0;
   //assign PCWr=((Branch&&Zero)==1)?1:0;
   /*
   always@(Branch or Zero)
      begin
         case (Branch)
            2'b00: if(Zero)PCWr=1;
            2'b01: if(~Zero)PCWr=1;
         default:  PCWr=0;
         endcase
      end
*/



   PC U_PC (
      .clk(clk), .rst(rst), .PCWr(PCWr), .NPC(NPC), .PC(PC),.IMM(IMM)
   ); 
   //IM
   im_4k U_IM ( 
      .addr(PC[11:2]) , .dout(im_dout)
   );
   
   //RF
   assign A3=(jump==2'b10)?5'b11111:((RegDst==1)?instr[20:16]:instr[15:11]);//如果jump决定jal可用，则直接访问寄存器32号。否则进行instr的判断。
   assign WD=(jump==2'b10)?PC+4:( (Mem2R==1)?dm_dout:alu_c);
   RF U_RF (
      .A1(rs), .A2(rt), .A3(A3), .WD(WD), .clk(clk), 
      .RFWr(RegW), .RD1(RD1), .RD2(RD2),.ra(ra)
   );

   //EXT
   assign Imm16 = instr[15:0];
   EXT U_EXT( .Imm16(Imm16), .EXTOp(EXTOp), .Imm32(Imm32) );

   //ALU
   assign alu_b = (Alusrc==1)?Imm32:RD2;
   alu U_alu (.A(RD1), .B(alu_b), .ALUOp(Aluctrl), .C(alu_c), .Zero(Zero),.shamt(shamt));
   //DM
   assign dm_addr=alu_c[11:2];
   dm_4k U_dm_4k( .addr(dm_addr), .din(RD2), .DMWr(MemW), .clk(clk), .dout(dm_dout));//,.dread(MemR) );
   //CTRL
  	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemW),.RegW(RegW),.Alusrc(Alusrc),.EXTOp(EXTOp),.Aluctrl(Aluctrl)
				,.OpCode(Op),.Funct(Funct));

            
endmodule