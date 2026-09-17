module and_beh_intra (
    input a, b,
    output reg y
);

    always @(*)
        y = #3 a & b;

endmodule
