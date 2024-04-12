// Boiler plate for a midsize fpga project 
// 

import fpga_template_pkg::*; 

module fpga_template_top
    ( 
    input   clk, 
    //---I2C-----------   
    input   i2c_scl,    
    inout   i2c_sda,
    //---PWM-----------
    output pwm_out, 
    //---Debug---------
    output  [5:0] debug_led_pin,
    input   btn_s1_reset,     // Button 1 input   
    input   btn_s2,           // Button 2 input   
    //---More Ground---
    output  gnd0            // Ground output with cranked up power 
    );
    
assign gnd0 = 1'b0;
assign debug_led_pin = sys_cfg.debug_led;

//--------------------------------------------------------------------------------------------------------
// Clock and reset   
//-------------------------------------------------------------------------------------------------------- 

wire resetb; 
assign resetb = btn_s1_reset; 

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
rb_fpga_template rb_fpga_template_inst (
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