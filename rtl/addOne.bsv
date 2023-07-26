(*synthesize*)
module mkModule(Empty);
  Reg#(Bit#(8)) in;
  Reg#(Bit#(8)) out;

  function Bit#(8) addOne(Bit#(8) x);
    return x + 1;
  endfunction

  rule process;
    out <= addOne(in);
  endrule
endmodule
