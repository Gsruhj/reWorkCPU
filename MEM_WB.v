module MEM_WB (clk, rst, MEM_WB_WR, DM_ADRESS_IN,DM_ADRESS_OUT,DM_DATA_IN,DM_DATA_OUT,reg_rd_in,reg_rd_out,REGW_IN,REGW_OUT
                MEM2R_IN,MEM2R_OUT);
               
   input         clk;
   input         rst;
   input         MEM_WB_WR; 
   input  [31:0] DM_ADRESS_IN;
   input  [31:0] DM_DATA_IN;
   input  [4:0] reg_rd_in;
   input  REGW_IN;
   input  MEM2R_IN;

   output reg [31:0] DM_DATA_OUT;
   output reg [31:0] DM_ADRESS_OUT;
   output reg [4:0] reg_rd_out;
   output reg REGW_OUT;
   output reg MEM2R_OUT;

               
   always @(posedge clk or posedge rst) begin
      if ( rst ) 
        begin
            DM_ADRESS_OUT<= 0;
            DM_DATA_OUT<= 0;
            reg_rd_out<= 0;
            REGW_OUT<= 0;
            MEM2R_OUT<= 0;
        end
      else if (IRWr)
        begin
            DM_ADRESS_OUT<=DM_ADRESS_IN;
            DM_DATA_OUT<= DM_DATA_IN;
            reg_rd_out<= reg_rd_in;
            REGW_OUT<= REGW_IN;
            MEM2R_OUT<= MEM2R_IN;
        end
   end // end always
      
endmodule
