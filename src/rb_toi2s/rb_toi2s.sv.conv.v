// removed package "toi2s_pkg"
// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:7:1
// removed ["import toi2s_pkg::*;"]
module rb_toi2s (
	clk,
	resetb,
	address,
	data_write_in,
	data_read_out,
	reg_en,
	write_en,
	sys_cfg,
	dsp_cfg
);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:10:13
	parameter ADR_BITS = 8;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:13:2
	input wire clk;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:14:2
	input wire resetb;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:15:2
	input wire [ADR_BITS - 1:0] address;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:16:2
	input wire [7:0] data_write_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:17:2
	output reg [7:0] data_read_out;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:18:2
	input wire reg_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:19:2
	input wire write_en;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:21:2
	// removed localparam type toi2s_pkg_rb_sys_cfg_wire_t
	inout wire [16:0] sys_cfg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:22:2
	// removed localparam type toi2s_pkg_rb_dsp_cfg_wire_t
	inout wire [7:0] dsp_cfg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:28:1
	reg reg__sys_cfg__enable_stuf;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:29:1
	reg reg__sys_cfg__enable_other;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:30:1
	reg [7:0] reg__sys_cfg__pwm_duty;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:31:1
	reg [5:0] reg__sys_cfg__debug_led;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:34:1
	reg reg__dsp_cfg__bypass_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:35:1
	reg reg__dsp_cfg__dc_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:36:1
	reg reg__dsp_cfg__bp_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:37:1
	reg reg__dsp_cfg__dec_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:38:1
	reg reg__dsp_cfg__pli_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:39:1
	reg reg__dsp_cfg__placeholder1;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:40:1
	reg reg__dsp_cfg__placeholder2;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:41:1
	reg reg__dsp_cfg__placeholder3;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:43:1
	always @(posedge clk)
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:45:3
		if (resetb == 0) begin
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:49:5
			reg__sys_cfg__enable_stuf <= 1'b0;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:50:5
			reg__sys_cfg__enable_other <= 1'b1;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:51:5
			reg__sys_cfg__pwm_duty <= 8'b10000101;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:52:5
			reg__sys_cfg__debug_led <= 6'b010101;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:55:5
			reg__dsp_cfg__bypass_enable <= 1'b1;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:56:5
			reg__dsp_cfg__dc_filter_enable <= 1'b1;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:57:5
			reg__dsp_cfg__bp_filter_enable <= 1'b1;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:58:5
			reg__dsp_cfg__dec_filter_enable <= 1'b1;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:59:5
			reg__dsp_cfg__pli_filter_enable <= 1'b1;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:60:5
			reg__dsp_cfg__placeholder1 <= 1'b0;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:61:5
			reg__dsp_cfg__placeholder2 <= 1'b0;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:62:5
			reg__dsp_cfg__placeholder3 <= 1'b0;
		end
		else
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:66:5
			if (write_en)
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:68:7
				case (address)
					0: begin
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:70:15
						reg__sys_cfg__enable_stuf <= data_write_in[0:0];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:71:15
						reg__sys_cfg__enable_other <= data_write_in[1:1];
					end
					1:
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:73:15
						reg__sys_cfg__pwm_duty <= data_write_in[7:0];
					2:
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:75:15
						reg__sys_cfg__debug_led <= data_write_in[5:0];
					64: begin
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:78:15
						reg__dsp_cfg__bypass_enable <= data_write_in[0:0];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:79:15
						reg__dsp_cfg__dc_filter_enable <= data_write_in[1:1];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:80:15
						reg__dsp_cfg__bp_filter_enable <= data_write_in[2:2];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:81:15
						reg__dsp_cfg__dec_filter_enable <= data_write_in[3:3];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:82:15
						reg__dsp_cfg__pli_filter_enable <= data_write_in[4:4];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:83:15
						reg__dsp_cfg__placeholder1 <= data_write_in[5:5];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:84:15
						reg__dsp_cfg__placeholder2 <= data_write_in[6:6];
						// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:85:15
						reg__dsp_cfg__placeholder3 <= data_write_in[7:7];
					end
				endcase
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:92:1
	always @(posedge clk)
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:94:3
		if (resetb == 0)
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:95:5
			data_read_out <= 8'b00000000;
		else begin
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:98:5
			data_read_out <= 8'b00000000;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:99:5
			case (address)
				0: begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:101:15
					data_read_out[0:0] <= reg__sys_cfg__enable_stuf;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:102:15
					data_read_out[1:1] <= reg__sys_cfg__enable_other;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:103:15
					data_read_out[2:2] <= sys_cfg[14];
				end
				1:
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:105:15
					data_read_out[7:0] <= reg__sys_cfg__pwm_duty;
				2:
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:107:15
					data_read_out[5:0] <= reg__sys_cfg__debug_led;
				64: begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:110:15
					data_read_out[0:0] <= reg__dsp_cfg__bypass_enable;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:111:15
					data_read_out[1:1] <= reg__dsp_cfg__dc_filter_enable;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:112:15
					data_read_out[2:2] <= reg__dsp_cfg__bp_filter_enable;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:113:15
					data_read_out[3:3] <= reg__dsp_cfg__dec_filter_enable;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:114:15
					data_read_out[4:4] <= reg__dsp_cfg__pli_filter_enable;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:115:15
					data_read_out[5:5] <= reg__dsp_cfg__placeholder1;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:116:15
					data_read_out[6:6] <= reg__dsp_cfg__placeholder2;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:117:15
					data_read_out[7:7] <= reg__dsp_cfg__placeholder3;
				end
				default:
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:119:17
					data_read_out <= 8'b00000000;
			endcase
		end
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:124:1
	assign sys_cfg[16] = reg__sys_cfg__enable_stuf;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:125:1
	assign sys_cfg[15] = reg__sys_cfg__enable_other;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:126:1
	assign sys_cfg[13-:8] = reg__sys_cfg__pwm_duty;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:127:1
	assign sys_cfg[5-:6] = reg__sys_cfg__debug_led;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:128:1
	assign dsp_cfg[7] = reg__dsp_cfg__bypass_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:129:1
	assign dsp_cfg[6] = reg__dsp_cfg__dc_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:130:1
	assign dsp_cfg[5] = reg__dsp_cfg__bp_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:131:1
	assign dsp_cfg[4] = reg__dsp_cfg__dec_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:132:1
	assign dsp_cfg[3] = reg__dsp_cfg__pli_filter_enable;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:133:1
	assign dsp_cfg[2] = reg__dsp_cfg__placeholder1;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:134:1
	assign dsp_cfg[1] = reg__dsp_cfg__placeholder2;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/rb_toi2s/rb_toi2s.sv:135:1
	assign dsp_cfg[0] = reg__dsp_cfg__placeholder3;
endmodule
