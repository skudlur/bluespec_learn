package bubblesort;

import Utils :: *;

interface Ifc_sort;
   method Action put (Int #(32) x);
   method ActionValue #(Int #(32)) get;
endinterface

(*synthesize*)
module mk_bubblesort( Ifc_sort );

   // PC
   Reg#(Bit#(3)) rg_pc <- mkReg(0);

   // Counting incoming and outgoing values
   Reg#(UInt#(3)) rg_j <- mkReg(0);

   // Bool flag set to true if a swap is needed
   Reg#(Bool) rg_swapped <- mkRegU();

   // Five registers that hold the values to be sorted
   Reg#(Int#(32)) x0 <- mkRegU();
   Reg#(Int#(32)) x1 <- mkRegU();
   Reg#(Int#(32)) x2 <- mkRegU();
   Reg#(Int#(32)) x3 <- mkRegU();
   Reg#(Int#(32)) x4 <- mkRegU();

   // ----- RULES -----

   rule rl_swap_0_1 (rg_pc == 1);
      if (x0 > x1) begin
         x0 <= x1;
         x1 <= x0;
         rg_swapped <= True;
      end
      rg_pc <= 2;
   endrule

   rule rl_swap_1_2 (rg_pc == 2);
      if (x1 > x2) begin
         x1 <= x2;
         x2 <= x1;
         rg_swapped <= True;
      end
      rg_pc <= 3;
   endrule

   rule rl_swap_2_3 (rg_pc == 3);
      if (x2 > x3) begin
         x2 <= x3;
         x3 <= x2;
         rg_swapped <= True;
      end
      rg_pc <= 4;
   endrule

   rule rl_swap_3_4 (rg_pc == 4);
      if (x3 > x4) begin
         x3 <= x4;
         x4 <= x3;
         rg_swapped <= True;
      end
      rg_pc <= 5;
   endrule

   rule rl_loop_or_exit (rg_pc == 5);
      if (rg_swapped) begin
         rg_swapped <= False;
         rg_pc <= 1;
      end
      else
         rg_pc <= 6;
   endrule

   // ----- INTERFACE -----

   function Action shift (Int #(32) y);
      action
         x0 <= x1;
         x1 <= x2;
         x2 <= x3;
         x3 <= x4;
         x4 <= y;
      endaction
   endfunction

   method Action put (Int#(32) x) if (rg_pc == 0);
      shift(x);
      rg_j <= rg_j + 1;
      if (rg_j == 4) begin
         rg_pc <= 1;
         rg_swapped <= False;
      end
   endmethod

   method ActionValue#(Int#(32)) get () if ((rg_j != 0) && (rg_pc == 6));
      shift (?);
      rg_j <= rg_j - 1;
      if (rg_j == 1)
	     rg_pc <= 0;
      return x0;
   endmethod

endmodule: mk_bubblesort

endpackage: bubblesort
