module mkHelloWorld(Empty);

   Reg#(UInt#(4)) counter <- mkReg(10);

   rule loop (counter!=0);
      counter <= counter-1;
      $display("%05t: Hello World - loop counter = %d",$time,counter);
   endrule

   rule mark_ending (counter==0);
      $display("The End at time %05t",$time);
      $finish();
   endrule

endmodule
