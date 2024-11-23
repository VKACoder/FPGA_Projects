module SerialAdder(
    input [3:0] a,
    input [3:0] b,
    input cin,
    input clk,
    input rst,
    input load,
    output reg [3:0] sum,
    output cout,
    output out
    );
    parameter C0 = 1'b 0, C1 = 1'b 1;
    
    wire clkout;
    ClkDiv FD(clk, 31'd 99999999, clkout);
    
    reg [3:0] A, B;
    reg [1:0] ind;
    reg start, pstate, nstate, op1, op2;
    
    assign out = (ind == 2'b 11);
    assign cout = out ? nstate : 1'b 0;
        
    always @ (posedge clkout, negedge rst)
    begin
        if (!rst)
        begin
            sum <= 4'b 0;
            start <= 1'b 0;
            pstate <= C0;
        end        
        else
        begin
//            A <= (load && !start) ? a : A >> 1;
//            B <= (load && !start) ? b : B >> 1;
//            start <= load ? 1'b 1 : start;
//            start <= (load && !start) ? cin : nstate;
            if (load && !start)
            begin
                A <= a;
                B <= b;
                start <= 1'b 1;
                pstate <= cin;
            end
            else
            begin
                pstate <= nstate;
                op1 <= A[0];
                op2 <= B[0];
                A <= A >> 1;
                B <= B >> 1;
            end
        end
    end
    
    always @ (pstate)
    begin
        if (start)
        begin
            sum[ind] <= op1 + op2;
            ind <= ind + 1;
            case (pstate)
                1'b 0:
                begin
                    nstate <= {op1, op2} == 2'b 11 ? C1 : C0; 
                end
                1'b 1:
                begin
                    nstate <= {op1, op2} == 2'b 00 ? C0 : C1;
                end
            endcase
        end
    end
endmodule
