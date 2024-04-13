//! Wavefrom "Test"  
//!{ signal: [
//!  { name: "clk",         wave: "p.....|..." },
//!  { name: "Data",        wave: "x.345x|=.x", data: ["head", "body", "tail", "data"] },
//!  { name: "Request",     wave: "0.1..0|1.0" },
//!  {},
//!  { name: "Acknowledge", wave: "1.....|01." }
//!]} 

module clk_div 
  #( parameter DIV = 5 //! Divide by
  )  
  (  input clk_in,    //! Clock input
     input resetb,    //! Use --! in VHDL 
     output clk ); 
   
   reg [5:0] cc_reg; 

   assign clk = cc_reg[DIV]; 
   
   always @(posedge clk_in)
   begin
       if (!resetb)
         cc_reg <= 0;
       else
         cc_reg <= cc_reg + 6'h01;
   end
endmodule