import FIFO :: *;

// Create a module with a FIFO interface
(* synthesize *)
module squarer ( FIFO#(int) );

   FIFO#(int) inputside <- mkFIFO ;
   FIFO#(int) outputside <- mkFIFO ;

   // a rule to move the data from input to output FIFO
   rule squarethis ;
      inputside.deq;
      let datain = inputside.first ;
      outputside.enq( datain * datain );
   endrule

   // methods are first-class objects and can be assigned from other methods.
   method enq = inputside.enq ;
   method deq = outputside.deq ;
   method first = outputside.first ;

   // The clear method call both FIFO clear method
   method clear  ;
      action
         inputside.clear ;
         outputside.clear ;
      endaction
   endmethod
endmodule
