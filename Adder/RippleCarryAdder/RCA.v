module RippleAdder(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
    );
    wire [4:0] carry;
    assign carry[0] = cin;
    assign cout = carry[4];
    genvar i;
    generate
        for (i = 0; i <= 3; i = i + 1)
        begin
            FullAdder FA(a[i], b[i], carry[i], sum[i], carry[i + 1]);
        end
    endgenerate
endmodule
