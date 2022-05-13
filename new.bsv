// sample bsv file

interface FIFO #(type element_type);
    method Action enq(element_type x1);
    method element_type first();
    method ActionValue#(any_t) dequeue() ;   
    method Action clear();
endinterface: FIFO

import FIFO::*;

// Create a module with a FIFO interface
(* synthesize *)
module squarer ( FIFO#(int) );

   FIFO#(int) inputside  <- mkFIFO ;
   FIFO#(int) outputside <- mkFIFO ;

   // a rule to move the data from in to out FIFO
   rule squarethis ;
      inputside.deq;
      let datain = inputside.first ;
      outputside.enq( datain * datain );
   endrule
 
   // methods are first-class objects and can be  
   //assigned from other methods.
   method enq = inputside.enq ;
   method deq = outputside.deq ;
   method first = outputside.first ;

   // The clear method calls both FIFO
   // clear methods
   method clear  ;
      action
         inputside.clear ;
         outputside.clear ;
      endaction
   endmethod
   
endmodule
