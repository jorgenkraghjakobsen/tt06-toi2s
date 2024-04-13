// removed package "toi2s_pkg"
// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:4:1
// removed ["import toi2s_pkg::*;"]
module toi2s_tt_top (
	clk,
	resetb,
	ena,
	i2c_scl,
	i2c_sdai,
	i2c_sdao,
	rx_in,
	i2s_bck,
	i2s_ws,
	i2s_d0,
	amp_i2c_scl,
	amp_i2c_sdai,
	amp_i2c_sdao,
	amp_nenable,
	amp_mute,
	pwm_out,
	debug_out,
	debug_in
);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:8:5
	input clk;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:9:5
	input resetb;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:10:5
	input ena;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:12:5
	input i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:14:5
	input i2c_sdai;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:15:5
	output wire i2c_sdao;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:18:5
	input rx_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:21:5
	output wire i2s_bck;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:22:5
	output wire i2s_ws;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:23:5
	output wire i2s_d0;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:25:5
	output wire amp_i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:26:5
	input amp_i2c_sdai;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:27:5
	output wire amp_i2c_sdao;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:29:5
	output wire amp_nenable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:30:5
	output wire amp_mute;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:33:5
	output wire pwm_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:36:5
	output wire [5:0] debug_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:37:5
	input debug_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:40:1
	// removed localparam type toi2s_pkg_rb_sys_cfg_wire_t
	wire [16:0] sys_cfg;
	assign debug_out = sys_cfg[5-:6];
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:53:1
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:58:1
	wire [7:0] rb_address;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:59:1
	wire [7:0] rb_data_write_to_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:60:1
	wire [7:0] rb_data_read_from_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:61:1
	wire rb_reg_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:62:1
	wire rb_write_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:63:1
	wire [1:0] rb_streamSt_mon;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:65:1
	i2c_if i2c_inst(
		.clk(clk),
		.resetb(resetb),
		.sdaIn(i2c_sdai),
		.sdaOut(i2c_sdao),
		.scl(i2c_scl),
		.address(rb_address),
		.data_write_to_reg(rb_data_write_to_reg),
		.data_read_from_reg(rb_data_read_from_reg),
		.reg_en(rb_reg_en),
		.write_en(rb_write_en),
		.streamSt_mon(rb_streamSt_mon)
	);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:81:1
	rb_toi2s rb_toi2s_inst(
		.clk(clk),
		.resetb(resetb),
		.address(rb_address),
		.data_write_in(rb_data_write_to_reg),
		.data_read_out(rb_data_read_from_reg),
		.write_en(rb_write_en),
		.sys_cfg(sys_cfg)
	);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_top/toi2s_tt_top.sv:94:1
	pwm pwm_inst(
		.clock_in(clk),
		.reset(!resetb),
		.duty_cycle(sys_cfg[13-:8]),
		.pwm_out(pwm_out)
	);
endmodule
