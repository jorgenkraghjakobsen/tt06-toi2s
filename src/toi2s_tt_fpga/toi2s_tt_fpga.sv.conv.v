// removed package "toi2s_pkg"
// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:4:1
// removed ["import toi2s_pkg::*;"]
module toi2s_tt_fpga (
	clk,
	reset,
	i2c_scl,
	i2c_sda,
	rxin,
	i2s_bck,
	i2s_ws,
	i2s_d0,
	amp_i2c_scl,
	amp_i2c_sda,
	amp_nenable,
	amp_mute,
	pwm_out,
	debug_out,
	debug_in
);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:8:5
	input clk;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:9:5
	input reset;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:11:5
	input i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:12:5
	inout i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:14:5
	input rxin;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:16:5
	output wire i2s_bck;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:17:5
	output wire i2s_ws;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:18:5
	output wire i2s_d0;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:19:5
	output wire amp_i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:20:5
	inout amp_i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:21:5
	output wire amp_nenable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:22:5
	output wire amp_mute;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:25:5
	output wire pwm_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:28:5
	output wire [5:0] debug_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:29:5
	input debug_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:32:1
	// removed localparam type toi2s_pkg_rb_sys_cfg_wire_t
	wire [16:0] sys_cfg;
	assign debug_out = sys_cfg[5-:6];
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:38:1
	wire resetb;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:39:1
	assign resetb = reset;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:46:1
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:51:1
	wire [7:0] rb_address;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:52:1
	wire [7:0] rb_data_write_to_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:53:1
	wire [7:0] rb_data_read_from_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:54:1
	wire rb_reg_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:55:1
	wire rb_write_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:56:1
	wire [1:0] rb_streamSt_mon;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:58:1
	i2c_if i2c_inst(
		.clk(clk),
		.resetb(resetb),
		.sda(i2c_sda),
		.scl(i2c_scl),
		.address(rb_address),
		.data_write_to_reg(rb_data_write_to_reg),
		.data_read_from_reg(rb_data_read_from_reg),
		.reg_en(rb_reg_en),
		.write_en(rb_write_en),
		.streamSt_mon(rb_streamSt_mon)
	);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:73:1
	rb_toi2s rb_toi2s_inst(
		.clk(clk),
		.resetb(resetb),
		.address(rb_address),
		.data_write_in(rb_data_write_to_reg),
		.data_read_out(rb_data_read_from_reg),
		.write_en(rb_write_en),
		.sys_cfg(sys_cfg)
	);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:86:1
	pwm pwm_inst(
		.clock_in(clk),
		.reset(!resetb),
		.duty_cycle(sys_cfg[13-:8]),
		.pwm_out(pwm_out)
	);
endmodule
