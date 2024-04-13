/*
 * Copyright (c) 2024 Jørgen Kragh Jakobsen
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_jorgenkraghjakobsen_toi2s (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out[7:5]  = 3'b000;
  assign uio_out[7:4] = 4'b0000;
  assign uio_oe[7:4]  = 4'b0000;
 
  toi2s_tt_top tt_top_inst ( 
    .clk(clk),
    .resetb(rst_n),
    .ena(ena),

    .i2c_scl(i2c_scl),
    .i2c_sdai(i2c_sdai),
    .i2c_sdao(i2c_sdao),
    
    .amp_i2s_bck(amp_i2s_bck),
    .amp_i2s_ws(amp_i2s_ws),
    .amp_i2s_d0(amp_i2s_d0),
    
    .amp_i2c_scl(amp_i2c_scl),        // amp i2c clk control  (master ->  amp (slave))
    .amp_i2c_sdai(amp_i2c_sdai),      // amp i2c data control (master)
    .amp_i2c_sdao(amp_i2c_sdao),      // amp i2c data control (master)
    
    .amp_nenable(amp_nenable),        // amp nenable
    .amp_mute(amp_mute),              // amp mute      

    .pwm_out(pwm_out),
    .rx_in(rx_in) 
    ); 


    assign 
 


  // spdif_decoder spdif_decoder(
  //   .clk_in(clk),
  //   .resetb(rst_n),
  //   .rx_in(ui_in[0]),
  //   .i2s_bck(uo_out[0]),
  //   .i2s_ws(uo_out[1]),
  //   .i2s_d0(uo_out[2]),
  //   .audio_locked(audio_locked),
  //   .edgedetect(edge_detect));
  
    // Dedicated input 
  assign rx_in      = ui_in[0];   
 
  
  // Dedicated outputs 

  assign uo_out[0] = amp_nenable1;    // nenable
  assign uo_out[1] = amp_mute;    // mute 
  assign uo_out[2] = amp_i2s_bck;    // i2s_bck 
  assign uo_out[3] = amp_i2s_ws;    // i2s_ws
  assign uo_out[4] = amp_i2s_d0;    // i2s_d0
  assign uo_out[5] = 1'b0;    // free 
  assign uo_out[6] = 1'b0;    // free 
  assign uo_out[7] = pwm_out; // 

  // Bidirectional input / output 

  assign amp_i2c_sdai = uio_in[3]; 
  assign uio_oe[3]  = (amp_i2c_sdao == 1'b0) ? 1'b1 : 1'b0;
  assign uio_out[3] = amp_i2c_sdao; 
  
  //assign amp_i2c_scl= uio_in[2];
  assign uio_oe[2]  = 1'b1;
  assign uio_out[2] = amp_i2c_scl; 


  assign i2c_sdai   = uio_in[1];
  assign uio_oe[1]  = (i2c_sdao == 1'b0) ? 1'b1 : 1'b0;
  assign uio_out[1] = i2c_sdao; 

  assign i2c_scl    = uio_in[0];
  assign uio_oe[0]  = 1'b0;
  assign uio_out[0] = 1'b0; 
endmodule
