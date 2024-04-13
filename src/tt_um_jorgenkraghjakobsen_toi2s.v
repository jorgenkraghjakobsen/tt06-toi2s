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
  assign uio_out[7:2] = 7'b0000_000;
  assign uio_oe[7:2]  = 7'b0000_000;
  
  wire audio_locked;
  wire edge_detect;

  toi2s_tt_top tt_top_inst ( 
    .clk(clk),
    .reset(rst_n),
    .i2c_scl(uio_in[0]),
    .i2c_sdai(uio_in[1]),
    .i2c_sdao(uio_out[1]),
    .i2c_sdaeo(uio_oe[1]),
    .pwm_out(pwm_out)
   ); 


  // spdif_decoder spdif_decoder(
  //   .clk_in(clk),
  //   .resetb(rst_n),
  //   .rx_in(ui_in[0]),
  //   .i2s_bck(uo_out[0]),
  //   .i2s_ws(uo_out[1]),
  //   .i2s_d0(uo_out[2]),
  //   .audio_locked(audio_locked),
  //   .edgedetect(edge_detect));
  
  assign uo_out[0] = 1'b1;    // placeholder i2c_sda
  assign uo_out[1] = 1'b1;    // placeholder i2c_scl
  assign uo_out[2] = 1'b0;    // nenable_out
  assign uo_out[3] = 1'b1;    // placeholder i2c_sda
  assign uo_out[4] = 1'b1;    // placeholder i2c_scl
  assign uo_out[5] = 1'b0;    // nenable_out
  assign uo_out[6] = 1'b0;    // nmute_out
  assign uo_out[7] = pwm_out;    // rx_out


endmodule
