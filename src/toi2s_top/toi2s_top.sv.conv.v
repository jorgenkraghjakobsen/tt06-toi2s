// removed package "toi2s_pkg"
// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:4:1
// removed ["import toi2s_pkg::*;"]
module toi2s_top (
	clk,
	reset,
	i2c_scl,
	i2c_sda,
	rxin,
	pwm_out,
	debug_out,
	debug_in
);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:8:5
	input clk;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:9:5
	input reset;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:11:5
	input i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:12:5
	inout i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:14:5
	input rxin;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:16:5
	output wire pwm_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:19:5
	output wire [5:0] debug_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:20:5
	input debug_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:23:1
	// removed localparam type toi2s_pkg_rb_sys_cfg_wire_t
	wire [16:0] sys_cfg;
	assign debug_out = sys_cfg[5-:6];
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:29:1
	wire resetb;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:30:1
	assign resetb = reset;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:37:1
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:42:1
	wire [7:0] rb_address;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:43:1
	wire [7:0] rb_data_write_to_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:44:1
	wire [7:0] rb_data_read_from_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:45:1
	wire rb_reg_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:46:1
	wire rb_write_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:47:1
	wire [1:0] rb_streamSt_mon;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:49:1
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
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:64:1
	rb_toi2s rb_toi2s_inst(
		.clk(clk),
		.resetb(resetb),
		.address(rb_address),
		.data_write_in(rb_data_write_to_reg),
		.data_read_out(rb_data_read_from_reg),
		.write_en(rb_write_en),
		.sys_cfg(sys_cfg)
	);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_top/toi2s_top.sv:77:1
	pwm pwm_inst(
		.clock_in(clk),
		.reset(!resetb),
		.duty_cycle(sys_cfg[13-:8]),
		.pwm_out(pwm_out)
	);
endmodule
