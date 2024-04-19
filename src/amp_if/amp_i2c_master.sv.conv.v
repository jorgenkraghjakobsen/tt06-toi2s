// removed package "toi2s_pkg"
// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:19:1
// removed ["import toi2s_pkg::*;"]
module amp_i2c_master (
	clk_in,
	resetb,
	amp_cfg,
	send_cfg,
	sdai,
	sdao,
	scl
);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:22:5
	input clk_in;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:23:5
	input resetb;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:24:5
	// removed localparam type toi2s_pkg_rb_amp_cfg_wire_t
	inout wire [72:0] amp_cfg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:25:5
	input send_cfg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:26:5
	input sdai;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:27:5
	output wire sdao;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:28:5
	output wire scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:31:1
	wire [7:0] opcode;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:32:1
	reg [2:0] boot_index;
	always @(*)
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:34:3
		case (boot_index)
			3'b000:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:35:13
				opcode = amp_cfg[63-:8];
			3'b001:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:36:13
				opcode = amp_cfg[55-:8];
			3'b010:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:37:13
				opcode = amp_cfg[47-:8];
			3'b011:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:38:13
				opcode = amp_cfg[39-:8];
			3'b100:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:39:13
				opcode = amp_cfg[31-:8];
			3'b101:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:40:13
				opcode = amp_cfg[23-:8];
			3'b110:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:41:13
				opcode = amp_cfg[15-:8];
			3'b111:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:42:13
				opcode = amp_cfg[7-:8];
		endcase
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:58:4
	localparam [3:0] INIT_ST = 0;
	localparam [3:0] INIT_I2C_ST = 1;
	localparam [3:0] WAIT_TRIGGER_ST = 2;
	localparam [3:0] SEND_I2C_START_ST = 3;
	localparam [3:0] SEND_I2C_ADR_ST = 4;
	localparam [3:0] LOAD_CMD_ST = 5;
	localparam [3:0] DECODE_CMD_ST = 6;
	localparam [3:0] SEND_ADR_MSB_ST = 7;
	localparam [3:0] SEND_ADR_LSB_ST = 8;
	localparam [3:0] LOAD_DATA_ST = 9;
	localparam [3:0] SEND_DATA_ST = 10;
	localparam [3:0] SEND_I2C_STOP_ST = 11;
	localparam [3:0] SET_OFFSET_ST = 12;
	localparam [3:0] DONE_ST = 13;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:74:4
	wire clk;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:75:4
	clk_div #(.DIV(5)) div(
		clk_in,
		resetb,
		clk
	);
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:77:4
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:78:4
	reg [2:0] boot_next;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:79:4
	reg [3:0] state_reg;
	reg [3:0] next_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:80:4
	reg [5:0] i2c_cnt;
	reg [5:0] next_cnt;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:82:4
	reg i2c_scl;
	reg i2c_scl_next;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:83:4
	reg i2c_sda;
	reg i2c_sda_next;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:85:4
	assign sdao = i2c_sda;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:87:4
	assign scl = i2c_scl;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:90:4
	wire [6:0] i2c_address;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:91:4
	assign i2c_address = 7'b0100000;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:95:4
	assign amp_cfg[72:69] = state_reg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:97:4
	wire resend_cfg;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:98:4
	reg resend_cfg_next;
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:100:4
	always @(posedge clk)
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:101:6
		resend_cfg_next <= amp_cfg[64];
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:104:4
	assign resend_cfg = !resend_cfg_next & amp_cfg[64];
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:106:4
	always @(posedge clk)
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:108:5
		if (!resetb) begin
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:110:7
			state_reg <= INIT_ST;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:111:7
			boot_index <= 3'b000;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:112:7
			i2c_cnt <= 6'b000000;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:113:7
			i2c_scl <= 1;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:114:7
			i2c_sda <= 1;
		end
		else begin
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:118:7
			state_reg <= next_reg;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:119:7
			i2c_cnt <= next_cnt;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:120:7
			boot_index <= boot_next;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:121:7
			i2c_scl <= i2c_scl_next;
			// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:122:7
			i2c_sda <= i2c_sda_next;
		end
	// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:126:4
	always @(*) begin
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:128:5
		boot_next <= boot_index;
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:129:5
		next_reg <= state_reg;
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:130:5
		next_cnt <= i2c_cnt - 6'b000001;
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:131:5
		i2c_scl_next <= i2c_scl;
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:132:5
		i2c_sda_next <= i2c_sda;
		// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:134:5
		case (state_reg)
			INIT_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:138:13
				boot_next <= 3'b000;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:139:13
				i2c_sda_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:140:13
				i2c_scl_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:141:13
				next_reg <= WAIT_TRIGGER_ST;
			end
			WAIT_TRIGGER_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:145:13
				boot_next <= 3'b000;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:146:13
				i2c_sda_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:147:13
				i2c_scl_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:148:13
				if (send_cfg)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:149:17
					next_reg <= LOAD_CMD_ST;
			end
			LOAD_CMD_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:153:14
				i2c_sda_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:154:14
				i2c_scl_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:156:12
				if (opcode[7] == 1'b0)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:159:15
					next_reg <= SEND_I2C_START_ST;
				else if (opcode[7:6] == 2'b10) begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:163:14
					boot_next <= boot_index + 3'h1;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:164:14
					next_reg <= LOAD_CMD_ST;
				end
				else if (opcode[7:5] == 3'b110)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:167:15
					next_reg <= SEND_I2C_START_ST;
				else
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:169:15
					next_reg <= DONE_ST;
			end
			SEND_I2C_START_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:174:13
				i2c_sda_next <= 0;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:175:13
				i2c_scl_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:176:13
				next_reg <= SEND_I2C_ADR_ST;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:177:13
				next_cnt <= 36;
			end
			SEND_I2C_ADR_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:182:11
				if (i2c_cnt == 0) begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:184:13
					next_reg <= SEND_ADR_LSB_ST;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:185:13
					next_cnt <= 36;
				end
				if (i2c_cnt > 6)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:189:13
					i2c_sda_next <= i2c_address[i2c_cnt[5:2] - 2];
				else if (i2c_cnt > 4)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:191:13
					i2c_sda_next <= 0;
				else
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:193:13
					i2c_sda_next <= 1;
				if (i2c_cnt[1:0] == 2'b00)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:196:14
					i2c_scl_next <= 0;
				else if (i2c_cnt[1:0] == 2'b01)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:198:14
					i2c_scl_next <= 1;
				else if (i2c_cnt[1:0] == 2'b10)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:200:14
					i2c_scl_next <= 1;
				else if (i2c_cnt[1:0] == 2'b11)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:202:14
					i2c_scl_next <= 0;
			end
			SEND_ADR_LSB_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:207:11
				if (i2c_cnt == 0) begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:209:13
					boot_next <= boot_index + 3'b001;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:210:13
					next_reg <= SEND_DATA_ST;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:211:13
					next_cnt <= 36;
				end
				if (i2c_cnt > 2)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:215:13
					i2c_sda_next <= opcode[i2c_cnt[5:2] - 1];
				else
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:217:13
					i2c_sda_next <= 1;
				if (i2c_cnt[1:0] == 2'b00)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:220:14
					i2c_scl_next <= 0;
				else if (i2c_cnt[1:0] == 2'b01)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:222:14
					i2c_scl_next <= 1;
				else if (i2c_cnt[1:0] == 2'b10)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:224:14
					i2c_scl_next <= 1;
				else if (i2c_cnt[1:0] == 2'b11)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:226:14
					i2c_scl_next <= 0;
			end
			LOAD_DATA_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:231:11
				next_reg <= SEND_DATA_ST;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:232:11
				next_cnt <= 20;
			end
			SEND_DATA_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:237:11
				if (i2c_cnt == 0) begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:239:13
					next_reg <= SEND_I2C_STOP_ST;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:240:13
					next_cnt <= 14;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:241:13
					i2c_scl_next <= 1;
				end
				if (i2c_cnt > 2)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:245:13
					i2c_sda_next <= opcode[i2c_cnt[5:2] - 1];
				else
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:247:13
					i2c_sda_next <= 1;
				if (i2c_cnt[1:0] == 2'b00)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:250:14
					i2c_scl_next <= 0;
				else if (i2c_cnt[1:0] == 2'b01)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:252:14
					i2c_scl_next <= 1;
				else if (i2c_cnt[1:0] == 2'b10)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:254:14
					i2c_scl_next <= 1;
				else if (i2c_cnt[1:0] == 2'b11)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:256:14
					i2c_scl_next <= 0;
			end
			SEND_I2C_STOP_ST:
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:261:10
				if (i2c_cnt == 0) begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:263:13
					next_reg <= LOAD_CMD_ST;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:264:13
					boot_next <= boot_index + 3'b001;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:265:13
					i2c_sda_next <= 1;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:266:13
					i2c_scl_next <= 1;
				end
				else if (i2c_cnt > 2) begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:270:13
					i2c_scl_next <= 1;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:271:13
					i2c_sda_next <= 0;
				end
				else if (i2c_cnt == 1) begin
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:275:13
					i2c_scl_next <= 1;
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:276:13
					i2c_sda_next <= 0;
				end
			DONE_ST: begin
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:281:9
				i2c_scl_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:282:9
				i2c_sda_next <= 1;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:283:9
				next_reg <= DONE_ST;
				// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:284:9
				if (resend_cfg)
					// Trace: /home/jakobsen/work/asic/workspace/tt06-toi2s/src/amp_if/amp_i2c_master.sv:285:11
					next_reg <= INIT_ST;
			end
		endcase
	end
endmodule
