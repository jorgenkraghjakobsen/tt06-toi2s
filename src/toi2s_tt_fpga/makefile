# Makescript from fpga_template - Addapted for TT06_toi2a project 
# Handling sv2v conversion out of the TT build script 

BOARD 		= tangnano9k
BOARD_DIR	= toi2s_tt_fpga/tangnano9k
FAMILY		= GW1N-9C
DEVICE		= GW1NR-LV9QN88PC6/I5

PRO=toi2s_tt_fpga

WS 			= $(shell cd ../.. ; pwd )
OBJ 		= $(WS)/obj/$(PRO)

SRC_INC 	= $(WS)/src
PKG 		= $(WS)/src/rb_toi2s/rb_toi2s_struct.svh

.PHONY: $(OBJ)
# Create Object build dir
$(OBJ):
	mkdir -p $@

SRC_LIST = \
src/amp_if/amp_if.sv \
src/amp_if/amp_i2c_master.sv \
src/amp_if/amp_state_control.v \
src/amp_if/clk_div.v \
src/amp_if/timer_simple.v \
src/amp_if/spdif_decoder.v \
src/pwm/pwm.v \
src/i2c_if/i2c_if_no_bidir.v \
src/i2c_if/i2cSlave_define.v \
src/i2c_if/serialInterface.v \
src/i2c_if/timescale.v \
src/rb_toi2s/rb_toi2s.sv \
src/toi2s_tt_top/toi2s_tt_top.sv \
src/toi2s_tt_fpga/toi2s_tt_fpga.sv 


SRC = $(addprefix $(WS)/, $(SRC_LIST) )
SRC_SV = $(filter %.sv ,$(SRC))
SRC_V  = $(filter %.v ,$(SRC))
SRC_CONV = $(addsuffix .conv.v,$(SRC_SV))

ttlinter: $(SRC)
	cd $(WS) ;\
	verilator -Wall --lint-only --Wno-DECLFILENAME \
	--top-module toi2s_tt_top \
	$(SRC_V) $(SRC_CONV) -Wno-fatal --relative-includes > lint.log 


register_bank: $(WS)/src/rb_toi2s/register_bank.go
	cd ../rb_toi2s ;\
	make 

$(WS)/src/rb_toi2s/rb_toi2s.sv: $(WS)/src/rb_toi2s/register_bank.go 
	cd ../rb_toi2s ;\
	make 

test:
	@echo $(SRC_CONV)


conv2v: $(SRC_SV)
	$(foreach s,$(SRC_SV),\
	 $(shell sv2v -v -I$(WS)/digital --siloed $(PKG) $(s) > $(s).conv.v ) \
	 $(info Converting systemverilog $(s) : ))

src: 
	@echo $(SRC_SV)

$(OBJ)/$(PRO).json: conv2v $(OBJ) $(SRC) 
	cd $(OBJ) ;\
	echo "#Yosys build script" > yosys.cmd ;\
	echo "verilog_defaults -add -I $(SRC_INC)" >> yosys.cmd ;\
	echo "read_verilog $(SRC_V) $(SRC_CONV)" >> yosys.cmd ;\
	echo "synth_gowin -top $(PRO) -json $(PRO).json" >> yosys.cmd ;\
	yosys -s yosys.cmd

# Place and Route
$(OBJ)/$(PRO)_pnr.json: $(OBJ)/$(PRO).json
	cd $(OBJ) ;\
	nextpnr-himbaechel --json $(PRO).json --write $(PRO)_pnr.json \
	--device ${DEVICE} --vopt family=${FAMILY} --vopt cst=$(WS)/src/$(BOARD_DIR).cst


$(OBJ)/$(PRO).fs: $(OBJ)/$(PRO)_pnr.json
	cd $(OBJ) ;\
	gowin_pack -d ${FAMILY} -o $(PRO).fs $(PRO)_pnr.json

# Flash to Eprom and reboot
flash: $(OBJ)/$(PRO).fs
	openFPGALoader -d /dev/ttyUSB1 -b ${BOARD} -f $(OBJ)/$(PRO).fs

# Load bit stream to device no -f
load_and_build: $(OBJ)/$(PRO).fs
	sudo openFPGALoader -d /dev/ttyUSB1 -b ${BOARD} $(OBJ)/$(PRO).fs

load: 
	sudo openFPGALoader -d /dev/ttyUSB1 -b ${BOARD} $(OBJ)/$(PRO).fs


clean:
	rm -rf $(OBJ)
