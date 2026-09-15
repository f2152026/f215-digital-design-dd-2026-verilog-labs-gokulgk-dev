module tb;
    reg [1:0] t_a, t_b;
    wire t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq;

    assign exp_gt = (t_a > t_b);
    assign exp_lt = (t_a < t_b);
    assign exp_eq = (t_a == t_b);

    comp2 DUT (.A(t_a), .B(t_b), .EQ(t_eq), .GT(t_gt), .LT(t_lt));

    string vcd_file;
    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
          $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end

    integer errors = 0;
    always @(t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq) begin
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
            $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
            $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
            errors = errors + 1;
        end
        else begin
            $display($time, " t_a=%b, t_b=%b | t_gt=%b, t_lt=%b, t_eq=%b | PASSED", t_a, t_b, t_gt, t_lt, t_eq);
        end
    end

    initial begin
        t_a = 2'b00; t_b = 2'b00;
        #5 t_a = 2'b00; t_b = 2'b01;
        #5 t_a = 2'b00; t_b = 2'b10;
        #5 t_a = 2'b00; t_b = 2'b11;
        #5 t_a = 2'b01; t_b = 2'b00;
        #5 t_a = 2'b01; t_b = 2'b01;
        #5 t_a = 2'b01; t_b = 2'b10;
        #5 t_a = 2'b01; t_b = 2'b11;
        #5 t_a = 2'b10; t_b = 2'b00;
        #5 t_a = 2'b10; t_b = 2'b01;
        #5 t_a = 2'b10; t_b = 2'b10;
        #5 t_a = 2'b10; t_b = 2'b11;
        #5 t_a = 2'b11; t_b = 2'b00;
        #5 t_a = 2'b11; t_b = 2'b01;
        #5 t_a = 2'b11; t_b = 2'b10;
        #5 t_a = 2'b11; t_b = 2'b11;
        #5 if (errors == 0) begin
            $display("All 16 cases tested for ran successfully!");
        end
        else begin
            $display("%0d case(s) failed out of the 16 cases tested", errors);
        end
        #5 $finish;
    end
endmodule