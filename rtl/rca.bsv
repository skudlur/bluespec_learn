// 32-bit adder
interface Ifc_mkFA;
   method ActionValue#(Bit#(32)) add(Bit#(32) a, Bit#(32) b, Bit#(32) c);
   method ActionValue#(Bit#(32)) carry(Bit#(32) a, Bit#(32) b, Bit#(32) c);
endinterface

(* synthesize *)
module mkFullAdder(Ifc_mkFA);
   Reg#(Bit#(32)) op1 <- mkReg(0);
   Reg#(Bit#(32)) op2 <- mkReg(0);
   Reg#(Bit#(32)) c_in <- mkReg(0);
   Reg#(Bit#(32)) out <- mkRegU();
   Reg#(Bit#(32)) c_out <- mkRegU();

   method ActionValue#(Bit#(32)) add(Bit#(32) a, Bit#(32) b, Bit#(32) c);
      op1 <= a;
      op2 <= b;
      c_in <= c;
      out <= op1 + op2 + c_in;
      return out;
   endmethod

   method ActionValue#(Bit#(32)) carry(Bit#(32) a, Bit#(32) b, Bit#(32) c);
      op1 <= a;
      op2 <= b;
      c_in <= c;
      c_out <= (op1 & op2) | (op2 & c_in) | (op1 & c_in);
      return c_out;
   endmethod
endmodule
