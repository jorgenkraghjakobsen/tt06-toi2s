module spdif_decoder ( 
  input clk_in,   //! dsfsdf
  input resetb,
  input rx_in,
  output i2s_bck,
  output i2s_ws,
  output i2s_d0,
  output audio_locked,
  output edgedetect
);
  wire clk;
  assign clk = clk_in;
  

  assign audio_locked = 1'b1; 
  
  reg [3:0] correlator;

  always @(posedge clk)
  begin
    if (!resetb)
      correlator <= 4'b0000;
    else
      correlator <= {correlator[2:0], rx_in};
  end
  wire rxup,rxdown,rxedge;

  assign rxup   = rxedge & correlator[1];           // 100
  assign rxdown = rxedge & !correlator[1];          // 011 xxx not sign

  assign rxedge = (correlator[2] ^ correlator[1]);  // 100 or 011

  // Measure length between edge and store length and bitvalue
  // Generate bitclk for i2s_interface
  // Phase correct logic
