module and_beh_before (
    input a, b,
    output reg y
);
    always @(*)
        #3 y = a & b;
    
endmodule