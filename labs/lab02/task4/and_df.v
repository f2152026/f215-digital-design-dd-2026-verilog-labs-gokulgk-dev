module and_df (
    input a, b,
    output y
);
    assign #3 y = a & b;
endmodule