//  O-Audio controller 
//  
//  Splits an audio single datastream to audio and controllogic 
//  Written by Jørgen Kragh Jakobsen, November 2021

module amp_if (
    input clk,
    input resetb, 
    input ena,
    input rx_in, 
    output amp_i2s_bck, 
    output amp_i2s_ws,
    output amp_i2s_d0, 
    input  amp_i2c_sdai,
    output amp_i2c_sdao,
    output amp_i2c_scl, 
    output amp_nenable, 
    output amp_nmute,
    output debug_out
    );  
    
    assign debug_out = 1'b1; 
    
    wire audio_locked;
    wire send_config;
    wire rx_out_tmp;

    wire i2s_bck_tmp, i2s_ws_tmp, i2s_d0_tmp; 
    
    spdif_decoder spdif(
      .clk_in(clk),
      .resetb(resetb),
      .rx_in(rx_in),
      .i2s_bck(i2s_bck_tmp),
      .i2s_ws(i2s_ws_tmp),
      .i2s_d0(i2s_d0_tmp),
      
      .audio_locked(audio_locked),
      .edgedetect(rx_out_tmp)); 
    
   //assign send_config  = rx_in; 

    
    assign amp_i2s_d0 = i2s_d0_tmp & amp_nmute;
    assign amp_i2s_ws = i2s_ws_tmp & amp_nmute;
    assign amp_i2s_bck = i2s_bck_tmp & amp_nmute;
    
    wire nerror_in ;
    assign nerror_in = 1'b1;

    amp_state_control ctrl ( 
        .clk_in(clk),
        .resetb(resetb),
        .audio_locked_in(audio_locked),
        .nerror_in(nerror_in), 
        .nenable_out(amp_nenable),
        .nmute_out(amp_nmute),
        .send_config_out(send_config)); 
      
    amp_i2c_master i2c (
        .clk_in(clk),
        .resetb(resetb),
        .send_cfg(send_config),
        .sdai(amp_i2c_sdai),
        .sdao(amp_i2c_sdao),
        .scl(amp_i2c_scl)
        ); 
    
endmodule
