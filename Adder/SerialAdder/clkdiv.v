module ClkDiv(
    input clk,
    input [31:0] h_period,
    output clkout
    );
    reg clkout = 0;
    integer count = 0;
    always @ (posedge clk)
    begin
        count = count + 1;
        if (count == h_period)
        begin
            clkout = ~clkout;
            count = 0;
        end
    end
endmodule
