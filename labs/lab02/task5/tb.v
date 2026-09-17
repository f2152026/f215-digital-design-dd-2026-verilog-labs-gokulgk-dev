module tb;
    reg [3:0] t_a, t_b, exp_result;
    reg t_op;
    wire [3:0] t_result;

    alu DUT (.a(t_a), .b(t_b), .op(t_op), .result(t_result));

    always @(t_a,t_b,t_op) begin
        if (t_op)
            exp_result = t_a + ~t_b + 1'b1;
        else
            exp_result = t_a + t_b;
        #1 if (exp_result !== t_result)
            $display($time, " FAILED: t_a=%b,t_b=%b,t_op=%b GAVE t_result=%b, EXPECTED exp_result=%b", t_a, t_b, t_op, t_result, exp_result);
        else
            $display($time, " t_a=%b, t_b=%b, t_op=%b | t_result=%b | PASSED", t_a, t_b, t_op, t_result);
    end

    initial begin
        t_a = 4'd5; t_b = 4'd1; t_op = 1'b0;
        #5 t_a = 4'd5; t_b = 4'd1; t_op = 1'b1;
        #5 t_a = 4'd1; t_b = 4'd5; t_op = 1'b0;
        #5 t_a = 4'd1; t_b = 4'd5; t_op = 1'b1;
        #5 t_a = 4'd12; t_b = 4'd6; t_op = 1'b1;
        #5 $finish;
    end

endmodule