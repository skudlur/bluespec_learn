// Interface for mk_FA
interface Ifc_mkFA;
   method Bit#(33) add(Bit#(32) a, Bit#(32) b, Bit#(1) c);
endinterface

function Bit#(33) fn_adder_with_carry (Bit#(32) op_1, Bit#(32) op_2, Bit#(1) carry);
  return zeroExtend(op_1 + op_2 + zeroExtend(carry));
endfunction

(*synthesize*)
module mk_FA (Ifc_mkFA);
   method Bit#(33) add(Bit#(32) a, Bit#(32) b, Bit#(1) c);
      return fn_adder_with_carry(a,b,c);
   endmethod
endmodule
