module blinker(
    input wire clk,
    input wire rst,
    output wire led);

reg [31:0] counter;
reg led_r;

assign led = led_r;

always @ (posedge clk) begin
    if (rst) begin
        counter <= 0;
        led_r <= 1'b0;
    end
    else begin
        counter <= counter + 1;
        if (counter == 99999999) begin
            counter <= 0;
            led_r <= !led_r; 
        end
    end
end

endmodule;