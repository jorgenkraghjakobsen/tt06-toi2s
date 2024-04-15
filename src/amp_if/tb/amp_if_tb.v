// Test bench: Amplifier Frontend 
// Simulate:
//   Startup process 
//   Error conditon on amp (glitch/amp reset) 
// Copyright Jørgen Kragh Jakobsen, November 2021 

`define FPGA

`timescale 1ns/1ns
module amp_if_tb();


reg clk, resetb;
reg enable_input;
reg rx_in;

wire rx_gated; 
assign rx_gated = (enable_input) ? rx_in : 0 ;    

amp_if dut(
  .clk(clk),
  .resetb(resetb),
  .ena(ena),
  .rx_in(rx_gated),
  .amp_i2s_bck(amp_i2s_bck),
  .amp_i2s_ws(amp_i2s_ws),
  .amp_i2s_d0(amp_i2s_d0),
  .amp_i2c_scl(amp_i2c_scl),
  .amp_i2c_sdai(amp_i2c_sdai),
  .amp_i2c_sdao(amp_i2c_sdao),
  .amp_nenable(amp_nenable),
  .amp_nmute(amp_nmute),
  .debug_out(debug_out));

  initial 
begin 
    clk=0;
  forever #29 clk=~clk;     // 17 MHz
end

initial
begin
  rx_in = 0 ; 
  forever #81 rx_in = ~rx_in; 
end     

initial
begin
 $dumpfile( `DUMP_FILE_NAME );
 $dumpvars;

 resetb        = 1;
 enable_input  = 0;
 
 #2000;
 resetb=0;

 #8000;
 resetb = 1;
 #500000;   
 enable_input = 1;
 #1000000;
 #1000000;

 $display("End");
 $finish;
end

endmodule 