module IF_ID (clk, rst, IF_ID_WR, PC_PLUS4_IN,PC_PLUS4_OUT, INSTR_IN,INSTR_OUT,Flush);
               
   input         clk;
   input         rst;
   input         IF_ID_WR; 
   input         Flush;
   input  [31:0] PC_PLUS4_IN;
   input  [31:0] INSTR_IN;
   output reg [31:0] PC_PLUS4_OUT;
   output reg [31:0] INSTR_OUT;
   

               
   always @(posedge clk or posedge rst)
    begin
      if ( rst )
        begin
            PC_PLUS4_OUT<=0;
            INSTR_OUT<= 0;
        end
      else if(Flush)INSTR_OUT<=0;
      else //if (IF_ID_WR)
        begin
            PC_PLUS4_OUT <= PC_PLUS4_IN;
            INSTR_OUT<=INSTR_IN;
        end
   end // end always
      
endmodule