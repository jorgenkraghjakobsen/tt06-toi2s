//  O-Audio controller 
//  
//  Splits an audio single datastream to audio and controllogic 
//  Written by Jørgen Kragh Jakobsen, November 2021

module amp_frontend (
    `ifdef SIM
     //input clk,
    `endif
    (* LOC="4" *)
    input resetb, 
    
    (* LOC="12" *)
    input rx_in, 
    
    (* LOC="5" *)
    input nerror_in,
    
    (* LOC="13" *)
    output i2s_bck, 
    (* LOC="14" *)
    output i2s_ws,
    (* LOC="16" *)
    output i2s_d0, 

    (* LOC="27" *)
    inout i2c_sda, 
    (* LOC="28" *)
    inout i2c_scl, 
   
    (* LOC="10" *)
    output rx_out,
    
    (* LOC="25" *)
    output nenable_out, 
    (* LOC="26" *)
    output nmute_out);  
    //output clk_out);

    /* synthesis GSR=“ENABLED” */;
    /*reg [24:0] rst_cnt = 25'h0;
    wire rst_n = rst_cnt[24];
    wire reset; 
    assign reset = ~rst_n;

    always @(posedge clk)
    if( !rst_n )
       rst_cnt <= rst_cnt + 25'h1;
    */ 

    // Clk system use internal 12.09 +/- 5% as ref to pll  
    wire clk ; 
    wire clk_osc ; 
    `ifndef FPGA 
       OSCH #(
         .NOM_FREQ("53.2")  ////88.67") //53.2 // 12.09 //3.02
       ) int_clk (
         .STDBY(1'b0),
         .OSC(clk)
       ); 
       
       //POR POR_inst (.POR(1'b0)); 
       //GSR GSR_INST (.GSR(resetb));
       
       //PUR #(.RST_PULSE(100)) int_pur (.PUR(resetb));
       
       //pll_x4 pll (clk_osc, clk); 
    
    `endif  
    
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

    //amp_i2s_interface i2s (
    //    .clk_in(clk),
    //    .resetb(resetb),
    //    .rx_in(rx_in),
        //.i2s_bck(i2s_bck_tmp),
        //.i2s_ws(i2s_ws_tmp),
        //.i2s_d0(i2s_d0_tmp),
    //    .audio_locked(audio_locked)); 

   // assign i2s_bck = clk;
    assign i2s_d0 = i2s_d0_tmp & nmute_out;
    assign i2s_ws = i2s_ws_tmp & nmute_out;
    assign i2s_bck = i2s_bck_tmp & nmute_out;
    
    assign rx_out = rx_out_tmp; 

    amp_state_control ctrl ( 
        .clk_in(clk),
        .resetb(resetb),
        .audio_locked_in(audio_locked),
        .nerror_in(nerror_in), 
        .nenable_out(nenable_out),
        .nmute_out(nmute_out),
        .send_config_out(send_config)); 
        
    amp_i2c_master i2c (
        .clk_in(clk),
        .resetb(resetb),
        .send_cfg(send_config),
        .sda(i2c_sda),
        .scl(i2c_scl)); 
    //assign nenable_out = send_config;  
endmodule