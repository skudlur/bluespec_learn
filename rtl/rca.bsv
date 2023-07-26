// 32-bit ripple-carry adder

// Interface for mk_RCA
interface Ifc_mkFA;
   method ActionValue#(Bit#(33)) add(Bit#(32) a, Bit#(32) b, Bit#(1) c);
endinterface

// Full adder function
function Bit#(2) fa(Bit#(1) a, Bit#(1) b, Bit#(1) c_in);
   Bit#(1) t = a ^ b;
   Bit#(1) s = t ^ c_in;
   Bit#(1) c_out = (a & b) | (c_in & t);
   return {c_out,s};
endfunction: fa

// RCA function
function Bit#(TAdd#(x,1)) rca(Bit#(x) in_1, Bit#(x) in_2, Bit#(1) carry_in);
   Bit#(x) sum;
   Bit#(TAdd#(x,1)) c = 0;
   c[0] = carry_in;

   let valw = valueOf(x);

   for(Integer i=0; i < valw; i=i+1) begin
      let cs = fa(in_1[i], in_2[i], c[i]);
      c[i+1] = cs[1];
      sum[i] = cs[0];
   end

   return {c[valw], sum};
endfunction: rca

// Module for RCA
(* synthesize *)
module mk_RCA(Ifc_mkFA);
   Reg#(Bit#(32)) op1 <- mkReg(0);
   Reg#(Bit#(32)) op2 <- mkReg(0);
   Reg#(Bit#(1)) c_in <- mkReg(0);

   method ActionValue#(Bit#(33)) add(Bit#(32) a, Bit#(32) b, Bit#(1) c);
      op1 <= a;
      op2 <= b;
      c_in <= c;
      return rca(op1, op2, c_in);
   endmethod
endmodule
