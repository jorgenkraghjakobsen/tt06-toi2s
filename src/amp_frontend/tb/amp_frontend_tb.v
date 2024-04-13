// Test bench: Amplifier Frontend 
// Simulate:
//   Startup process 
//   Error conditon on amp (glitch/amp reset) 
// Copyright Jørgen Kragh Jakobsen, November 2021 

`define FPGA

`timescale 1ns/1ns
module amp_frontend_tb();


reg clk, reset;
reg nerror_in, nclip_in;
reg enable_input;
reg rx_in;

wire rx_gated; 
assign rx_gated = (enable_input) ? rx_in : 0 ;    

amp_frontend dut(clk,reset,rx_gated,
                nerror_in,
                nclip_in,
                i2s_bck, i2s_ws, i2s_d0, 
                i2c_sda, i2c_scl, 
                nenable_out,
                nmute_out );
initial 
begin 
    clk=0;
  forever #5 clk=~clk;     // 100 MHz
end

initial
begin
    rx_in = 0 ; 
  forever #162 rx_in = ~rx_in; 
end     

initial
begin
 $dumpfile( `DUMP_FILE_NAME );
 $dumpvars;

 reset        = 0;
 nerror_in    = 1;
 nclip_in     = 1;
 enable_input = 0;
 
 #200;
 reset=1;

 #1000000;   
 enable_input = 1;
 #1000000;
 $display("End");
 $finish;
end

endmodule 