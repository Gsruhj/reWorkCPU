module PC( clk, rst, PCWr, NPC, PC,IMM );
           
   input         clk;
   input         rst;
   input  [1:0]  PCWr;
   input  [31:0] NPC;
   input  [25:0] IMM;
   output [31:0] PC;
   
   reg [31:0] PC;
   reg [31:0] temp;
   integer i; 

   always @(posedge clk or posedge rst)
   begin
      if ( rst ) 
         PC<= 32'h0000_3000;
      PC=PC+4;   
      if ( PCWr==2'b01 ) //beq及bne
         begin
            //for(i=0;i<30;i=i+1) temp[31-i]=NPC[29-i];
            for(i=0;i<32;i=i+1)PC[i]=NPC[i];
            //temp[0]=0;temp[1]=0;

            //PC=PC+temp;
         end
      else if(PCWr==2'b10)//J及jal
         begin
            for(i=0;i<26;i=i+1) PC[i+2]=IMM[i];
            PC[0]=0;PC[1]=0;
         end
      else if(PCWr==2'b11)//jr
         begin
            for(i=0;i<32;i=i+1)PC[i]=NPC[i];
         end
   end // end always
           
endmodule
