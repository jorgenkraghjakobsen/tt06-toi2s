// toI2S tinytapeout top  
// 

import toi2s_pkg::*; 

module toi2s_tt_top
    ( 
    input   clk,
    input   resetb,              // on Tangnano9k  // Button 1 input  (pin 3)
    //---I2C-----------   
    input   i2c_scl,            // FTDI serial USB_I2C // ( pin 25 ) (slave)  
    
    input   i2c_sdai,           // FTDI serial USB_I2c // ( pin 26 ) (slave)  
    output  i2c_sdao,           // bidirectional io handled at higher level
    output  i2c_sdaoe,          // implemeeted in fpga top and on TT downtream flow
    
    //---SPDIF---------  
    input   rxin,               // Audio input spdif blinking ligth  (pin 38) 
    //---AMPLIFIER-----
    output  i2s_bck,            // Clock
    output  i2s_ws,             // Sync Left/Rigth
    output  i2s_d0,             // Data 
    output  amp_i2c_scl         // amp i2c clk control  (master ->  amp (slave))
    input   amp_i2c_sdai,       // amp i2c data control (master)
    output  amp_i2c_sdao,       // amp i2c data control (master)
    output  amp_i2c_sdaoe,       // amp i2c data control (master)
    output  amp_nenable,        // amp nenable
    output  amp_mute,           // amp mute      
    
    //---PWM-----------
    output  pwm_out,             // Debug output pwm signal  (pin 35)
    
    //---Debug---------
    output  [5:0] debug_out,    // Debug out signals  
    input   debug_in           // Was btn_s2,             // Button 2 input (pin 4)   
    );
    
assign debug_out = sys_cfg.debug_led;

//--------------------------------------------------------------------------------------------------------
// Clock and reset   
//-------------------------------------------------------------------------------------------------------- 



// Direct clock insert PLL here when needed

//--------------------------------------------------------------------------------------------------------
// Register bank structs  
//-------------------------------------------------------------------------------------------------------- 
rb_sys_cfg_wire_t sys_cfg;

//--------------------------------------------------------------------------------------------------------
// i2c  
//-------------------------------------------------------------------------------------------------------- 
wire [7:0] rb_address;
wire [7:0] rb_data_write_to_reg;
wire [7:0] rb_data_read_from_reg;
wire rb_reg_en;    
wire rb_write_en;
wire [1:0] rb_streamSt_mon;

i2c_if i2c_inst ( 
    .clk                (clk),
    .resetb             (resetb),
    .sda                (i2c_sda),
    .scl                (i2c_scl),
    .address            (rb_address),
    .data_write_to_reg  (rb_data_write_to_reg), 
    .data_read_from_reg (rb_data_read_from_reg),
    .reg_en             (rb_reg_en), 
    .write_en           (rb_write_en),
    .streamSt_mon       (rb_streamSt_mon) 
    ); 
//--------------------------------------------------------------------------------------------------------
// Register bank        
//-------------------------------------------------------------------------------------------------------- 
rb_toi2s rb_toi2s_inst (
    .clk                (clk),
    .resetb             (resetb),
    .address            (rb_address),
    .data_write_in      (rb_data_write_to_reg), 
    .data_read_out      (rb_data_read_from_reg),
    .write_en           (rb_write_en),
    .sys_cfg            (sys_cfg)
    ); 

//-------------------------------------------------------------------------------------------------------- 
// Your block here                
//-------------------------------------------------------------------------------------------------------- 
pwm pwm_inst (
    .clock_in(clk),
    .reset(!resetb),
    .duty_cycle(sys_cfg.pwm_duty),  // 0x80 -> 50% 
    .pwm_out(pwm_out)
); 
         
//-------------------------------------------------------------------------------------------------------- 
// Your block here                
//-------------------------------------------------------------------------------------------------------- 



endmodule