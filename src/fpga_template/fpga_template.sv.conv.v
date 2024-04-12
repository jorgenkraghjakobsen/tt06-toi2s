// removed package "fpga_template_pkg"
// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:4:1
// removed ["import fpga_template_pkg::*;"]
module fpga_template_top (
	clk,
	i2c_scl,
	i2c_sda,
	pwm_out,
	debug_led_pin,
	btn_s1_reset,
	btn_s2,
	gnd0
);
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:8:5
	input clk;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:10:5
	input i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:11:5
	inout i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:13:5
	output wire pwm_out;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:15:5
	output wire [5:0] debug_led_pin;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:16:5
	input btn_s1_reset;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:17:5
	input btn_s2;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:19:5
	output wire gnd0;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:22:1
	assign gnd0 = 1'b0;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:23:1
	// removed localparam type fpga_template_pkg_rb_sys_cfg_wire_t
	wire [16:0] sys_cfg;
	assign debug_led_pin = sys_cfg[5-:6];
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:29:1
	wire resetb;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:30:1
	assign resetb = btn_s1_reset;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:37:1
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:42:1
	wire [7:0] rb_address;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:43:1
	wire [7:0] rb_data_write_to_reg;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:44:1
	wire [7:0] rb_data_read_from_reg;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:45:1
	wire rb_reg_en;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:46:1
	wire rb_write_en;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:47:1
	wire [1:0] rb_streamSt_mon;
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:49:1
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
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:64:1
	rb_fpga_template rb_fpga_template_inst(
		.clk(clk),
		.resetb(resetb),
		.address(rb_address),
		.data_write_in(rb_data_write_to_reg),
		.data_read_out(rb_data_read_from_reg),
		.write_en(rb_write_en),
		.sys_cfg(sys_cfg)
	);
	// Trace: /home/jakobsen/work/asic/workspace/fpga_template/digital/fpga_template/fpga_template.sv:77:1
	pwm pwm_inst(
		.clock_in(clk),
		.reset(!resetb),
		.duty_cycle(sys_cfg[13-:8]),
		.pwm_out(pwm_out)
	);
endmodule
