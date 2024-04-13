module amp_i2s_interface (
        input clk_in,
        input resetb,
        input rx_in,
        output i2s_bck,
        output i2s_ws,
        output i2s_d0, 
        output audio_locked );
    
    wire clk;
    clk_div #(.DIV(3)) div(clk_in,resetb,clk); 
    
    reg [6:0] sine_index, sine_index_next ; 
    reg [5:0] i2s_cnt;
    reg i2s_d0_delayed , i2s_d0_next; 
    //reg i2s_ws ; 
    //reg i2s_d0; 

    
    wire [15:0] pcm;
    wire [31:0] ppcm; 
    assign ppcm = { pcm , 16'h0000 };     
    
    rom_sine sine(sine_index, clk, 1'b1, ~resetb, pcm );
    
    
    //reg [31:0] rx_reg;
    always @(posedge clk) 
     begin
       if (!resetb) 
       begin
         //rx_reg <= 0;
         i2s_cnt <= 0;    
       end
       else 
       begin 
         //rx_reg <= { rx_reg[30:0], rx_in };
         i2s_cnt    <= i2s_cnt - 6'b000001;  
         sine_index <= sine_index_next;  
         i2s_d0_delayed <= i2s_d0_next;  
       end
     end
    
    always @* 
    begin 
      if (i2s_cnt == 6'b100001)  
        sine_index_next = sine_index + 7'b0000001;   
      i2s_d0_next = ppcm[i2s_cnt];
    end    

    assign audio_locked = 1; //  (rx_reg == 16'h0000) ? 1'b0 : 1'b1; 
    
    assign i2s_bck = ~clk; 
    assign i2s_ws  = i2s_cnt[5]; 
    assign i2s_d0  = i2s_d0_delayed;

endmodule    


