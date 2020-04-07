module PC( clk, rst, PCWr, NPC, PC );
           
   input         clk;
   input         rst;
   input         PCWr;
   input  [31:0] NPC;
   output [31:0] PC;
   
   reg [31:0] PC;
   reg [31:0] temp;
   integer i; 

   always @(posedge clk or posedge rst)
   begin
      if ( rst ) 
         PC<= 32'h0000_3000;
      PC=PC+4;   
      if ( PCWr ) 
         begin
            for(i=0;i<30;i=i+1) temp[31-i]=NPC[29-i];

            temp[0]=0;temp[1]=0;

            PC=PC+temp;
         end
   end // end always
           
endmodule
