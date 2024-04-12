// Register bank 
// Auto generated code from fpga_template version 1 
// Written by Jørgen Kragh Jakobsen, All right reserved 
//-----------------------------------------------------------------------------
//`include "rb_fpga_template_struct.svh"
import fpga_template_pkg::*;

module rb_fpga_template
#(parameter ADR_BITS = 8
 )
(
	input  logic				clk,
	input  logic				resetb,
	input  logic [ADR_BITS-1:0]		address,
	input  logic [7:0]			data_write_in,
	output logic [7:0] 			data_read_out,
	input  logic 				reg_en,
	input  logic 				write_en,
//---------------------------------------------
	inout rb_sys_cfg_wire_t              sys_cfg,
	inout rb_dsp_cfg_wire_t              dsp_cfg 
);
//------------------------------------------------Write to registers and reset-
// Create registers

    // --- Section: sys_cfg  Offset: 0x0000  Size: 16
reg        reg__sys_cfg__enable_stuf;                            //Enable stuf
reg        reg__sys_cfg__enable_other;                           //Enable other stuf
reg [7:0]  reg__sys_cfg__pwm_duty;                               //Counter value for pwm
reg [5:0]  reg__sys_cfg__debug_led;                              //Debug led signals

    // --- Section: dsp_cfg  Offset: 0x0040  Size: 16
reg        reg__dsp_cfg__bypass_enable;                          //Bypass filters on the DSP
reg        reg__dsp_cfg__dc_filter_enable;                       //Bypass DC filter on the DSP
reg        reg__dsp_cfg__bp_filter_enable;                       //Bypass bandpass filter on the DSP
reg        reg__dsp_cfg__dec_filter_enable;                      //Bypass decimation filter on the DSP
reg        reg__dsp_cfg__pli_filter_enable;                      //Bypass PLI filter on the DSP
reg        reg__dsp_cfg__placeholder1;                           //placeholder
reg        reg__dsp_cfg__placeholder2;                           //placeholder
reg        reg__dsp_cfg__placeholder3;                           //placeholder

always_ff @(posedge clk)
begin
  if (resetb == 0)
  begin

    // --- Section: sys_cfg  Offset: 0x0000  Size: 16
    reg__sys_cfg__enable_stuf                             <=  1'b00000000;   //Enable stuf
    reg__sys_cfg__enable_other                            <=  1'b00000001;   //Enable other stuf
    reg__sys_cfg__pwm_duty                                <=  8'b10000101;   //Counter value for pwm
    reg__sys_cfg__debug_led                               <=  6'b01010101;   //Debug led signals

    // --- Section: dsp_cfg  Offset: 0x0040  Size: 16
    reg__dsp_cfg__bypass_enable                           <=  1'b00000001;   //Bypass filters on the DSP
    reg__dsp_cfg__dc_filter_enable                        <=  1'b00000001;   //Bypass DC filter on the DSP
    reg__dsp_cfg__bp_filter_enable                        <=  1'b00000001;   //Bypass bandpass filter on the DSP
    reg__dsp_cfg__dec_filter_enable                       <=  1'b00000001;   //Bypass decimation filter on the DSP
    reg__dsp_cfg__pli_filter_enable                       <=  1'b00000001;   //Bypass PLI filter on the DSP
    reg__dsp_cfg__placeholder1                            <=  1'b00000000;   //placeholder
    reg__dsp_cfg__placeholder2                            <=  1'b00000000;   //placeholder
    reg__dsp_cfg__placeholder3                            <=  1'b00000000;   //placeholder
  end
  else
  begin
    if (write_en)
    begin
      case (address)
        000 : begin 
              reg__sys_cfg__enable_stuf                         <=   data_write_in[0:0];  // Enable stuf
              reg__sys_cfg__enable_other                        <=   data_write_in[1:1];  // Enable other stuf
              end
        001 : reg__sys_cfg__pwm_duty                            <=   data_write_in[7:0];  // Counter value for pwm
 
        002 : reg__sys_cfg__debug_led                           <=   data_write_in[5:0];  // Debug led signals
 
        064 : begin 
              reg__dsp_cfg__bypass_enable                       <=   data_write_in[0:0];  // Bypass filters on the DSP
              reg__dsp_cfg__dc_filter_enable                    <=   data_write_in[1:1];  // Bypass DC filter on the DSP
              reg__dsp_cfg__bp_filter_enable                    <=   data_write_in[2:2];  // Bypass bandpass filter on the DSP
              reg__dsp_cfg__dec_filter_enable                   <=   data_write_in[3:3];  // Bypass decimation filter on the DSP
              reg__dsp_cfg__pli_filter_enable                   <=   data_write_in[4:4];  // Bypass PLI filter on the DSP
              reg__dsp_cfg__placeholder1                        <=   data_write_in[5:5];  // placeholder
              reg__dsp_cfg__placeholder2                        <=   data_write_in[6:6];  // placeholder
              reg__dsp_cfg__placeholder3                        <=   data_write_in[7:7];  // placeholder
              end
      endcase 
    end
  end
end
//---------------------------------------------
always @(posedge clk )
begin
  if (resetb == 0)
    data_read_out <= 8'b00000000;
  else
  begin
    data_read_out <= 8'b00000000;
    case (address)
        000 : begin 
              data_read_out[0:0]  <=  reg__sys_cfg__enable_stuf;                // Enable stuf
              data_read_out[1:1]  <=  reg__sys_cfg__enable_other;               // Enable other stuf
              data_read_out[2:2]  <=  sys_cfg.monitor_flag;                     // Monitor internal flag
              end
        001 : data_read_out[7:0]  <=  reg__sys_cfg__pwm_duty;                   // Counter value for pwm
 
        002 : data_read_out[5:0]  <=  reg__sys_cfg__debug_led;                  // Debug led signals
 
        064 : begin 
              data_read_out[0:0]  <=  reg__dsp_cfg__bypass_enable;              // Bypass filters on the DSP
              data_read_out[1:1]  <=  reg__dsp_cfg__dc_filter_enable;           // Bypass DC filter on the DSP
              data_read_out[2:2]  <=  reg__dsp_cfg__bp_filter_enable;           // Bypass bandpass filter on the DSP
              data_read_out[3:3]  <=  reg__dsp_cfg__dec_filter_enable;          // Bypass decimation filter on the DSP
              data_read_out[4:4]  <=  reg__dsp_cfg__pli_filter_enable;          // Bypass PLI filter on the DSP
              data_read_out[5:5]  <=  reg__dsp_cfg__placeholder1;               // placeholder
              data_read_out[6:6]  <=  reg__dsp_cfg__placeholder2;               // placeholder
              data_read_out[7:7]  <=  reg__dsp_cfg__placeholder3;               // placeholder
              end
      default : data_read_out <= 8'b00000000;
    endcase
  end
end
//-------------------------------------Assign symbols to structs
assign sys_cfg.enable_stuf                      = reg__sys_cfg__enable_stuf ;
assign sys_cfg.enable_other                     = reg__sys_cfg__enable_other ;
assign sys_cfg.pwm_duty                         = reg__sys_cfg__pwm_duty ;
assign sys_cfg.debug_led                        = reg__sys_cfg__debug_led ;
assign dsp_cfg.bypass_enable                    = reg__dsp_cfg__bypass_enable ;
assign dsp_cfg.dc_filter_enable                 = reg__dsp_cfg__dc_filter_enable ;
assign dsp_cfg.bp_filter_enable                 = reg__dsp_cfg__bp_filter_enable ;
assign dsp_cfg.dec_filter_enable                = reg__dsp_cfg__dec_filter_enable ;
assign dsp_cfg.pli_filter_enable                = reg__dsp_cfg__pli_filter_enable ;
assign dsp_cfg.placeholder1                     = reg__dsp_cfg__placeholder1 ;
assign dsp_cfg.placeholder2                     = reg__dsp_cfg__placeholder2 ;
assign dsp_cfg.placeholder3                     = reg__dsp_cfg__placeholder3 ;
endmodule
