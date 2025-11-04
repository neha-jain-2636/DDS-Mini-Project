`timescale 1ns/1ps

module tb_quadratic_solver_all_bases;

    reg clk, reset, start;
    reg [8:0] A_in, B_in, C_in;

    wire [4:0] current_base;
    wire [7:0] out_root1_base, out_root2_base;
    wire out_root1_negative, out_root2_negative;
    wire out_roots_real, result_valid, finished;

    quadratic_solver_all_bases dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A_in(A_in),
        .B_in(B_in),
        .C_in(C_in),
        .current_base(current_base),
        .out_root1_base(out_root1_base),
        .out_root2_base(out_root2_base),
        .out_root1_negative(out_root1_negative),
        .out_root2_negative(out_root2_negative),
        .out_roots_real(out_roots_real),
        .result_valid(result_valid),
        .finished(finished)
    );

    // Clock (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("================================================================");
        $display("   | Time(ns) | Base | Sign | Root1 | Sign | Root2 | Real |");
        $display("----------------------------------------------------------------");
    end

    // Print only when result_valid = 1
    always @(posedge clk) begin
        if (result_valid) begin
            $display("   | %8t |  %2d  |  %b   |  %h   |  %b   |  %h   |   %b  |",
                $time,
                current_base,
                out_root1_negative,
                out_root1_base,
                out_root2_negative,
                out_root2_base,
                out_roots_real,
            );
        end
    end

    // Test case
    initial begin
        reset = 1;
        start = 0;
        // Example
        A_in = 9'b0_0000_0001;
        B_in = 9'b0_0001_0000;
        C_in = 9'b0_0010_0101;

        #20 reset = 0;
        #20 start = 1;
        #10 start = 0;

        wait (finished == 1);
        #50;

        $display("----------------------------------------------------------------");
        $display("  Simulation complete - all bases processed from minBase to 15");
        $display("================================================================");
        $finish;
    end

endmodule
