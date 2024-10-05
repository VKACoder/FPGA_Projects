module counter(
    input clk,
    input rst,
    output reg [3:0] count
    );
    wire clkout;
    ClkDiv FD(clk, clkout); 
    always @ (posedge clkout, negedge rst)
    begin
        if (!rst)
            count <= 0;
        else
            count <= count + 1;
    end
endmodule
