module pwm(
    input clock_in,         // Input clock on FPGA
    input reset,            // Reset signal
    input [7:0] duty_cycle, // Duty cycle of the output clock
    output pwm_out          // pwm_output signal  
);

reg [7:0] counter;
reg pwm = 1'b0;

always @(posedge clock_in or posedge reset) begin
    if (reset) begin
        counter <= 0;
        pwm <= 0;
    end else begin
        if (counter < 255) begin
            counter <= counter + 1;
            pwm <= !(counter < duty_cycle);
        end else begin
            counter <= 0;
            pwm <= 0;
        end
    end
end

assign pwm_out = !pwm;

endmodule
