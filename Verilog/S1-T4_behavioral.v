`timescale 1ns/1ps

// ===================== 4-BIT COMPARATOR =====================
module comparator_4bit (
    input [3:0] A,
    input [3:0] B,
    output reg A_gt_B,
    output reg A_eq_B,
    output reg A_lt_B
);
    always @(*) begin
        A_eq_B = (A == B);
        A_gt_B = (A > B);
        A_lt_B = (A < B);
    end
endmodule

// ===================== FULL ADDER =====================
module full_adder (
    input A, B, Cin,
    output reg Sum, Cout
);
    always @(*) begin
        Sum = A ^ B ^ Cin;
        Cout = (A & B) | (B & Cin) | (A & Cin);
    end
endmodule

// ===================== 4-BIT ADDER =====================
module adder_4bit (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output reg [3:0] Sum,
    output reg Cout
);
    always @(*) begin
        {Cout, Sum} = A + B + Cin;
    end
endmodule

// ===================== 8-BIT ADDER =====================
module adder_8bit (
    input  [7:0] A,
    input  [7:0] B,
    output reg [7:0] S,
    output reg Cout
);
    always @(*) begin
        {Cout, S} = A + B;
    end
endmodule

// ===================== 4x4 MULTIPLIER =====================
module multiplier_4x4 (
    input  [3:0] A,
    input  [3:0] B,
    output reg [7:0] P
);
    always @(*) begin
        P = A * B;
    end
endmodule

// ===================== MAX SELECTOR =====================
module max_4bit_using_comparator (
    input  [3:0] A1,
    input  [3:0] A2,
    output reg [3:0] MAX
);
    always @(*) begin
        if (A1 >= A2)
            MAX = A1;
        else
            MAX = A2;
    end
endmodule

// ===================== MINIMUM BASE CALCULATOR =====================
module min_base_from_three_inputs (
    input  [8:0] X,
    input  [8:0] Y,
    input  [8:0] Z,
    output reg [4:0] MIN_BASE
);
    reg [3:0] X1, X0, Y1, Y0, Z1, Z0;
    reg [3:0] max_X, max_Y, max_Z;
    reg [3:0] max_XY, max_digit;
    
    always @(*) begin
        X1 = X[7:4];
        X0 = X[3:0];
        Y1 = Y[7:4];
        Y0 = Y[3:0];
        Z1 = Z[7:4];
        Z0 = Z[3:0];
        
        // Find max within each number
        if (X1 > X0)
            max_X = X1;
        else
            max_X = X0;
            
        if (Y1 > Y0)
            max_Y = Y1;
        else
            max_Y = Y0;
            
        if (Z1 > Z0)
            max_Z = Z1;
        else
            max_Z = Z0;
        
        // Find max across all numbers
        if (max_X > max_Y)
            max_XY = max_X;
        else
            max_XY = max_Y;
            
        if (max_XY > max_Z)
            max_digit = max_XY;
        else
            max_digit = max_Z;
        
        // Minimum base is largest digit + 1
        MIN_BASE = max_digit + 1;
    end
endmodule

// ===================== Base to Decimal Converter =====================
module base_to_decimal_converter_gate (
    input [3:0] digit_high,
    input [3:0] digit_low,
    input [3:0] base,
    output reg [7:0] decimal_value
);
    always @(*) begin
        decimal_value = (digit_high * base) + digit_low;
    end
endmodule

// ===================== Decimal to Base Converter (FSM) =====================
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

// ===================== Quadratic Solver Main Module =====================
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