`timescale 1ns/1ps

// ===================== 4-BIT COMPARATOR =====================
module comparator_4bit (
    input [3:0] A,
    input [3:0] B,
    output A_gt_B,
    output A_eq_B,
    output A_lt_B
);

    wire [3:0] xnor_out;    
    wire [3:0] A_gt_bit, A_lt_bit;

    // A = B for each bit (XNOR)
    xnor (xnor_out[3], A[3], B[3]);
    xnor (xnor_out[2], A[2], B[2]);
    xnor (xnor_out[1], A[1], B[1]);
    xnor (xnor_out[0], A[0], B[0]);

    // A > B for each bit (A & ~B)
    and (A_gt_bit[3], A[3], ~B[3]);
    and (A_gt_bit[2], A[2], ~B[2]);
    and (A_gt_bit[1], A[1], ~B[1]);
    and (A_gt_bit[0], A[0], ~B[0]);

    // A < B for each bit (~A & B)
    and (A_lt_bit[3], ~A[3], B[3]);
    and (A_lt_bit[2], ~A[2], B[2]);
    and (A_lt_bit[1], ~A[1], B[1]);
    and (A_lt_bit[0], ~A[0], B[0]);

    // Equality
    and (A_eq_B, xnor_out[3], xnor_out[2], xnor_out[1], xnor_out[0]);

    // Greater than (priority from MSB -> LSB)
    wire gt1, gt2, gt3, gt4;
    and (gt1, A_gt_bit[3]);                                            // A3>B3
    and (gt2, xnor_out[3], A_gt_bit[2]);                               // A3=B3 and A2>B2
    and (gt3, xnor_out[3], xnor_out[2], A_gt_bit[1]);                  // A3=B3, A2=B2, A1>B1
    and (gt4, xnor_out[3], xnor_out[2], xnor_out[1], A_gt_bit[0]);     // All higher bits equal, A0>B0
    or  (A_gt_B, gt1, gt2, gt3, gt4);

    // Lesser than
    wire lt1, lt2, lt3, lt4;
    and (lt1, A_lt_bit[3]);
    and (lt2, xnor_out[3], A_lt_bit[2]);
    and (lt3, xnor_out[3], xnor_out[2], A_lt_bit[1]);
    and (lt4, xnor_out[3], xnor_out[2], xnor_out[1], A_lt_bit[0]);
    or  (A_lt_B, lt1, lt2, lt3, lt4);

endmodule

// ===================== FULL ADDER =====================
module full_adder (
    input A, B, Cin,
    output Sum, Cout
);
    wire w1, w2, w3;
    xor (w1, A, B);
    xor (Sum, w1, Cin);      // S = A ^ B ^ Cin
    and (w2, A, B);
    and (w3, w1, Cin);
    or  (Cout, w2, w3);      // Cout = AB + (A ^ B)Cin
endmodule

// ===================== 4-BIT ADDER =====================
module adder_4bit (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);
    wire c1, c2, c3;
    full_adder fa0 (A[0], B[0], Cin,  Sum[0], c1);         //Sum = A + B
    full_adder fa1 (A[1], B[1], c1,   Sum[1], c2);         //Cout = Output carry
    full_adder fa2 (A[2], B[2], c2,   Sum[2], c3);         
    full_adder fa3 (A[3], B[3], c3,   Sum[3], Cout);       
endmodule

// ===================== 8-BIT ADDER =====================
module adder_8bit (
    input  [7:0] A,
    input  [7:0] B,
    output [7:0] S,
    output Cout
);
    wire c_low;
    adder_4bit add_low  (.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .Sum(S[3:0]), .Cout(c_low));
    adder_4bit add_high (.A(A[7:4]), .B(B[7:4]), .Cin(c_low), .Sum(S[7:4]), .Cout(Cout));
endmodule

// ===================== 4x4 MULTIPLIER =====================
module multiplier_4x4 (
    input  [3:0] A,
    input  [3:0] B,
    output [7:0] P
);
    wire [3:0] pp0, pp1, pp2, pp3;

    // Generate partial products
    and (pp0[0], A[0], B[0]);
    and (pp0[1], A[1], B[0]);
    and (pp0[2], A[2], B[0]);
    and (pp0[3], A[3], B[0]);

    and (pp1[0], A[0], B[1]);
    and (pp1[1], A[1], B[1]);
    and (pp1[2], A[2], B[1]);
    and (pp1[3], A[3], B[1]);

    and (pp2[0], A[0], B[2]);
    and (pp2[1], A[1], B[2]);
    and (pp2[2], A[2], B[2]);
    and (pp2[3], A[3], B[2]);

    and (pp3[0], A[0], B[3]);
    and (pp3[1], A[1], B[3]);
    and (pp3[2], A[2], B[3]);
    and (pp3[3], A[3], B[3]);

    // Left-shift partial products
    wire [7:0] p0 = {4'b0000, pp0};
    wire [7:0] p1 = {3'b000,  pp1, 1'b0};
    wire [7:0] p2 = {2'b00,   pp2, 2'b00};
    wire [7:0] p3 = {1'b0,    pp3, 3'b000};

    // Add them together using adder_8bit 
    wire [7:0] s01, s012, s0123;
    wire c01, c012, c0123;

    adder_8bit a01(.A(p0), .B(p1), .S(s01),   .Cout(c01));
    adder_8bit a012(.A(s01), .B(p2), .S(s012), .Cout(c012));
    adder_8bit a0123(.A(s012), .B(p3), .S(s0123), .Cout(c0123));

    assign P = s0123;
endmodule

// ===================== MAX SELECTOR USING COMPARATOR =====================
module max_4bit_using_comparator (
    input  [3:0] A1,
    input  [3:0] A2,
    output [3:0] MAX
);
    wire A_gt_B, A_eq_B, A_lt_B;
    wire A_ge_B;   // select line for MUX
    wire sel_n;    // inverted select

    comparator_4bit cmp (
        .A(A1),
        .B(A2),
        .A_gt_B(A_gt_B),
        .A_eq_B(A_eq_B),
        .A_lt_B(A_lt_B)
    );

    // --- Compute A >= B ---
    or (A_ge_B, A_gt_B, A_eq_B);
    not (sel_n, A_ge_B);

    // --- 4-bit 2:1 MUX ---
    and (and1_0, A1[0], A_ge_B);
    and (and2_0, A2[0], sel_n);
    or  (MAX[0], and1_0, and2_0);

    and (and1_1, A1[1], A_ge_B);
    and (and2_1, A2[1], sel_n);
    or  (MAX[1], and1_1, and2_1);

    and (and1_2, A1[2], A_ge_B);
    and (and2_2, A2[2], sel_n);
    or  (MAX[2], and1_2, and2_2);

    and (and1_3, A1[3], A_ge_B);
    and (and2_3, A2[3], sel_n);
    or  (MAX[3], and1_3, and2_3);
endmodule

// ===================== MINIMUM BASE CALCULATOR =====================
module min_base_from_three_inputs (
    input  [8:0] X,
    input  [8:0] Y,
    input  [8:0] Z,
    output [4:0] MIN_BASE
);
    wire [3:0] X1 = X[7:4];
    wire [3:0] X0 = X[3:0];
    wire [3:0] Y1 = Y[7:4];
    wire [3:0] Y0 = Y[3:0];
    wire [3:0] Z1 = Z[7:4];
    wire [3:0] Z0 = Z[3:0];

    wire [3:0] max1, max2, max3, max4, max_digit;
    wire [4:0] temp_base;
    wire carry_out;

    // Find max within each number
    max_4bit_using_comparator m1 (X1, X0, max1);
    max_4bit_using_comparator m2 (Y1, Y0, max2);
    max_4bit_using_comparator m3 (Z1, Z0, max3);

    // Combine across numbers
    max_4bit_using_comparator m4 (max1, max2, max4);
    max_4bit_using_comparator m5 (max4, max3, max_digit);

    // Add 1 to the largest digit
    adder_4bit add1 (
        .A(max_digit),
        .B(4'b0001),
        .Cin(1'b0),
        .Sum(MIN_BASE[3:0]),
        .Cout(MIN_BASE[4])
    );
endmodule

// ===================== Base to Decimal Converter (Gate-level) =====================
module base_to_decimal_converter_gate (
    input [3:0] digit_high,
    input [3:0] digit_low,
    input [3:0] base,
    output [7:0] decimal_value
);
    wire [7:0] mult_out;
    wire [7:0] low_ext = {4'b0000, digit_low};
    wire [3:0] sum_low, sum_high;
    wire c_low, c_high;
    
    //Multiply first digit with given base
    multiplier_4x4 mult(.A(digit_high), .B(base), .P(mult_out));
    
    //Add above product to second digit
    adder_4bit add_low(
        .A(mult_out[3:0]),
        .B(low_ext[3:0]),
        .Cin(1'b0),
        .Sum(sum_low),
        .Cout(c_low)
    );
    
    adder_4bit add_high(
        .A(mult_out[7:4]),
        .B(low_ext[7:4]),
        .Cin(c_low),
        .Sum(sum_high),
        .Cout(c_high)
    );
    
    assign decimal_value = {sum_high, sum_low};
endmodule

// ===================== Decimal to Base Converter (Gate-level, FSM) =====================
module decimal_to_base_converter_gate(
    input clk,
    input reset,
    input start,
    input [7:0] decimal_num,
    input [3:0] target_base,
    output [7:0] converted_num,
    output [3:0] digit1,
    output [3:0] digit0,
    output done
);
    reg [7:0] temp_num;
    reg [2:0] state;
    reg done_reg;
    reg [3:0] quot;
    reg [3:0] rem;
    
    parameter IDLE = 0, DIVIDE = 1, OUTPUT_STATE = 2, DONE_STATE = 3;
    
    assign digit1 = quot;
    assign digit0 = rem;
    assign converted_num = {quot, rem};
    assign done = done_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            temp_num <= 0;
            quot <= 0;
            rem <= 0;
            done_reg <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done_reg <= 0;
                    if (start) begin
                        temp_num <= decimal_num;
                        state <= DIVIDE;
                    end
                end
                DIVIDE: begin
                    quot <= temp_num / target_base;
                    rem <= temp_num % target_base;
                    state <= OUTPUT_STATE;
                end
                OUTPUT_STATE: begin
                    state <= DONE_STATE;
                end
                DONE_STATE: begin
                    done_reg <= 1;
                    if (~start) state <= IDLE;
                end
            endcase
        end
    end
endmodule

// ===================== Quadratic Solver Main Module (Gate-level) =====================
module quadratic_solver_gate(
    input clk,
    input reset,
    input start,
    input [3:0] input_base,
    input [8:0] a_in,  // [8]=sign, [7:0]=magnitude
    input [8:0] b_in,
    input [8:0] c_in,
    output reg [7:0] root1_base,
    output reg [7:0] root2_base,
    output reg root1_negative,
    output reg root2_negative,
    output reg roots_real,
    output reg done
);

    reg [3:0] state;
    parameter IDLE = 0, CONVERT_TO_DEC = 1, CALC_DISCRIMINANT = 2, 
              CALC_ROOTS = 3, CONVERT_BOTH = 4, DONE_STATE = 5;

    // Extract magnitude and sign
    wire [7:0] a_mag = a_in[7:0];
    wire [7:0] b_mag = b_in[7:0];
    wire [7:0] c_mag = c_in[7:0];
    wire a_sign = a_in[8];
    wire b_sign = b_in[8];
    wire c_sign = c_in[8];

    // Convert to decimal in current base
    wire [7:0] a_dec, b_dec, c_dec;
    base_to_decimal_converter_gate conv_a(.digit_high(a_mag[7:4]), .digit_low(a_mag[3:0]), .base(input_base), .decimal_value(a_dec));
    base_to_decimal_converter_gate conv_b(.digit_high(b_mag[7:4]), .digit_low(b_mag[3:0]), .base(input_base), .decimal_value(b_dec));
    base_to_decimal_converter_gate conv_c(.digit_high(c_mag[7:4]), .digit_low(c_mag[3:0]), .base(input_base), .decimal_value(c_dec));

    // Signed decimal values
    reg signed [15:0] a_dec_signed, b_dec_signed, c_dec_signed;

    // Intermediate calculations
    reg signed [15:0] b_squared, four_ac, discriminant, sqrt_disc;
    reg signed [15:0] root1_dec_signed, root2_dec_signed;
    reg [7:0] root1_dec_abs, root2_dec_abs;
    reg signed [15:0] neg_b, two_a;

    // Decimal to base converter signals
    reg conv1_start, conv2_start;
    reg conv1_reset, conv2_reset;
    wire [7:0] conv1_output, conv2_output;
    wire conv1_done, conv2_done;

    decimal_to_base_converter_gate dec_to_base1(
        .clk(clk),
        .reset(conv1_reset),
        .start(conv1_start),
        .decimal_num(root1_dec_abs),
        .target_base(input_base),
        .converted_num(conv1_output),
        .done(conv1_done)
    );

    decimal_to_base_converter_gate dec_to_base2(
        .clk(clk),
        .reset(conv2_reset),
        .start(conv2_start),
        .decimal_num(root2_dec_abs),
        .target_base(input_base),
        .converted_num(conv2_output),
        .done(conv2_done)
    );

    // Integer square root
    function [15:0] sqrt;
        input [15:0] val;
        integer i;
        reg [15:0] guess, new_guess;
        begin
            if (val == 0) sqrt = 0;
            else if (val == 1) sqrt = 1;
            else begin
                guess = val >> 1;
                for (i = 0; i < 10; i = i + 1) begin
                    new_guess = (guess + val/guess) >> 1;
                    if (new_guess >= guess) i = 10;
                    guess = new_guess;
                end
                sqrt = guess;
            end
        end
    endfunction

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            roots_real <= 0;
            root1_base <= 0;
            root2_base <= 0;
            root1_negative <= 0;
            root2_negative <= 0;
            conv1_start <= 0;
            conv2_start <= 0;
            conv1_reset <= 1;
            conv2_reset <= 1;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    conv1_reset <= 1;
                    conv2_reset <= 1;
                    conv1_start <= 0;
                    conv2_start <= 0;
                    if (start) state <= CONVERT_TO_DEC;
                end

                CONVERT_TO_DEC: begin
                    // Apply sign to decimal
                    a_dec_signed <= a_sign ? -$signed(a_dec) : $signed(a_dec);
                    b_dec_signed <= b_sign ? -$signed(b_dec) : $signed(b_dec);
                    c_dec_signed <= c_sign ? -$signed(c_dec) : $signed(c_dec);
                    state <= CALC_DISCRIMINANT;
                end

                CALC_DISCRIMINANT: begin
                    b_squared = b_dec_signed * b_dec_signed;
                    four_ac = 4 * a_dec_signed * c_dec_signed;
                    discriminant = b_squared - four_ac;

                    neg_b = -b_dec_signed;
                    two_a = 2 * a_dec_signed;

                    if (discriminant >= 0) begin
                        roots_real <= 1;
                        sqrt_disc = sqrt(discriminant);
                    end else begin
                        roots_real <= 0;
                        sqrt_disc = 0;
                    end
                    state <= CALC_ROOTS;
                end

                CALC_ROOTS: begin
                    if (roots_real && two_a != 0) begin
                        root1_dec_signed = (neg_b + sqrt_disc)/two_a;
                        root2_dec_signed = (neg_b - sqrt_disc)/two_a;

                        root1_negative <= (root1_dec_signed < 0);
                        root1_dec_abs <= (root1_dec_signed < 0) ? -root1_dec_signed : root1_dec_signed;

                        root2_negative <= (root2_dec_signed < 0);
                        root2_dec_abs <= (root2_dec_signed < 0) ? -root2_dec_signed : root2_dec_signed;
                    end else begin
                        root1_dec_abs <= 0;
                        root2_dec_abs <= 0;
                        root1_negative <= 0;
                        root2_negative <= 0;
                    end

                    conv1_reset <= 0;
                    conv2_reset <= 0;
                    state <= CONVERT_BOTH;
                end

                CONVERT_BOTH: begin
                    conv1_start <= 1;
                    conv2_start <= 1;

                    if (conv1_done && conv2_done) begin
                        root1_base <= conv1_output;
                        root2_base <= conv2_output;
                        conv1_start <= 0;
                        conv2_start <= 0;
                        state <= DONE_STATE;
                    end
                end

                DONE_STATE: begin
                    done <= 1;
                    if (~start) state <= IDLE;
                end
            endcase
        end
    end
endmodule

// ===================== TOP-LEVEL SEQUENTIAL CONTROLLER =====================
module quadratic_solver_all_bases (
    input clk,
    input reset,
    input start,

    input [8:0] A_in,   // 9-bit signed
    input [8:0] B_in,
    input [8:0] C_in,

    output reg [4:0] current_base,    
    output reg [7:0] out_root1_base,  
    output reg [7:0] out_root2_base,  
    output reg out_root1_negative,
    output reg out_root2_negative,
    output reg out_roots_real,
    output reg result_valid,
    output reg finished
);

    // Compute min_base combinationally
    wire [4:0] min_base_wire;
    min_base_from_three_inputs mb_inst (
        .X(A_in),
        .Y(B_in),
        .Z(C_in),
        .MIN_BASE(min_base_wire)
    );

    // FSM states
    reg [2:0] state;
    localparam S_IDLE      = 0,
               S_PREPARE   = 1,
               S_START_SOL = 2,
               S_WAIT_DONE = 3,
               S_CAPTURE   = 4,
               S_CHECK_INC = 5,
               S_FINISHED  = 6;

    // Instance of quadratic solver
    reg solver_start;
    wire solver_done;
    wire [7:0] solver_r1_base;
    wire [7:0] solver_r2_base;
    wire solver_r1_neg, solver_r2_neg, solver_roots_real;

    quadratic_solver_gate solver_inst (
        .clk(clk),
        .reset(reset),
        .start(solver_start),
        .input_base(current_base[3:0]),
        .a_in(A_in),
        .b_in(B_in),
        .c_in(C_in),
        .root1_base(solver_r1_base),
        .root2_base(solver_r2_base),
        .root1_negative(solver_r1_neg),
        .root2_negative(solver_r2_neg),
        .roots_real(solver_roots_real),
        .done(solver_done)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            current_base <= 0;
            solver_start <= 0;
            out_root1_base <= 0;
            out_root2_base <= 0;
            out_root1_negative <= 0;
            out_root2_negative <= 0;
            out_roots_real <= 0;
            result_valid <= 0;
            finished <= 0;
        end else begin
            result_valid <= 0;
            solver_start <= 0;

            case (state)
                S_IDLE: begin
                    finished <= 0;
                    if (start) begin
                        current_base <= (min_base_wire > 5'd15) ? 5'd15 : min_base_wire;
                        state <= S_PREPARE;
                    end
                end

                S_PREPARE: begin
                    if (current_base > 5'd15)
                        state <= S_FINISHED;
                    else
                        state <= S_START_SOL;
                end

                S_START_SOL: begin
                    solver_start <= 1'b1;
                    state <= S_WAIT_DONE;
                end

                S_WAIT_DONE: begin
                    if (solver_done)
                        state <= S_CAPTURE;
                end

                S_CAPTURE: begin
                    out_root1_base <= solver_r1_base;
                    out_root2_base <= solver_r2_base;
                    out_root1_negative <= solver_r1_neg;
                    out_root2_negative <= solver_r2_neg;
                    out_roots_real <= solver_roots_real;
                    result_valid <= 1'b1;
                    state <= S_CHECK_INC;
                end

                S_CHECK_INC: begin
                    if (current_base < 5'd15) begin
                        current_base <= current_base + 1;
                        state <= S_START_SOL;
                    end else begin
                        finished <= 1'b1;
                        state <= S_FINISHED;
                    end
                end

                S_FINISHED: begin
                    if (~start)
                        state <= S_IDLE;
                end
            endcase
        end
    end
endmodule
