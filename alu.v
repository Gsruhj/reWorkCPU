`include "ctrl_encode_def.v"
module alu (A, B, ALUOp, C, Zero);
           
   input  [31:0] A, B;
   input  [4:0]  ALUOp;
   output [31:0] C;
   output        Zero;
   
   reg [31:0] C;
   assign abs_A=(A[31]==1)?~(A-1):A;
   assign abs_B=(B[31]==1)?~(B-1):B;
   always @( A or B or ALUOp ) begin
      case ( ALUOp )

         `ALUOp_ADDU: C = A + B;
         `ALUOp_SUBU: C = A - B;
         `ALUOp_ADD:  C=A+B;
         `ALUOp_SUB:  C=A-B;
         `ALUOp_OR:   C=A|B;
         `ALUOp_AND:  C=A&B;
         `ALUOp_SLT:  
            begin
               if(A[31]==1&&B[31]==1)C=(A<B)?1:0;
               else if(A[31]==0&&B[31]==1)C=0;
               else if(A[31]==1&&B[31]==0)C=1;
               else C=(abs_A<abs_B)?1:0;
            end
       
         default:   ;
      endcase
   end // end always;
   
   assign Zero = (A == B) ? 1 : 0;

endmodule
    
