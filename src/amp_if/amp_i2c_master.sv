// Simple hardcoded I2C interface for Merus Gen1 amps 
// 
// On send_config asserted the module will send the i2c 
// command stored in bootmem

// The bootmem program is constructed from following 4 opcodes:
//    Opcode      [Arguments]  :  Function    
// -------------------------------------------------------------------------------
// 8'b0xxx_xxxx  8'byyyy_yyyy  :  Write single byte yyyy_yyyy to address xxx_xxxx 
//                             :  at given page  
// 8'b10xx_xxxx                :  Set page xx_xxxx << 7      
// 8'b110x_xxxx  8'byyyy_yyyy  :  Block write x_xxxx bytes to address yyyy_yyyy 
//               8'bzzzz_zzzz  :  
// 0'b1111_1111                :  End of data
// -------------------------------------------------------------------------------

// Written by Jørgen Kragh Jakobsen, IC Works 
// Copyright 2022
import toi2s_pkg::*; 

module amp_i2c_master (
    input clk_in,
    input resetb,
    inout rb_amp_cfg_wire_t amp_cfg, 
    input send_cfg, 
    input sdai,
    output sdao, 
    output scl); 


reg [7:0] opcode_mux; 
always @(*)
begin 
  case (boot_index) 
    3'b000: opcode_mux = amp_cfg.bootmem0; 
    3'b001: opcode_mux = amp_cfg.bootmem1;   // setting 0x30
    3'b010: opcode_mux = amp_cfg.bootmem2;   // Set Input format   
    3'b011: opcode_mux = amp_cfg.bootmem3;   // I2S standard
    3'b100: opcode_mux = amp_cfg.bootmem4;   // Free  
    3'b101: opcode_mux = amp_cfg.bootmem5;   // Free
    3'b110: opcode_mux = amp_cfg.bootmem6;   // Free  
    3'b111: opcode_mux = amp_cfg.bootmem7;   // Free
  endcase
end 

/*
reg [7:0] bootmem [7:0]; 
initial begin
    bootmem[0] = 8'h40;           // Set Master volume  
    bootmem[1] = 8'h18;           // setting 0x30
    bootmem[2] = 8'd53;           // Set Input format   
    bootmem[3] = 8'h08;           // I2S standard
    bootmem[4] = 8'hff;           // Free  
    bootmem[5] = 8'hff;           // Free
    bootmem[6] = 8'hff;           // Free  
    bootmem[7] = 8'hff;           // Free
end 
*/     
   localparam [3:0] 
        INIT_ST                = 0,
        INIT_I2C_ST            = 1,
        WAIT_TRIGGER_ST        = 2, 
        SEND_I2C_START_ST      = 3, 
        SEND_I2C_ADR_ST        = 4,
        LOAD_CMD_ST            = 5, 
        DECODE_CMD_ST          = 6,
        SEND_ADR_MSB_ST        = 7,
        SEND_ADR_LSB_ST        = 8, 
        LOAD_DATA_ST           = 9, 
        SEND_DATA_ST           = 10,
        SEND_I2C_STOP_ST       = 11,
        SET_OFFSET_ST          = 12,
        DONE_ST                = 13; 

   wire clk;
   clk_div #(.DIV(5)) div (clk_in,resetb,clk);

   wire [7:0] opcode; 
   assign opcode = opcode_mux;
   reg [2:0] boot_index, boot_next; 
   reg [3:0] state_reg , next_reg; 
   reg [5:0] i2c_cnt , next_cnt;

   reg i2c_scl, i2c_scl_next;
   reg i2c_sda, i2c_sda_next;  
  
   assign sdao = i2c_sda; 
   //!i2c_sda ? 1'b0 : 1'bz; 
   assign scl = i2c_scl;
   //!i2c_scl ? 1'b0 : 1'bz;  

   wire [6:0] i2c_address; 
   assign i2c_address = 7'b0100000;  

   //assign opcode = bootmem[boot_index];  
  
   assign amp_cfg.status[7:4] = state_reg; 
   
   wire resend_cfg;
   reg resend_cfg_next; 
   
   always @(posedge clk) 
     resend_cfg_next <= amp_cfg.amp_init;


   assign resend_cfg = !resend_cfg_next & amp_cfg.amp_init ;

   always @(posedge clk) 
    begin
    if (!resetb) 
    begin
      state_reg  <= INIT_ST; 
      boot_index <= 3'b000;
      i2c_cnt    <= 6'b000000;
      i2c_scl    <= 1;
      i2c_sda    <= 1;
    end
    else 
    begin 
      state_reg  <= next_reg; 
      i2c_cnt    <= next_cnt;
      boot_index <= boot_next; 
      i2c_scl    <= i2c_scl_next; 
      i2c_sda    <= i2c_sda_next; 
    end
   end
   
   always @(*) 
   begin
    boot_next <= boot_index;
    next_reg  <= state_reg;
    next_cnt  <= i2c_cnt - 6'b1 ;
    i2c_scl_next  <= i2c_scl;
    i2c_sda_next  <= i2c_sda;
     
    case (state_reg) 
       
      INIT_ST:
        begin
            boot_next     <= 3'b000;
            i2c_sda_next  <= 1; 
            i2c_scl_next  <= 1;
            next_reg      <=  WAIT_TRIGGER_ST; 
        end 
      WAIT_TRIGGER_ST: 
        begin 
            boot_next     <= 3'b0;  
            i2c_sda_next  <= 1; 
            i2c_scl_next  <= 1; 
            if (send_cfg) 
                next_reg  <= LOAD_CMD_ST; 
        end     
      LOAD_CMD_ST: 
        begin
             i2c_sda_next  <= 1; 
             i2c_scl_next  <= 1; 
         
           if (opcode[7] == 1'b0 ) 
            begin
        
              next_reg     <= SEND_I2C_START_ST; 
            end
           else if (opcode[7:6] == 2'b10) 
           begin
             boot_next  <= boot_index + 3'h1; 
             next_reg   <= LOAD_CMD_ST; 
           end
           else if (opcode[7:5] == 3'b110) // block write
              next_reg     <= SEND_I2C_START_ST; 
           else 
              next_reg     <= DONE_ST; 
        end 
      
      SEND_I2C_START_ST: 
        begin 
            i2c_sda_next      <= 0; 
            i2c_scl_next      <= 1; 
            next_reg     <= SEND_I2C_ADR_ST;
            next_cnt     <= 18*2;
         end 

      SEND_I2C_ADR_ST: 
        begin
          if (i2c_cnt == 0) 
          begin
            next_reg     <= SEND_ADR_LSB_ST;
            next_cnt     <= 18*2;
          end
          
          if (i2c_cnt > 6 ) 
            i2c_sda_next <= i2c_address[i2c_cnt[5:2]-2];
          else if (i2c_cnt > 4)
            i2c_sda_next <= 0;             // Write bit 
          else 
            i2c_sda_next <= 1;             // Ack bit 
          
          if (i2c_cnt[1:0] == 2'b00) 
             i2c_scl_next <= 0; 
          else if(i2c_cnt[1:0] == 2'b01)
             i2c_scl_next <= 1;
          else if(i2c_cnt[1:0] == 2'b10)
             i2c_scl_next <= 1;
          else if(i2c_cnt[1:0] == 2'b11)
             i2c_scl_next <= 0;
        end   

       SEND_ADR_LSB_ST:
        begin
          if (i2c_cnt == 0) 
          begin
            boot_next    <= boot_index + 3'b001;
            next_reg     <= SEND_DATA_ST;
            next_cnt     <= 18*2;
          end
          
          if (i2c_cnt > 2 ) 
            i2c_sda_next <= opcode[i2c_cnt[5:2]-1];
          else 
            i2c_sda_next <= 1;             // Ack bit 
          
          if (i2c_cnt[1:0] == 2'b00) 
             i2c_scl_next <= 0; 
          else if(i2c_cnt[1:0] == 2'b01)
             i2c_scl_next <= 1;
          else if(i2c_cnt[1:0] == 2'b10)
             i2c_scl_next <= 1;
          else if(i2c_cnt[1:0] == 2'b11)
             i2c_scl_next <= 0;
        end   
        
      LOAD_DATA_ST: 
      begin 
          next_reg     <= SEND_DATA_ST; 
          next_cnt     <= 20;
      end       

      SEND_DATA_ST:
      begin
          if (i2c_cnt == 0) 
          begin
            next_reg   <=  SEND_I2C_STOP_ST;
            next_cnt   <=  14;
            i2c_scl_next <= 1;
          end

          if (i2c_cnt > 2 ) 
            i2c_sda_next <= opcode[i2c_cnt[5:2]-1];
          else 
            i2c_sda_next <= 1;             // Ack bit 
          
          if (i2c_cnt[1:0] == 2'b00) 
             i2c_scl_next <= 0; 
          else if(i2c_cnt[1:0] == 2'b01)
             i2c_scl_next <= 1;
          else if(i2c_cnt[1:0] == 2'b10)
             i2c_scl_next <= 1;
          else if(i2c_cnt[1:0] == 2'b11)
             i2c_scl_next <= 0;
      end   

      SEND_I2C_STOP_ST:
      begin
         if (i2c_cnt == 0) 
         begin
            next_reg    <= LOAD_CMD_ST;
            boot_next    <= boot_index + 3'b001;
            i2c_sda_next <= 1;
            i2c_scl_next <= 1;
         end
         else if (i2c_cnt > 2 )     // Event bit 
         begin 
            i2c_scl_next <= 1;
            i2c_sda_next <= 0; 
         end
         else if (i2c_cnt == 1 )
         begin
            i2c_scl_next <= 1;
            i2c_sda_next <= 0; 
         end     
      end        
      DONE_ST:
      begin 
        i2c_scl_next <= 1; 
        i2c_sda_next <= 1;
        next_reg   <=  DONE_ST;
        if (resend_cfg) 
          next_reg <= INIT_ST;  
      end
    endcase
   end
endmodule
