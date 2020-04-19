module dm_4k( addr, din, DMWr, clk, dout,dread );
   
   input  [11:2] addr;
   input  [31:0] din;
   input         DMWr;
   input         clk;
   //input         dread;
   output reg  [31:0] dout;
   
   
     
   reg [31:0] dmem[1023:0];
   
   always @(posedge clk) 
   begin
      if (DMWr)
         dmem[addr] <= din;
      if(dread)dout=dmem[addr];
      $display("addr=%8X",addr);//addr to DM
      $display("din=%8X",din);//data to DM
      $display("Mem[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",dmem[0],dmem[1],dmem[2],dmem[3],dmem[4],dmem[5],dmem[6],dmem[7]);
      $display("Mem[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",dmem[8],dmem[9],dmem[10],dmem[11],dmem[12],dmem[13],dmem[14],dmem[15]);
   end // end always
          //if(dread)
   //assign dout = dmem[addr];
endmodule    
