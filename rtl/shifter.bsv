interface Ifc_shift;
   method Action shift(Bit#(1) dir, Bit#(4) num);
endinterface

(*synthesize*)
module mkShifter( Ifc_shift );
   Reg#(Bit#(4)) data <- mkReg(4'b0110);  // Set data inside the shifter
   Reg#(Bit#(1)) s_dir <- mkRegU();   // Direction of shifting 0 -> left & 1 -> right
   Reg#(Bit#(4)) s_num <- mkRegU();   // Number of shifts to be done

   method Action shift(Bit#(1) dir, Bit#(4) num);
      s_dir <= dir;
      s_num <= num;
      data <= (s_dir == 1'b0) ? (data << s_num) : (data >> s_num);
   endmethod
endmodule
