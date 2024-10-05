module ClkDiv(
    input clk,
    output clkout
    );
    reg clkout = 0;
    integer count = 0;
    always @ (posedge clk)
    begin
        count = count + 1;
        if (count == 99999999)
        begin
            clkout = ~clkout;
            count = 0;
        end
    end
endmodule
