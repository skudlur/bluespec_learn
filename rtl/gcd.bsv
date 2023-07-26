// Greatest common divisor module

interface GCDIfc;
   method Action start(Bit#(32) a, Bit#(32) b);
   method ActionValue#(Bit#(32)) result();
endinterface

(*synthesize*)
module mkGCD (GCDIfc);
   Reg#(Bit#(32)) x <- mkReg(0);
   Reg#(Bit#(32)) y <- mkReg(0);
   FIFOF#(Bit#(32)) outQ <- mkSizeFIFOF(2);

   rule step1 ((x>y) && (y!=0));
      x<=y; y<=x;
   endrule

   rule step2 ((x<y) && (y!=0));
      y<=y-x;
      if (y-x==0) begin
         outQ.enq(x);
      end
   endrule

   method Action start(Bit#(32) a, Bit#(32) b) if (y==0);
      x <= a; y <= b;
   endmethod
   method ActionValue#(Bit#(32)) result();
      outQ.deq;
      return outQ.first;
   endmethod
endmodule
