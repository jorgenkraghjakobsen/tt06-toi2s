// removed package "toi2s_pkg"
// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:4:1
// removed ["import toi2s_pkg::*;"]
module toi2s_tt_fpga (
	clk,
	resetb,
	ena,
	i2c_scl,
	i2c_sda,
	rx_in,
	amp_i2s_bck,
	amp_i2s_ws,
	amp_i2s_d0,
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
	input resetb;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:10:5
	input ena;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:12:5
	input i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:13:5
	inout i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:15:5
	input rx_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:17:5
	output wire amp_i2s_bck;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:18:5
	output wire amp_i2s_ws;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:19:5
	output wire amp_i2s_d0;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:20:5
	output wire amp_i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:21:5
	inout amp_i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:22:5
	output wire amp_nenable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:23:5
	output wire amp_mute;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:26:5
	output wire pwm_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:29:5
	output wire [5:0] debug_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:30:5
	input debug_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:33:1
	// removed localparam type toi2s_pkg_rb_sys_cfg_wire_t
	wire [16:0] sys_cfg;
	assign debug_out = sys_cfg[5-:6];
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:46:1
	assign amp_mute = 1'b0;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:47:1
	assign amp_nenable = 1'b1;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:48:1
	assign amp_i2c_scl = 1'b1;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:49:1
	assign amp_i2c_sda = 1'bz;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:50:1
	wire amd_i2s_bck;
	assign amd_i2s_bck = 1'b0;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:51:1
	wire amd_i2s_ws;
	assign amd_i2s_ws = 1'b0;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:52:1
	wire amd_i2s_d0;
	assign amd_i2s_d0 = 1'b0;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:59:1
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:64:1
	wire [7:0] rb_address;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:65:1
	wire [7:0] rb_data_write_to_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:66:1
	wire [7:0] rb_data_read_from_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:67:1
	wire rb_reg_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:68:1
	wire rb_write_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:69:1
	wire [1:0] rb_streamSt_mon;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:71:1
	wire i2c_sdai;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:72:1
	wire i2c_sdao;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:74:1
	assign i2c_sda = (i2c_sdao == 1'b0 ? 1'b0 : 1'bz);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:75:1
	assign i2c_sdai = i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:78:1
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
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:94:1
	rb_toi2s rb_toi2s_inst(
		.clk(clk),
		.resetb(resetb),
		.address(rb_address),
		.data_write_in(rb_data_write_to_reg),
		.data_read_out(rb_data_read_from_reg),
		.write_en(rb_write_en),
		.sys_cfg(sys_cfg)
	);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/toi2s_tt_fpga/toi2s_tt_fpga.sv:107:1
	pwm pwm_inst(
		.clock_in(clk),
		.reset(!resetb),
		.duty_cycle(sys_cfg[13-:8]),
		.pwm_out(pwm_out)
	);
endmodule
