module UpDownCounter(
    input ctrl, 
    input clk,
    input rst,
    output reg [4:0] count
    );
    //ctrl = 0: Down counter
    //ctrl = 1: Up counter 
    wire clkout;
    ClkDiv FD(clk, clkout); 
    always @ (posedge clkout, negedge rst)
    begin
        if (!rst)
            count <= 0;
        else if (ctrl)
            count <= count + 1;
        else
            count <= count - 1;
    end
endmodule
