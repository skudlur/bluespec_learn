(*synthesize*)
module mkMux(Empty);
   Reg#(Bit#(1)) select <- mkReg(1'b0);
   Reg#(Bit#(1)) in1 <- mkReg(1'b1);
   Reg#(Bit#(1)) in2 <- mkReg(1'b0);
   Reg#(Bit#(1)) out <- mkRegU();

   function Bit#(1) mux (Bit#(1) sel, Bit#(1)op1, Bit#(1)op2);
      return (sel == 0) ? op1: op2;
   endfunction

   rule multiplex;
      out <= mux(select, in1, in2);
   endrule
endmodule
