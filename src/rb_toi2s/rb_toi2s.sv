// Register bank 
// Auto generated code from toi2s version 1 
// Written by Jørgen Kragh Jakobsen, All right reserved 
//-----------------------------------------------------------------------------
//`include "rb_toi2s_struct.svh"
import toi2s_pkg::*;

module rb_toi2s
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
	inout rb_amp_cfg_wire_t              amp_cfg 
);
//------------------------------------------------Write to registers and reset-
// Create registers

    // --- Section: sys_cfg  Offset: 0x0000  Size: 16
reg        reg__sys_cfg__enable_stuf;                            //Enable stuf
reg        reg__sys_cfg__enable_other;                           //Enable other stuf
reg [7:0]  reg__sys_cfg__pwm_duty;                               //Counter value for pwm
reg [5:0]  reg__sys_cfg__debug_led;                              //Debug led signals
reg [7:0]  reg__sys_cfg__spare_0;                                //Spare_reg0
reg [7:0]  reg__sys_cfg__spare_1;                                //Spare_reg1
reg [7:0]  reg__sys_cfg__spare_2;                                //Spare_reg2

    // --- Section: amp_cfg  Offset: 0x0010  Size: 16
reg        reg__amp_cfg__amp_init;                               //send cfg to amp
reg [7:0]  reg__amp_cfg__bootmem0;                               //boot mem0
reg [7:0]  reg__amp_cfg__bootmem1;                               //boot mem1
reg [7:0]  reg__amp_cfg__bootmem2;                               //boot mem2
reg [7:0]  reg__amp_cfg__bootmem3;                               //boot mem3
reg [7:0]  reg__amp_cfg__bootmem4;                               //boot mem4
reg [7:0]  reg__amp_cfg__bootmem5;                               //boot mem5
reg [7:0]  reg__amp_cfg__bootmem6;                               //boot mem6
reg [7:0]  reg__amp_cfg__bootmem7;                               //boot mem7

always_ff @(posedge clk)
begin
  if (resetb == 0)
  begin

    // --- Section: sys_cfg  Offset: 0x0000  Size: 16
    reg__sys_cfg__enable_stuf                             <=  1'b00000000;   //Enable stuf
    reg__sys_cfg__enable_other                            <=  1'b00000001;   //Enable other stuf
    reg__sys_cfg__pwm_duty                                <=  8'b10000101;   //Counter value for pwm
    reg__sys_cfg__debug_led                               <=  6'b01010001;   //Debug led signals
    reg__sys_cfg__spare_0                                 <=  8'b00010001;   //Spare_reg0
    reg__sys_cfg__spare_1                                 <=  8'b00100010;   //Spare_reg1
    reg__sys_cfg__spare_2                                 <=  8'b00110011;   //Spare_reg2

    // --- Section: amp_cfg  Offset: 0x0010  Size: 16
    reg__amp_cfg__amp_init                                <=  1'b00000000;   //send cfg to amp
    reg__amp_cfg__bootmem0                                <=  8'b01000000;   //boot mem0
    reg__amp_cfg__bootmem1                                <=  8'b01001000;   //boot mem1
    reg__amp_cfg__bootmem2                                <=  8'b00110101;   //boot mem2
    reg__amp_cfg__bootmem3                                <=  8'b00001000;   //boot mem3
    reg__amp_cfg__bootmem4                                <=  8'b11111111;   //boot mem4
    reg__amp_cfg__bootmem5                                <=  8'b11111111;   //boot mem5
    reg__amp_cfg__bootmem6                                <=  8'b11111111;   //boot mem6
    reg__amp_cfg__bootmem7                                <=  8'b11111111;   //boot mem7
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
 
        003 : reg__sys_cfg__spare_0                             <=   data_write_in[7:0];  // Spare_reg0
 
        004 : reg__sys_cfg__spare_1                             <=   data_write_in[7:0];  // Spare_reg1
 
        005 : reg__sys_cfg__spare_2                             <=   data_write_in[7:0];  // Spare_reg2
 
        017 : reg__amp_cfg__amp_init                            <=   data_write_in[0:0];  // send cfg to amp
 
        024 : reg__amp_cfg__bootmem0                            <=   data_write_in[7:0];  // boot mem0
 
        025 : reg__amp_cfg__bootmem1                            <=   data_write_in[7:0];  // boot mem1
 
        026 : reg__amp_cfg__bootmem2                            <=   data_write_in[7:0];  // boot mem2
 
        027 : reg__amp_cfg__bootmem3                            <=   data_write_in[7:0];  // boot mem3
 
        028 : reg__amp_cfg__bootmem4                            <=   data_write_in[7:0];  // boot mem4
 
        029 : reg__amp_cfg__bootmem5                            <=   data_write_in[7:0];  // boot mem5
 
        030 : reg__amp_cfg__bootmem6                            <=   data_write_in[7:0];  // boot mem6
 
        031 : reg__amp_cfg__bootmem7                            <=   data_write_in[7:0];  // boot mem7
 
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
 
        003 : data_read_out[7:0]  <=  reg__sys_cfg__spare_0;                    // Spare_reg0
 
        004 : data_read_out[7:0]  <=  reg__sys_cfg__spare_1;                    // Spare_reg1
 
        005 : data_read_out[7:0]  <=  reg__sys_cfg__spare_2;                    // Spare_reg2
 
        016 : data_read_out[7:0]  <=  amp_cfg.status;                           // amp status 
 
        017 : data_read_out[0:0]  <=  reg__amp_cfg__amp_init;                   // send cfg to amp
 
        024 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem0;                   // boot mem0
 
        025 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem1;                   // boot mem1
 
        026 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem2;                   // boot mem2
 
        027 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem3;                   // boot mem3
 
        028 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem4;                   // boot mem4
 
        029 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem5;                   // boot mem5
 
        030 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem6;                   // boot mem6
 
        031 : data_read_out[7:0]  <=  reg__amp_cfg__bootmem7;                   // boot mem7
 
      default : data_read_out <= 8'b00000000;
    endcase
  end
end
//-------------------------------------Assign symbols to structs
assign sys_cfg.enable_stuf                      = reg__sys_cfg__enable_stuf ;
assign sys_cfg.enable_other                     = reg__sys_cfg__enable_other ;
assign sys_cfg.pwm_duty                         = reg__sys_cfg__pwm_duty ;
assign sys_cfg.debug_led                        = reg__sys_cfg__debug_led ;
assign sys_cfg.spare_0                          = reg__sys_cfg__spare_0 ;
assign sys_cfg.spare_1                          = reg__sys_cfg__spare_1 ;
assign sys_cfg.spare_2                          = reg__sys_cfg__spare_2 ;
assign amp_cfg.amp_init                         = reg__amp_cfg__amp_init ;
assign amp_cfg.bootmem0                         = reg__amp_cfg__bootmem0 ;
assign amp_cfg.bootmem1                         = reg__amp_cfg__bootmem1 ;
assign amp_cfg.bootmem2                         = reg__amp_cfg__bootmem2 ;
assign amp_cfg.bootmem3                         = reg__amp_cfg__bootmem3 ;
assign amp_cfg.bootmem4                         = reg__amp_cfg__bootmem4 ;
assign amp_cfg.bootmem5                         = reg__amp_cfg__bootmem5 ;
assign amp_cfg.bootmem6                         = reg__amp_cfg__bootmem6 ;
assign amp_cfg.bootmem7                         = reg__amp_cfg__bootmem7 ;
endmodule
