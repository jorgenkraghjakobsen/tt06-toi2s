# ICW Build system 
# Written by Jørgen Kragh Jakobsen, November 2021

#target = fpga_xo2
target = sim

pr  = ../..

block = amp_frontend

obj = $(pr)/obj/hdl/$(block)/$(target)
verilog_src = *.v 
verilog_src_tb = tb/$(block)_tb.v

all: obj synth sim wave 

#Create obj if not pressent 
obj:
	mkdir -p $(obj)
synth: 
	iverilog -o $(obj)/$(block).vvp $(verilog_src) $(verilog_src_tb) \
	-D 'DUMP_FILE_NAME="$(obj)/$(block).vcd"' -D 'FPGA' 

sim: 
	$(obj)/$(block).vvp	
wave:   
	gtkwave $(obj)/$(block).vcd -a $(obj)/$(block).gtkw -W    



# Specific implementation 

osim:
	iverilog -o tb clk_div.v amp_i2c_master.v \
	               timer_simple.v amp_state_control.v \
				   amp_i2s_interface.v \
				   amp_frontend.v amp_frontend_tb.v ;\
	./tb ; \
	gtkwave amp_frontend.vcd -a amp_frontend.gtkw -W 


osim_i2c:
	iverilog -o tb clk_div.v amp_i2c_master.v amp_i2c_master_tb.v ;\
	./tb ; \
	gtkwave amp_i2c_master.vcd -a i2c_wave.gtkw -W 


osim_ctrl:
	iverilog -o tb timer_simple.v amp_state_control.v amp_state_control_tb.v ;\
	./tb ; \
	gtkwave amp_state_control.vcd -a i2c_wave.gtkw -W 
	
	
	
