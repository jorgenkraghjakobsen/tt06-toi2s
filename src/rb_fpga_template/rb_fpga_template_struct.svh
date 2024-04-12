
// Interface structures for registerbank symbol access


//`ifndef _fpga_template_
//  `define _fpga_template_

package fpga_template_pkg;// Wire interface for sys_cfg
typedef struct packed {
  logic       enable_stuf;                     // Enable stuf
  logic       enable_other;                    // Enable other stuf
  logic       monitor_flag;                    // Monitor internal flag
  logic [7:0] pwm_duty;                        // Counter value for pwm
  logic [5:0] debug_led;                       // Debug led signals
} rb_sys_cfg_wire_t;

// Wire interface for dsp_cfg
typedef struct packed {
  logic       bypass_enable;                   // Bypass filters on the DSP
  logic       dc_filter_enable;                // Bypass DC filter on the DSP
  logic       bp_filter_enable;                // Bypass bandpass filter on the DSP
  logic       dec_filter_enable;               // Bypass decimation filter on the DSP
  logic       pli_filter_enable;               // Bypass PLI filter on the DSP
  logic       placeholder1;                    // placeholder
  logic       placeholder2;                    // placeholder
  logic       placeholder3;                    // placeholder
} rb_dsp_cfg_wire_t;


endpackage

//`endif
