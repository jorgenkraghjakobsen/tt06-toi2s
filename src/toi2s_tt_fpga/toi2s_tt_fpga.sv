// toI2S tinytapeout fpga wrapper 
// 
`default_nettype none

import toi2s_pkg::*; 

module toi2s_tt_fpga
    ( 
    input   clk,
    input   resetb,
    input   ena,               // on Tangnano9k  // Button 1 input  (pin 3)
    //---I2C-----------   
    input   i2c_scl,            // FTDI serial USB_I2C // ( pin 25 ) (slave)  
    inout   i2c_sda,            // FTDI serial USB_I2c // ( pin 26 ) (slave)  
    //---SPDIF---------  
    input   rx_in,               // Audio input spdif blinking ligth  (pin 38) 
    //---AMPLIFIER-----
    output  amp_i2s_bck,            // Clock
    output  amp_i2s_ws,             // Sync Left/Rigth
    output  amp_i2s_d0,             // Data 
    output  amp_i2c_scl,         // amp i2c clk control  (master ->  amp (slave))
    inout   amp_i2c_sda,        // amp i2c data control (master)
    output  amp_nenable,        // amp nenable
    output  amp_nmute,           // amp mute      
    
    //---PWM-----------
    output  pwm_out,             // Debug output pwm signal  (pin 35)
    
    //---Debug---------
    output  [5:0] debug_out,    // Debug out signals  
    input   debug_in           // Was btn_s2,             // Button 2 input (pin 4)   
    );
    
    wire i2c_sdai; 
    wire i2c_sdao;
    assign i2c_sdai = i2c_sda;
    assign i2c_sda = (i2c_sdao == 1'b0)? 1'b0 : 1'bz;  
   
    wire amp_i2c_sdai; 
    wire amp_i2c_sdao;
    assign amp_i2c_sdai = amp_i2c_sda;
    assign amp_i2c_sda = (amp_i2c_sdao == 1'b0)? amp_i2c_sdao : 1'bz;  
    
    //assign amp_i2s_bck = debug_out[5];


    
    toi2s_tt_top toi2s_tt_top_inst( 
    .clk(clk), 
    .resetb(resetb),
    .ena(ena),                // Top level enable
    //---I2C-----------   
    .i2c_scl(i2c_scl),            // FTDI serial USB_I2C // ( pin 25 ) (slave)  
    
    .i2c_sdai(i2c_sdai),           // FTDI serial USB_I2c // ( pin 26 ) (slave)  
    .i2c_sdao(i2c_sdao),           // bidirectional io handled at higher level
    
    //---SPDIF---------  
    .rx_in(rx_in),              // Audio input spdif blinking ligth  (pin 38) 
    
    //---AMPLIFIER-----
    .amp_i2s_bck(amp_i2s_bck),            // Clock
    .amp_i2s_ws(amp_i2s_ws),             // Sync Left/Rigth
    .amp_i2s_d0(amp_i2s_d0),             // Data 
    
    .amp_i2c_scl(amp_i2c_scl),         // amp i2c clk control  (master ->  amp (slave))
    .amp_i2c_sdai(amp_i2c_sdai),       // amp i2c data control (master)
    .amp_i2c_sdao(amp_i2c_sdao),       // amp i2c data control (master)
    
    .amp_nenable(amp_nenable),        // amp nenable
    .amp_nmute(amp_nmute),           // amp mute      
    
    //---PWM-----------
    .pwm_out(pwm_out),             // Debug output pwm signal  (pin 35)
    
    //---Debug---------
    .debug_out(debug_out),    // Debug out signals  
    .debug_in(~debug_in)   
    );
// assign debug_out = sys_cfg.debug_led;

// //--------------------------------------------------------------------------------------------------------
// // Clock and reset   
// //-------------------------------------------------------------------------------------------------------- 

// //wire resetb; 
// //assign resetb = reset; 

// //--------------------------------------------------------------------------------------------------------
// // MA12070 interface 
// //-------------------------------------------------------------------------------------------------------- 

// assign amp_nmute    = 1'b0;
// assign amp_nenable  = 1'b1; 
// assign amp_i2c_scl  = 1'b0; 
// assign amp_i2c_sda  = 1'b1;
// assign amd_i2s_bck  = 1'b0; 
// assign amd_i2s_ws   = 1'b0; 
// assign amd_i2s_d0   = 1'b0; 

// // Direct clock insert PLL here when needed

// //--------------------------------------------------------------------------------------------------------
// // Register bank structs  
// //-------------------------------------------------------------------------------------------------------- 
// rb_sys_cfg_wire_t sys_cfg;

// //--------------------------------------------------------------------------------------------------------
// // i2c  
// //-------------------------------------------------------------------------------------------------------- 
// wire [7:0] rb_address;
// wire [7:0] rb_data_write_to_reg;
// wire [7:0] rb_data_read_from_reg;
// wire rb_reg_en;    
// wire rb_write_en;
// wire [1:0] rb_streamSt_mon;

// wire i2c_sdai; 
// wire i2c_sdao; 

// assign i2c_sda   = (i2c_sdao == 1'b0)? 1'b0 : 1'bz; 
// assign i2c_sdai  = i2c_sda; 


// i2c_if i2c_inst ( 
//     .clk                (clk),
//     .resetb             (resetb),
//     .sdaIn                (i2c_sdai),
//     .sdaOut                (i2c_sdao),
//     .scl                (i2c_scl),
//     .address            (rb_address),
//     .data_write_to_reg  (rb_data_write_to_reg), 
//     .data_read_from_reg (rb_data_read_from_reg),
//     .reg_en             (rb_reg_en), 
//     .write_en           (rb_write_en),
//     .streamSt_mon       (rb_streamSt_mon) 
//     ); 
// //--------------------------------------------------------------------------------------------------------
// // Register bank        
// //-------------------------------------------------------------------------------------------------------- 
// rb_toi2s rb_toi2s_inst (
//     .clk                (clk),
//     .resetb             (resetb),
//     .address            (rb_address),
//     .data_write_in      (rb_data_write_to_reg), 
//     .data_read_out      (rb_data_read_from_reg),
//     .write_en           (rb_write_en),
//     .sys_cfg            (sys_cfg)
//     ); 

// //-------------------------------------------------------------------------------------------------------- 
// // Your block here                
// //-------------------------------------------------------------------------------------------------------- 
// pwm pwm_inst (
//     .clock_in(clk),
//     .reset(!resetb),
//     .duty_cycle(sys_cfg.pwm_duty),  // 0x80 -> 50% 
//     .pwm_out(pwm_out)
// ); 
         
// //-------------------------------------------------------------------------------------------------------- 
// // Your block here                
// //-------------------------------------------------------------------------------------------------------- 

endmodule