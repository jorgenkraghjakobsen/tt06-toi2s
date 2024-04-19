
// Interface structures for registerbank symbol access


//`ifndef _toi2s_
//  `define _toi2s_

package toi2s_pkg;// Wire interface for sys_cfg
typedef struct packed {
  logic       enable_stuf;                     // Enable stuf
  logic       enable_other;                    // Enable other stuf
  logic       monitor_flag;                    // Monitor internal flag
  logic [7:0] pwm_duty;                        // Counter value for pwm
  logic [5:0] debug_led;                       // Debug led signals
} rb_sys_cfg_wire_t;

// Wire interface for amp_cfg
typedef struct packed {
  logic [7:0] status;                          // amp status 
  logic       amp_init;                        // send cfg to amp
  logic [7:0] bootmem0;                        // boot mem
  logic [7:0] bootmem1;                        // boot mem
  logic [7:0] bootmem2;                        // boot mem
  logic [7:0] bootmem3;                        // boot mem
  logic [7:0] bootmem4;                        // boot mem
  logic [7:0] bootmem5;                        // boot mem
  logic [7:0] bootmem6;                        // boot mem
  logic [7:0] bootmem7;                        // boot mem
} rb_amp_cfg_wire_t;


endpackage

//`endif
