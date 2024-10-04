module FullAdder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    xor s1(sum, a, b, cin);
    assign cout = (a & b) | (b & cin) | (cin & a);
endmodule
