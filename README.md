# UniQuad System

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S1

  > Team ID: T4

  > Member-1: Naseh Ameen Sayrawala, 241CS136, nasehameensayrawala.241cs136@nitk.edu.in

  > Member-2: Neha Jain, 241CS137, nehajain.241cs137@nitk.edu.in

  > Member-3: Tarun P, 241CS160, tarun.241cs160@nitk.edu.in
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
  <p>
    This project presents UniQuad, a universal digital quadratic solver designed to compute roots across
diverse numeral systems, overcoming the limitations of traditional hardware restricted to binary or
decimal computation. This multi-base capability is uniquely valuable in educational settings for
demonstrating numeral system conversions and in embedded systems where computational versatility
is paramount. The system’s architecture is defined by its key features: robust multi-base input and
output logic, dedicated hardware arithmetic modules for multiplication, division, and square root
operations, and an efficient Finite State Machine (FSM) to coordinate the sequential computation
steps. Integrated base conversion logic and register-based storage for intermediate values further
enhance its flexibility. This scalable design establishes UniQuad as both an effective educational
tool and a novel foundation for advancing multi-base digital computation.
  </p>
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary>
  <b>UniQuad System: Architectural Diagrams and Operation</b><br>
  <p>
This document provides a detailed visual and written explanation of the proposed universal
digital quadratic solver (UniQuad). It begins with the main system-level diagram, which illustrates
the top-level control flow and interaction between modules. This is followed by a series of detailed
diagrams for each major individual module and sub-module. Each diagram is accompanied by a
thorough explanation of its operational logic and its role within the larger system.
  </p>
  <details>
    <summary>Main</summary>

<img src="https://github.com/user-attachments/assets/0008becf-386e-4c52-93c8-48e873fcb6c4" width="700">
  
    
<p><br>
The main system diagram shows the top-level architecture of the
UniQuad solver.<br>
  
Inputs: The system takes three 8-bit coefficients (A, B, C) and their corresponding 1-bit signs
(signA, signB , signC ).<br>
  
Outputs: It produces two 8-bit roots (Root1, Root2)and their signs(signRoot1, signRoot2).It also outputs the calculated B<br><br>

Modules: The core logic is modularized:<br>

Base Calculator:Takes A, B, and C to determine the minimum valid base for the inputs.<br>

Base to Decimal (x3): Three parallel modules that convert the input coefficients A, B, and C
from their input base to the system’s internal decimal (binary) representation.<br>

Root Calculator: The core processing block. It receives the decimal-converted A, B, and C,
calculates the discriminant, and then solves for the two roots.<br>

Decimal to Base (x2): Two parallel modules that convert the final calculated roots from the
internal decimal representation back to the user-specified output base.<br>

Control: A single Clk (Clock) signal drives the system, implying a synchronous design controlled
by a central Finite State Machine (FSM), which is not explicitly shown but is responsible for se-
quencing the operations from input conversion to final output.<br>

  </p>
  </details>
  <details>
    <summary>Base Calculator</summary><br>
    <img width="50%" height="auto" alt="ChatGPT Image Nov 1, 2025, 05_16_26 PM" src="https://github.com/user-attachments/assets/da849c50-cf28-4f93-ba3d-a4d44005d07b" /><br>
    <p>This module’s function is to determine the minimum valid base for the input numbers. It feeds
all three 8-bit inputs (A, B, C) into a sub-module (the ”Maximum Digit Calculator”) which finds
the largest digit used in any of the inputs. The output of this sub-module is then passed to an adder,
which adds ’1’ to the result. For example, if the largest digit found is ’7’, the minimum valid base
is 7 + 1 = 8</p>
  </details>
  <details>
    <summary>Maximum Digit Calculator</summary><br>
    <img width="50%" height="auto" alt="ChatGPT Image Nov 1, 2025, 05_26_52 PM" src="https://github.com/user-attachments/assets/a5098148-4b53-4864-a6f1-fbfcb5829ee0" /><br>
    <p>This module is the core component of the Base Calculator. It takes the 8-bit inputs A, B, and
C, and splits each into two 4-bit nibbles (digits). It then uses a tree of 4-bit comparators (the
green-wired blocks) and multiplexers to find the single largest 4-bit value among the six input digits.
This ”Maximum Digit” value is then sent back to the Base Calculator.</p>
  </details>
  <details>
    <summary>Base Converter</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/e0970e6d-8534-4c62-ae00-94c87b6a412a" /><br>
    <p>This circuit implements one stage of base-to-decimal conversion using Horner’s method. It is
labeled (Xb + Y ), which is the formula for converting a two-digit number ’XY’ from a base ’b’.
It takes the most significant digit (X), multiplies it by the base ’b’ (using a 4x4 multiplier), and
then adds the least significant digit (Y) using an adder. The ”Base to Decimal” blocks in the main
diagram are composed of chained instances of this module to handle all 8 bits (two 4-bit digits).</p>
  </details>
  <details>
    <summary>4x4 Multiplier</summary><br>
    <img width="50%" height="auto" alt="ChatGPT Image Nov 1, 2025, 05_30_40 PM" src="https://github.com/user-attachments/assets/f52f490d-884e-438a-adab-d2a238e75251" /><br>
    <p>This is a fundamental arithmetic block used in both the Base Converter and the Discriminant
Calculator. It is a standard 4-bit by 4-bit array multiplier. It uses a grid of AND gates to generate
partial products and then uses a series of adders (the blocks) to sum these partial products into a
final 8-bit result, which is split into a high nibble (Product 7:4) and a low nibble (Product 3:0).</p>
  </details>
  <details>
    <summary>Full Adder</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/cb8ab9ff-3b8f-4c6c-98ca-80739375d791" /><br>
    <p>he circuit computes the sum of three 1-bit inputs (A, B, Cin) and produces a
1-bit Sum and a 1-bit Carry (Carry). It is built from two XOR gates and three AND gates.</p>
  </details>
  <details>
    <summary>4-Bit Adder</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/3b8beb0e-4336-4d35-90c4-e2d2e46e8550" /><br>
    <p>This circuit adds two 4-bit numbers (A0-A3 and B0-B3). It is a ripple-carry
adder, constructed from four of the Full Adder modules (represented by the boxes), where the
Carry-out of one adder is connected to the Carry-in of the next.</p>
  </details>
  <details>
    <summary>4 Bit Comparator</summary><br>
    <img width="50%" height="auto" alt="comparator" src="https://github.com/user-attachments/assets/bd9557a8-d319-4d5c-a40b-4eeadf60d3a0" /><br>
    <p>This module is a combinational logic circuit that compares two 4-bit numbers, A and B. It uses
a series of gates to implement the logic for comparison and outputs three 1-bit signals: A < B,
A = B, and A > B. This module is used extensively within the ”Maximum Digit Calculator” to
find the largest input digit.</p>

  </details>
  <details>
    <summary>BCD Adder</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/61609260-6494-455b-8af6-72a01c722574" /><br>
    <p>The BCD (Binary Coded Decimal) Adder is used for calculations involving decimal numbers,
 for the ”Decimal to Base” conversion. It takes two 4-bit BCD digits (A and B) and adds them
using a 4-bit binary adder. A correction logic (the AND/OR gates) checks if the sum is greater than
9. If it is, this logic forces an addition of 6 to produce a valid BCD
sum (S0) and a carry (S1).</p>
  </details>
  <details>
    <summary>Synchronous Up Counter</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/6036d337-add8-4e15-ad86-eb97b26bdd47" /><br>
    <p>This circuit is a 4-bit synchronous counter. Unlike a ripple-carry counter, all J-K flip-flops are
connected to the same clock. The AND-gate logic ensures that each flip-flop toggles only when
all preceding bits are ’1’. This synchronous design provides a stable, predictable state, making it
an ideal component to build the main Finite State Machine (FSM) that controls the sequence of
operations in the UniQuad system.</p>
  </details>
  <details>
    <summary>Discriminant Calculator</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/95dd0fe7-0137-40cb-b22a-7a7d506e9e18" /><br>
    <p>This module calculates the discriminant, D = b^2 − 4ac.It takes the 8-bit coefficients A, B, and
C, along with their signs.
It computes b^2 using an 8x8 multiplier (which is built from the 4x4 multipliers).
It computes 4a (a simple 2-bit left shift, not shown) and then multiplies it by c using another
8x8 multiplier to get 4ac.
The signs signA and signC areXORed to determine the sign of 4ac.
An 8-Bit Adder/Subtractor module is then used to compute b^2 − 4ac. The sign logic determines
whether this operation is an addition or subtraction.
The module outputs the 8-bit discriminant value D and its final sign sign.</p>
  </details>
  <details>
    <summary>8 X 8 Multiplier</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/cea3c69c-469e-4f11-ac4c-f711393f1705" /><br>
    <p>This module computes the product of two 8-bit numbers, A and B.
It implements the multiplication using four 4x4 Multiplier sub-modules.
The 8-bit inputs are each split into high and low 4-bit nibbles (AH, AL, BH, BL).
It calculates four partial products: AL × BL, AH × BL, AL × BH, and AH × BH.
These partial products are then added together using a series of 8-bit adders, with appropriate
bit-shifting, to produce the final 16-bit product (which is output as an 8-bit value, implying it’s a
fixed-point calculation or truncation).</p>
  </details>
  <details>
    <summary>8-Bit Adder cum Subtractor</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/2fd58aa5-9872-486d-8872-42bf1cb6f482" /><br>
    <p>This is a versatile arithmetic unit that can perform both addition and subtraction.
It takes two 8-bit inputs, A and B.
A 1-bit control signal (Add)’ / Subtract determines the operation.
If the control line is 0 (Add), the B inputs pass through the XOR gates unchanged, and the 4-bit
adders perform A + B.
If the control line is 1 (Subtract), the XOR gates invert every bit of B, and the control line also
acts as the initial Carry-in, effectively computing A+B′ +1, which is the 2’s complement subtraction
A − B.
The result is generated by chaining two 4-Bit Adder modules.</p>
  </details>
  <details>
    <summary>Square Root Calculator</summary><br>
    <br>
    <img width="50%" height="auto" alt="ChatGPT Image Nov 1, 2025, 05_16_38 PM" src="https://github.com/user-attachments/assets/076c1804-c5b6-4e7e-a7bc-207f8e1dc558" />
    <p>This module computes the 4-bit integer square root of an 8-bit input number.
It implements a ”Non-Restoring Square Root” algorithm or a simple look-up table (LUT) using
combinational logic.
It uses a series of comparators (the blocks) to check the input value against the squares of integers
(e.g., 12 = 1, 22 = 4, 32 = 9, ... 152 = 225).
The comparators’ outputs feed into a Priority Encoder.
The Priority Encoder determines the largest integer whose square is less than or equal to the
8-bit input, and outputs that integer as the 4-bit square root.</p>

  </details>
  <details>
    <summary>Root Calculator</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/e668be8d-bfae-43ce-a9c1-10935ea98d36" /><br>
    <p>This is the central processing module that solves for the roots once the discriminant (D) is known.
It receives the decimal-converted inputs A, B, C, their signs, and the calculated discriminant D
(from the Discriminant Calculator module, which is embedded within this block).
It first calculates √D by feeding D into the Square Root Calculator sub-module.
It calculates 2a (a 1-bit left shift, implemented in the Division by 2 block by wiring).
It then computes the numerators using two 8-Bit Adder/Subtractor modules:
N umerator1 = −b + √D
N umerator2 = −b − √D
The sign of B (signB )and the operation (add/subtract) determine the final sign of the numerators.
It performs the final divisions N umerator1/2a and N umerator2/2a using two Division by 2
modules.
The module outputs the final 8-bit Root1 and Root2, their corresponding signs, and the real Roots flag.</p>
  </details>
  <details>
    <summary>Division by 2</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/18c579f0-6cca-409e-9958-d1512282c6a9" /><br>
    <p>This is a simple and efficient module that performs an 8-bit integer division by 2.
It takes an 8-bit input A.
The circuit is implemented as a 1-bit logical right shift. The input bits [7:1] are wired to the
output bits [6:0].
The most significant output bit [7] is tied to 0, effectively performing a fast division by 2 and
discarding any remainder (the original bit 0). This is used to calculate the 1/(2a) term.</p>
  </details>
  <details>
    <summary>Decimal to Base Converter</summary><br>
    <img width="50%" height="auto" alt="image" src="https://github.com/user-attachments/assets/011faa5a-6e85-43a2-a357-7fcf98899695" /><br>
    <p>This module converts the final 8-bit decimal roots back into the user-specified base.
It takes the 8-bit root (e.g., Root1) and its sign. The sign is passed through directly.
The 8-bit root is compared to 10 using a comparator.
If the root is less than 10, it’s a single-digit number, and the multiplexers pass it directly to the
low nibble (OutRoot1[3 : 0]) while the high nibble is set to 0.
If the root is 10 or greater, the circuit performs division/modulo by 10 (using the 8-Bit Adder/-
Subtractor to subtract 10) to find the two digits. The quotient becomes the high nibble (tens place)
and the remainder becomes the low nibble (ones place).
The two 4-bit BCD digits are then output as the 8-bit OutRoot1. The same logic is duplicated for Root2.</p>
  </details>
</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>
  <p>The module shows the system architecture—how the main functional blocks connect</p>
  <details>
    <summary>4 Bit Comparator</summary>
      This module shows the complete gate-level design of a **4-bit magnitude comparator**. This circuit compares two 4-bit binary numbers, $A$ and $B$, and determines if $A$ is greater than, less than, or equal to $B$.

Let's define the inputs and outputs:
* **Inputs:** $A = A_3A_2A_1A_0$ (where $A_3$ is the Most Significant Bit, MSB)
* **Inputs:** $B = B_3B_2B_1B_0$ (where $B_3$ is the MSB)
* **Outputs:** $A < B$, $A = B$, $A > B$ (each is a 1-bit signal)

The design is based on a cascading logic that starts by comparing the MSBs ($A_3$ and $B_3$) and moves down to the LSBs ($A_0$ and $B_0$) only if the higher bits are equal.

---

### Design & Logical Expressions

The circuit is functionally divided into three main output modules, all of which rely on an intermediate **bitwise equality** module.

#### 1. Intermediate Module: Bitwise Equality (XNOR)

First, the circuit determines if the bits at each position $i$ are equal. This is an XNOR operation.
* $X_i = (A_i = B_i)$
* This is logically equivalent to: $X_i = A_i \odot B_i = A_iB_i + \overline{A_i}\overline{B_i}$

In your diagram, this is cleverly implemented using AND and NOR gates. The logic for the output of each NOR gate is:
$$X_i = \overline{(A_i\overline{B_i} + \overline{A_i}B_i)} = \overline{A_i \oplus B_i} = A_i \odot B_i$$

So, we have four intermediate signals:
* $X_3 = A_3 \odot B_3$
* $X_2 = A_2 \odot B_2$
* $X_1 = A_1 \odot B_1$
* $X_0 = A_0 \odot B_0$

These $X_i$ signals are the outputs of the four NOR gates and are fed into the other logic blocks.

---

#### 2. Output Module: $A = B$

The output $A = B$ is true **if and only if** all corresponding bits are equal. This is a simple AND operation of all the intermediate equality signals.

* **Logical Condition:** $(A_3 = B_3)$ AND $(A_2 = B_2)$ AND $(A_1 = B_1)$ AND $(A_0 = B_0)$
* **Logical Expression:**
    $$(A=B) = X_3 \cdot X_2 \cdot X_1 \cdot X_0$$

If you trace the $A=B$ output wire, it comes from the bottom 4-input AND gate, whose inputs are exactly $X_3$, $X_2$, $X_1$, and $X_0$.

---

#### 3. Output Module: $A > B$

The output $A > B$ is true if the most significant bit where $A$ and $B$ differ is a '1' for $A$ and a '0' for $B$.

* **Logical Conditions:**
    * $A_3 > B_3$ (i.e., $A_3=1$ and $B_3=0$)
    * **OR** $(A_3 = B_3)$ AND ($A_2 > B_2$)
    * **OR** $(A_3 = B_3)$ AND $(A_2 = B_2)$ AND ($A_1 > B_1$)
    * **OR** $(A_3 = B_3)$ AND $(A_2 = B_2)$ AND $(A_1 = B_1)$ AND ($A_0 > B_0$)

* **Logical Expression:**
    $$(A>B) = (A_3\overline{B_3}) + (X_3 A_2\overline{B_2}) + (X_3 X_2 A_1\overline{B_1}) + (X_3 X_2 X_1 A_0\overline{B_0})$$

This directly matches the bottom 4-input OR gate in the diagram. Each of its inputs is one of the terms in the expression above.

---

#### 4. Output Module: $A < B$

The logic for $A < B$ is symmetrical to $A > B$. It's true if the most significant bit where they differ is a '0' for $A$ and a '1' for $B$.

* **Logical Conditions:**
    * $A_3 < B_3$ (i.e., $A_3=0$ and $B_3=1$)
    * **OR** $(A_3 = B_3)$ AND ($A_2 < B_2$)
    * **OR** $(A_3 = B_3)$ AND $(A_2 = B_2)$ AND ($A_1 < B_1$)
    * **OR** $(A_3 = B_3)$ AND $(A_2 = B_2)$ AND $(A_1 = B_1)$ AND ($A_0 < B_0$)

* **Logical Expression:**
    $$(A<B) = (\overline{A_3}B_3) + (X_3 \overline{A_2}B_2) + (X_3 X_2 \overline{A_1}B_1) + (X_3 X_2 X_1 \overline{A_0}B_0)$$

This directly matches the top 4-input OR gate in the diagram.

---

### Truth Table (Conditional)
<img width="647" height="445" alt="image" src="https://github.com/user-attachments/assets/bb0c9a4a-c0de-41aa-bc3f-a5126108758a" />



  </details>
  <details>
    <summary>Maximum Digit Calculator</summary>
    This module shows a "Maximum Digit Calculator" built using a tree-like structure. Its purpose is to find the single largest 4-bit digit (nibble) from three 8-bit BCD (Binary-Coded Decimal) inputs: `A`, `B`, and `C`.

The entire circuit is constructed from one repeating "Max Module."

### 1. The Core Building Block: "Max Module"

This circuit uses a core module that finds the maximum of two 4-bit numbers.

* **Components:**
    1.  A **4-bit Magnitude Comparator**.
    2.  A **4-bit 2-to-1 Multiplexer (MUX)**.
* **Function:**
    * It takes two 4-bit inputs, let's call them $X$ and $Y$.
    * The comparator compares them. Its $X > Y$ output is used as the select line ($S$) for the MUX.
    * The MUX inputs are $X$ (to input '1') and $Y$ (to input '0').
    * If $X > Y$, $S$ becomes '1', and the MUX selects and outputs $X$.
    * If $X \le Y$, $S$ becomes '0', and the MUX selects and outputs $Y$.
    * The result is that the module's output is always $\text{Max}(X, Y)$.

---

### 2. Module Design: 4-bit 2-to-1 MUX

This module selects one of two 4-bit inputs based on a single select line.

* **Inputs:** $I_1$ (4-bit), $I_0$ (4-bit), $S$ (1-bit)
* **Output:** $Z$ (4-bit)

#### Truth Table (for a single bit-slice $i$)

<img width="458" height="172" alt="image" src="https://github.com/user-attachments/assets/949dcbe7-d832-4b2c-84c6-720d61f8065b" />


*(X = Don't Care)*

#### Logical Expression (for a single bit-slice $i$)

The logic for each of the four output bits is independent and identical:
$$Z_i = (\overline{S} \cdot I_{0,i}) + (S \cdot I_{1,i})$$

---

### 3. Module Design: 4-bit Magnitude Comparator

This module compares two 4-bit numbers ($X$ and $Y$) and outputs a single bit ($S$) that is '1' if $X > Y$ and '0' otherwise.

* **Inputs:** $X = X_3X_2X_1X_0$, $Y = Y_3Y_2Y_1Y_0$
* **Output:** $S$ (1-bit)


#### Logical Expression

The logic is identical to the $A > B$ output from the 4-bit comparator you sent previously.
Let $E_i = (X_i \odot Y_i) = (X_iY_i + \overline{X_i}\overline{Y_i})$ be the "equality" (XNOR) for bit $i$.

The expression for the $S$ output is:
$$S = (X_3\overline{Y_3}) + (E_3 \cdot X_2\overline{Y_2}) + (E_3 \cdot E_2 \cdot X_1\overline{Y_1}) + (E_3 \cdot E_2 \cdot E_1 \cdot X_0\overline{Y_0})$$

---

### 4. Overall Circuit Structure

The diagram connects five of these "Max Modules" in a tournament-style tree to find the maximum of all six digits ($A_H, A_L, B_H, B_L, C_H, C_L$).

* **Level 1 (Inputs):**
    * **Module 1:** $\text{Max}(A_H, A_L) \rightarrow \text{out } M_A$
    * **Module 2:** $\text{Max}(B_H, B_L) \rightarrow \text{out } M_B$
    * **Module 3:** $\text{Max}(C_H, C_L) \rightarrow \text{out } M_C$

* **Level 2 (Intermediate):**
    * **Module 4:** $\text{Max}(M_A, M_B) \rightarrow \text{out } M_{AB}$
    * (Module 3's output $M_C$ is passed to the next level).

* **Level 3 (Final Output):**
    * **Module 5:** $\text{Max}(M_{AB}, M_C) \rightarrow \text{Final 4-bit Output}$

The final 4-bit output is the single largest digit from the three 8-bit BCD numbers.
  </details>
  <details>
    <summary>Base Calculator</summary>
    This module calculates the **Minimum Base** required to represent the three 8-bit BCD (Binary-Coded Decimal) numbers `A`, `B`, and `C`.

The logic is: **Minimum Base = (Maximum Digit in A, B, or C) + 1**.
* For example, if `A=12`, `B=79`, `C=04`, the maximum digit is 9. The minimum base is 10 (decimal).
* If `A=1A`, `B=05`, `C=0F`, the maximum digit is F (15). The minimum base is 16 (hexadecimal).

The circuit consists of two main modules, which appear to be drawn in a simplified or high-level way.

1.  **Block `V` (Maximum Digit Calculator):** This block is functionally identical to the "Maximum Digit Calculator" from the previous image you sent. It takes the three 8-bit BCD numbers (which contain six 4-bit digits) and outputs the single 4-bit digit that has the largest value.
2.  **Block `+` (4-bit Incrementor):** This block takes the 4-bit `MaxDigit` from Block `V` and adds 1 to it.

---

### 1. Module 1: Maximum Digit Calculator (Block `V`)

This module is a macro for the circuit in your previous image.

* **Inputs:** `A` (8-bit), `B` (8-bit), `C` (8-bit).
* **Output:** `MaxDigit` (4-bit), let's call it $X_3X_2X_1X_0$.
* **Function:** Finds the maximum value among the six 4-bit nibbles: $A_{high}, A_{low}, B_{high}, B_{low}, C_{high}, C_{low}$.
* **Design:** As shown previously, this is a 3-level tree of "Max Modules," where each "Max Module" consists of a 4-bit comparator and a 4-bit 2-to-1 MUX.

---

### 2. Module 2: 4-bit Incrementor (Block `+`)

This module is a 4-bit adder configured to calculate $X + 1$. It takes the 4-bit $X$ (MaxDigit) as one operand, uses $0$ for the second operand (implied), and sets the **Carry-In ($C_{in}$) to 1**.

* **Inputs:** $X_3, X_2, X_1, X_0$ (from Module 1). $C_{in} = 1$.
* **Outputs:** $S_3, S_2, S_1, S_0$ (the `Minimum Base`). $C_{out}$ is unconnected.

#### Truth Table

This table shows the 4-bit input ($X$) and the resulting 4-bit output ($S$).

<img width="1170" height="587" alt="image" src="https://github.com/user-attachments/assets/4ae7d048-58a5-4d95-a532-b293099fa772" />


*(Note: The last row shows an overflow, as $15+1=16$, which is $10000_b$. The 4-bit output truncates to $0000_b$ and sets $C_{out}=1$.)*

#### Logical Expressions (Derivation)

This is built from four 1-bit full adders. The logic for a full adder is $S_i = X_i \oplus Y_i \oplus C_i$ and $C_{i+1} = (X_iY_i) + (X_iC_i) + (Y_iC_i)$.
In our case, $Y_i$ is always $0$ and the initial $C_0 = 1$.

* **Bit 0 (LSB):**
    * $S_0 = X_0 \oplus 0 \oplus 1 = \overline{X_0}$
    * $C_1 = (X_0 \cdot 0) + (X_0 \cdot 1) + (0 \cdot 1) = X_0$

* **Bit 1:**
    * $S_1 = X_1 \oplus 0 \oplus C_1 = X_1 \oplus C_1 = X_1 \oplus X_0$
    * $C_2 = (X_1 \cdot 0) + (X_1 \cdot C_1) + (0 \cdot C_1) = X_1 C_1 = X_1 X_0$

* **Bit 2:**
    * $S_2 = X_2 \oplus 0 \oplus C_2 = X_2 \oplus C_2 = X_2 \oplus (X_1 X_0)$
    * $C_3 = (X_2 \cdot 0) + (X_2 \cdot C_2) + (0 \cdot C_2) = X_2 C_2 = X_2 X_1 X_0$

* **Bit 3 (MSB):**
    * $S_3 = X_3 \oplus 0 \oplus C_3 = X_3 \oplus C_3 = X_3 \oplus (X_2 X_1 X_0)$
    * $C_4 (\text{c\_out}) = (X_3 \cdot 0) + (X_3 \cdot C_3) + (0 \cdot C_3) = X_3 C_3 = X_3 X_2 X_1 X_0$
  </details>
  <details>
    <summary>Base Converter</summary>
    This "Base Converter" module is a hardware implementation of the standard polynomial formula for converting a two-digit number, $XY$, from a given base $b$ into its decimal (binary) equivalent.

The formula being implemented is: **Converted Number = $(X \times b) + Y$**

Where:
* `X` is the 4-bit most significant digit (high nibble) of the 8-bit input.
* `Y` is the 4-bit least significant digit (low nibble) of the 8-bit input.
* `b` is the 4-bit base.

The circuit consists of two primary combinational modules: a 4x4 multiplier and an 8-bit adder. (The D-flip-flops are registers used to latch the $X$ and $b$ inputs, likely for synchronization with a clock, but the core logic resides in the multiplier and adder.)

---

### 1. 4-bit x 4-bit Multiplier

This module takes the 4-bit digit $X$ and the 4-bit base $b$ and computes their 8-bit product.

* **Inputs:** $A[3..0]$ (from $X$), $B[3..0]$ (from $b$)
* **Output:** $P[7..0]$ (8-bit product, $P = X \times b$)


#### Logical Derivation
This is a standard **array multiplier**. The logic is derived in two steps:
1.  **Partial Products:** An AND gate is used to find the partial product for every combination of input bits.
    $$p_{ij} = A_i \cdot B_j$$
    (This requires $4 \times 4 = 16$ AND gates).

2.  **Adder Array:** The 16 partial products are arranged in a shifted grid and summed using a 2D array of half-adders and full-adders to produce the final 8-bit product $P[7..0]$.
    
---

### 2. 8-bit Adder

This module takes the 8-bit product from the multiplier and adds the 4-bit digit $Y$ to it.

* **Inputs:**
    * Input 1: $P[7..0]$ (from the multiplier)
    * Input 2: A zero-extended $Y$, which is $0000Y_3Y_2Y_1Y_0$.
* **Output:** `Converted Number` (8-bit sum, $S[7..0]$)


#### Logical Derivation
This is a standard **ripple-carry adder**, built by cascading 8 1-bit full-adders. The carry-out ($C_{out}$) of one full-adder becomes the carry-in ($C_{in}$) of the next.

The logical expressions for each **1-bit Full-Adder ($i$)** are:

* **Sum Bit:** $S_i = A_i \oplus B_i \oplus C_i$
* **Carry-Out:** $C_{i+1} = (A_i \cdot B_i) + (C_i \cdot (A_i \oplus B_i))$

The final output is the 8-bit sum $S_7S_6S_5S_4S_3S_2S_1S_0$.
  </details>
  <details>
    <summary>4 x 4 Multiplier</summary>
    This module shows a **4x4 Multiplier**. Its purpose is to take two 4-bit binary numbers, $A$ ($A_3A_2A_1A_0$) and $B$ ($B_3B_2B_1B_0$), and compute their 8-bit product, $Product[7:0]$.

The circuit shown is a type of parallel multiplier. The design of all 4x4 multipliers is based on two steps:

1.  **Partial Product Generation**
2.  **Partial Product Summation**

-----

### 1\. Partial Product Generation

This step is performed by the 16 AND gates shown in the diagram. Like in grade-school long multiplication, each bit of $A$ is multiplied by each bit of $B$. In binary, this is just an AND operation.

  * **Logic:** $P_{ij} = A_i \cdot B_j$ (where $i$ is the bit index for $A$ and $j$ is for $B$)
  * **Example:**
      * $P_{00} = A_0 \cdot B_0$
      * $P_{01} = A_0 \cdot B_1$
      * ...up to $P_{33} = A_3 \cdot B_3$

This creates 16 partial product bits.

-----

### 2\. Partial Product Summation

This is the main task of the circuit, performed by the blocks labeled `S` (which are multi-bit adders). These adders sum the 16 partial products, which are shifted relative to each other, just like in long multiplication:

```
                  A3 A2 A1 A0
                x B3 B2 B1 B0
---------------------------------
                  P30 P20 P10 P00  (A * B0)
             P31 P21 P11 P01       (A * B1) << 1
        P32 P22 P12 P02            (A * B2) << 2
   P33 P23 P13 P03                 (A * B3) << 3
---------------------------------
P7  P6  P5  P4  P3  P2  P1  P0
```

The logic for each product bit is the result of summing the columns, including carries. This is what the adders in the diagram are doing.

#### Logical Expressions (Derivation)

Deriving the full expressions is complex, but the first few bits are straightforward:

  * **$Product_0$:** This is the LSB, which has no other bits in its column.
    $$Product_0 = P_{00} = A_0B_0$$
    (In the diagram, this is the single wire from the top-right AND gate straight to the `Product[3:0]` output).

  * **$Product_1$:** This is the sum of the second column ($P_{10}$ and $P_{01}$). A **Half-Adder** is required.
    $$Product_1 = P_{10} \oplus P_{01} = (A_1B_0) \oplus (A_0B_1)$$
    (The carry-out from this, $C_1 = P_{10} \cdot P_{01}$, is passed to the next column's sum).

  * **$Product_2$:** This is the sum of the third column ($P_{20}, P_{11}, P_{02}$) plus the carry $C_1$ from the previous column. This requires two **Full-Adders**.
    $$Product_2 = (P_{20} \oplus P_{11}) \oplus (P_{02} \oplus C_1)$$

This pattern of cascading adders continues for all 8 product bits, getting progressively more complex. The diagram you provided implements this summation logic using two large 4-bit adders in sequence to combine the partial products.

-----

### Truth Table

A full truth table for this circuit would have 8 inputs ($A_3$-$A_0$, $B_3$-$B_0$) and $2^8 = 256$ rows. It is impractical to list. Instead, here are a few examples of its function:

<img width="762" height="215" alt="image" src="https://github.com/user-attachments/assets/516c5a81-1113-4596-bea8-9d547867ae8a" />

  </details>
  <details>
    <summary>Full Adder</summary>
    This module shows the gate-level design for a 1-bit **Full Adder**.

A full adder is a fundamental combinational circuit that performs the arithmetic sum of three 1-bit inputs:
* `A`: Input bit A
* `B`: Input bit B
* `Cin`: Carry-In bit (from the previous, less-significant stage)

It produces two 1-bit outputs:
* `Sum`: The least significant bit of the sum
* `Carry`: The carry-out bit (to the next, more-significant stage)

---

### Truth Table

The operation of the full adder is defined by the following truth table, which covers all 8 possible input combinations.

<img width="605" height="315" alt="image" src="https://github.com/user-attachments/assets/2914c2cc-2408-4644-8433-1d4cdd25acc0" />


---

### Logical Expressions & Derivation

The circuit in the image directly implements the two standard, optimized logical expressions for the `Sum` and `Carry` outputs.

#### 1. Sum Output

The `Sum` output is '1' when an **odd number** of inputs are '1'. This is the definition of a cascaded **Exclusive-OR (XOR)** operation.

* **Derivation:**
    Looking at the truth table, the Sum is '1' for rows (001), (010), (100), and (111). This forms the Sum-of-Products (SOP) expression:
    $Sum = \overline{A}\overline{B}C_{in} + \overline{A}B\overline{C_{in}} + A\overline{B}\overline{C_{in}} + ABC_{in}$

    This expression can be simplified using Boolean algebra:
    $Sum = C_{in}(\overline{A}\overline{B} + AB) + \overline{C_{in}}(\overline{A}B + A\overline{B})$
    $Sum = C_{in}(\overline{A \oplus B}) + \overline{C_{in}}(A \oplus B)$
    This is the definition of an XNOR/XOR combination, which is an XOR:
    $Sum = C_{in} \oplus (A \oplus B)$

* **Final Logical Expression:**
    $$Sum = A \oplus B \oplus C_{in}$$

    As shown in the diagram, this is implemented with two 2-input XOR gates:
    1.  The first gate computes $(A \oplus B)$.
    2.  The second gate computes $(A \oplus B) \oplus C_{in}$.

#### 2. Carry Output

The `Carry` output is '1' when **two or more** of the inputs are '1'. This is also known as a "majority function."

* **Derivation:**
    Looking at the truth table, the Carry is '1' for rows (011), (101), (110), and (111). This forms the SOP expression:
    $Carry = \overline{A}BC_{in} + A\overline{B}C_{in} + AB\overline{C_{in}} + ABC_{in}$

    This expression can be simplified using a Karnaugh map or Boolean algebra (by grouping terms):
    $Carry = BC_{in}(\overline{A} + A) + AC_{in}(\overline{B} + B) + AB(\overline{C_{in}} + C_{in})$
    *Note: This is a common way to demonstrate the simplification, but we'll use the standard consensus theorem.*
    $Carry = BC_{in}(\overline{A} + A) + AB\overline{C_{in}} + A\overline{B}C_{in}$
    $Carry = BC_{in} + AB\overline{C_{in}} + A\overline{B}C_{in}$
    $Carry = BC_{in} + A(B\overline{C_{in}} + \overline{B}C_{in})$
    $Carry = BC_{in} + A(B \oplus C_{in})$
    
    The circuit diagram, however, uses the more common and direct SOP simplification:
    $Carry = \overline{A}BC_{in} + A\overline{B}C_{in} + AB\overline{C_{in}} + ABC_{in}$
    $Carry = (\overline{A}BC_{in} + ABC_{in}) + (A\overline{B}C_{in} + ABC_{in}) + (AB\overline{C_{in}} + ABC_{in})$
    $Carry = BC_{in}(\overline{A} + A) + AC_{in}(\overline{B} + B) + AB(\overline{C_{in}} + C_{in})$
    $Carry = BC_{in} + AC_{in} + AB$

* **Final Logical Expression:**
    $$Carry = (A \cdot B) + (A \cdot C_{in}) + (B \cdot C_{in})$$

    As shown in the diagram, this is implemented with:
    1.  Three AND gates to compute each term: $(A \cdot B)$, $(A \cdot C_{in})$, and $(B \cdot C_{in})$.
    2.  One OR gate to sum the three terms.
  </details>
  <details>
    <summary>BCD Adder</summary>
    This module shows a 1-digit **BCD (Binary-Coded Decimal) Adder**. Its purpose is to add two 4-bit BCD digits (`A` and `B`, values 0-9) and produce a valid 2-digit BCD result (`S1` and `S0`).

For example, if `A` = 7 ($0111_b$) and `B` = 5 ($0101_b$), a normal binary adder would give $1100_b$ (12), which is not a valid BCD digit. This circuit correctly adds them and outputs `S1` = $0001_b$ (1) and `S0` = $0010_b$ (2), representing the BCD number 12.

This is achieved by adding $6$ ($0110_b$) to the binary sum if it's greater than 9.

The design consists of three main modules:
1.  **Module 1: 4-bit Binary Adder (Left):** This performs the initial binary addition.
2.  **Module 2: "Invalid BCD" Detection Logic (Middle):** This logic checks if the binary sum is greater than 9.
3.  **Module 3: 4-bit Correction Adder (Right):** This adds 6 to the sum if the detection logic is triggered.

---

### 1. Module 1: 4-bit Binary Adder

This is a standard 4-bit ripple-carry adder, which you've sent in a previous image.
* **Inputs:** `A` (4-bit), `B` (4-bit), $C_{in}=0$.
* **Outputs:** `S_temp` (4-bit temporary sum) and `K` (1-bit temporary carry-out).
* **Function:** It computes the 5-bit binary sum ($K, S_{temp}$) of $A + B$.

---

### 2. Module 2: "Invalid BCD" Detection Logic

This module's job is to output a single bit, let's call it `Adjust`, which is '1' if the temporary sum is $> 9$.
* **Inputs:** `K`, $S_{temp}[3]$, $S_{temp}[2]$, $S_{temp}[1]$.
* **Output:** `Adjust` (This 1-bit signal is also routed to become the BCD carry-out digit `S1`).

#### Truth Table (Conditional)
This table shows the binary sums that are invalid in BCD (i.e., $> 9$).

<img width="846" height="245" alt="image" src="https://github.com/user-attachments/assets/e87bbee0-c06c-4114-960a-870283210bf2" />


#### Logical Expression (Derivation)
The circuit implements the standard logic for detecting a sum $> 9$:
$$Adjust = K + (S_3 \cdot S_2) + (S_3 \cdot S_1)$$

* The $K$ term detects any sum $\ge 16$.
* The $(S_3 \cdot S_2)$ term detects sums 12, 13, 14, and 15.
* The $(S_3 \cdot S_1)$ term detects sums 10, 11, 14, and 15.

The OR of these three terms correctly identifies all invalid sums.

---

### 3. Module 3: 4-bit Correction Adder

This is another 4-bit ripple-carry adder. It adds the "correction factor" (6) to the temporary sum *only if* it's needed.
* **Inputs:**
    * Operand 1: `S_temp` (the 4-bit sum from Module 1).
    * Operand 2: This is a 4-bit number formed by the `Adjust` signal. The wiring shows it is $0(Adjust)(Adjust)0_b$.
        * If `Adjust` = 0, this input is $0000_b$ (0).
        * If `Adjust` = 1, this input is $0110_b$ (6).
    * $C_{in}=0$.
* **Output:** `S0` (the final, correct 4-bit BCD sum digit).
* **Function:**
    * If $Adjust=0$, $S0 = S_{temp} + 0$.
    * If $Adjust=1$, $S0 = S_{temp} + 6$.
  </details>
  <details>
    <summary>Synchronous Up Counter</summary>
    This module shows a **4-bit Synchronous Up Counter**.

The circuit is "synchronous" because all four flip-flops share the same clock (`Clk`) signal, meaning their outputs change at the same time. The "up counter" logic is implemented by the AND gates that control when each flip-flop is allowed to toggle.

The design uses four **JK-Flip-Flops (FFs)**, which are configured as **T-Flip-Flops (Toggle FFs)** because their `J` and `K` inputs are tied together.
* If $J=K=0$, the FF holds its state.
* If $J=K=1$, the FF toggles its state (from 0 to 1, or 1 to 0).

Let's label the flip-flops from right to left as $FF0$ (LSB) to $FF3$ (MSB), with their outputs being $Q_0, Q_1, Q_2, \text{and } Q_3$.

---

### Logical (Excitation) Expressions

The logic for toggling each bit is derived from tracing the `J` and `K` input lines:

* **$FF0$ (LSB):**
    * $J_0 = 1$ (The inputs to its AND gate are both '1')
    * $K_0 = 1$
    * **Result:** $J_0=K_0=1$. This means $FF0$ toggles on **every** clock pulse.

* **$FF1$:**
    * $J_1 = Q_0$ (The inputs to its AND gate are $Q_0$ and '1')
    * $K_1 = Q_0$
    * **Result:** $FF1$ toggles only when $Q_0 = 1$.

* **$FF2$:**
    * The AND gate for $J_2/K_2$ takes inputs from $Q_1$ and the output of the previous AND gate (which is $Q_0$).
    * $J_2 = Q_1 \cdot Q_0$
    * $K_2 = Q_1 \cdot Q_0$
    * **Result:** $FF2$ toggles only when $Q_1=1$ **and** $Q_0=1$.

* **$FF3$ (MSB):**
    * The AND gate for $J_3/K_3$ takes inputs from $Q_2$ and the output of the previous AND gate (which is $Q_1 \cdot Q_0$).
    * $J_3 = Q_2 \cdot (Q_1 \cdot Q_0)$
    * $K_3 = Q_2 \cdot (Q_1 \cdot Q_0)$
    * **Result:** $FF3$ toggles only when $Q_2=1$ **and** $Q_1=1$ **and** $Q_0=1$.

---

### State Transition Table

This table shows the counter's **Present State** ($Q_3Q_2Q_1Q_0$) and what the **Next State** will be after one clock pulse.

<img width="980" height="584" alt="image" src="https://github.com/user-attachments/assets/a0b14a85-025d-4957-9302-053e47763a6c" />


*(Note: The `Preset` logic on the left is for asynchronously loading a value into the counter, but the core counting logic is as described above.)*
  </details>
  <details>
    <summary>8 Bit Comparator</summary>
    This module shows an **8-bit magnitude comparator** built by cascading two 4-bit comparators.

This circuit's design is hierarchical. It splits the 8-bit inputs `A` and `B` into their high-order 4 bits ($A_H$, $B_H$) and low-order 4 bits ($A_L$, $B_L$) and compares them separately. The final output logic then combines these partial results.

---

### 1. Core Module: 4-Bit Comparator

The two blocks in the center are 4-bit magnitude comparators (like the one you sent previously).

* **Inputs:** $A[3:0]$, $B[3:0]$
* **Outputs:**
    * $O_{A>B}$ (Output A > B)
    * $O_{A=B}$ (Output A = B)
    * $O_{A<B}$ (Output A < B)
* **Function:** This module compares two 4-bit numbers and asserts one of the three outputs. Its internal logic consists of XNORs, ANDs, and ORs to check bit equality and magnitude from the MSB down.

---

### 2. 8-Bit Comparator Design & Derivation

The circuit uses one 4-bit comparator for the high bits ($A[7:4]$ vs $B[7:4]$) and another for the low bits ($A[3:0]$ vs $B[3:0]$). The logic on the right implements the cascading rules.

Let's define the outputs of the comparators:
* **High-Bit Outputs:** $O_{A_H > B_H}$, $O_{A_H = B_H}$, $O_{A_H < B_H}$
* **Low-Bit Outputs:** $O_{A_L > B_L}$, $O_{A_L = B_L}$, $O_{A_L < B_L}$

#### Final Output: $A = B$

* **Logic:** The 8-bit numbers are equal **if and only if** the high bits are equal AND the low bits are equal.
* **Logical Expression:**
    $$(A = B) = (O_{A_H = B_H}) \cdot (O_{A_L = B_L})$$
    *This is implemented by the single AND gate in the middle.*

#### Final Output: $A > B$

* **Logic:** The 8-bit number $A$ is greater than $B$ if:
    1.  The high bits of $A$ are greater than the high bits of $B$ (e.g., `0101 0000` > `0100 1111`).
    2.  **OR** The high bits are equal, AND the low bits of $A$ are greater than the low bits of $B$ (e.g., `0101 1000` > `0101 0111`).
* **Logical Expression:**
    $$(A > B) = (O_{A_H > B_H}) + ( (O_{A_H = B_H}) \cdot (O_{A_L > B_L}) )$$
    *This is implemented by the bottom AND gate feeding into the bottom OR gate.*

#### Final Output: $A < B$

* **Logic:** The 8-bit number $A$ is less than $B$ if:
    1.  The high bits of $A$ are less than the high bits of $B$ (e.g., `1000 1111` < `1001 0000`).
    2.  **OR** The high bits are equal, AND the low bits of $A$ are less than the low bits of $B$ (e.g., `1000 0001` < `1000 0010`).
* **Logical Expression:**
    $$(A < B) = (O_{A_H < B_H}) + ( (O_{A_H = B_H}) \cdot (O_{A_L < B_L}) )$$
    *This is implemented by the top AND gate feeding into the top OR gate.*

---

### Conditional Truth Table
<img width="970" height="217" alt="image" src="https://github.com/user-attachments/assets/7d36f84f-bbbe-415b-99e9-00257c71060c" />

  </details>
  <details>
    <summary>Square Root Calculator</summary>
    This module shows a combinational **Square Root Calculator** that finds the integer square root of an 8-bit input number ($N$).

The circuit is essentially a large **lookup table (LUT)**. It works by finding the largest integer $R$ (from 0 to 15) such that $R^2$ is less than or equal to the input $N$. The 4-bit output is this integer $R$.

### Design and Modules

The circuit consists of three main stages:

1.  **16 x 8-bit Comparators:** The 8-bit input $N$ is fed in parallel to a bank of 16 comparators. Each comparator $i$ (where $i$ is 0 to 15) compares $N$ to the hardcoded constant value of **$i^2$**.
    * The labels in the diagram (`00`, `01`, `04`... `e1`) are the hexadecimal representations of these perfect squares ($0^2, 1^2, 2^2... 15^2$).
    * Based on the NOT gates that follow, these are **"Less Than" (<) comparators**. The output of comparator $i$ is '1' if $N < i^2$.

2.  **16 x NOT Gates (Inverters):** The output of each comparator is inverted.
    * The output of the $i^{th}$ inverter is '1' if $N \ge i^2$.

3.  **1 x 16-to-4 Priority Encoder (`Pri`):** This module takes the 16 inverted signals as its inputs. It finds the **highest index $i$** that has a '1' input and outputs the 4-bit binary representation of that index.

This logic finds the largest $R$ for which $N \ge R^2$, which is the definition of the integer square root.

#### Example Trace (Input $N = 50$)

1.  **Comparators:** $N = 50$ (`32h`)
    * Comparator 0 ($50 < 0^2$): 0
    * ...
    * Comparator 7 ($50 < 7^2$ i.e., $50 < 49$): 0
    * **Comparator 8 ($50 < 8^2$ i.e., $50 < 64$): 1**
    * **Comparator 9 ($50 < 9^2$ i.e., $50 < 81$): 1**
    * ...and so on.

2.  **Inverters (Inputs to Priority Encoder):**
    * Input 0: 1
    * ...
    * Input 7: 1
    * **Input 8: 0**
    * **Input 9: 0**
    * ...and so on.
    * The 16 inputs to the encoder are: `(1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0)`

3.  **Priority Encoder:**
    * The encoder scans its inputs and finds the **highest index** with a '1'.
    * The highest index is **7**.
    * It outputs the 4-bit binary for 7.
    * **Final Output: `0111` (7)**. (This is correct, as $\lfloor\sqrt{50}\rfloor = 7$).

---

### Truth Table (Range-Based)

<img width="816" height="589" alt="image" src="https://github.com/user-attachments/assets/4b1ee0ae-2041-4013-9a8f-24dd1b0f6ece" />

  </details>
  <details>
    <summary>8 Bit Adder Cum Subtractor</summary>
    This module shows a classic and efficient design for an **8-bit Adder cum Subtractor**.

This single circuit can perform two operations, $A + B$ or $A - B$, by using the **2's complement** method for subtraction. The operation is chosen by the 1-bit control input, let's call it $S$ (for `(Add)'/Subtract`).

* **Principle of 2's Complement:** $A - B = A + (\text{2's complement of } B)$
* **2's Complement of B:** $(\text{1's complement of } B) + 1 = \overline{B} + 1$
* **Circuit Goal:**
    * If $S=0$ (Add): Output = $A + B$
    * If $S=1$ (Subtract): Output = $A + \overline{B} + 1$

---

### Module Design and Derivation

The circuit cleverly implements this logic using two key components: a bank of XOR gates and a standard 8-bit adder.

#### 1. Module 1: Selectable Inverter (XOR Bank)

This bank of eight 2-input XOR gates acts as a "programmable inverter." One input of every XOR gate is connected to a bit from $B$, and the other input is connected to the control signal $S$.

* **Logic:** The output of each XOR gate $i$ is $B'_i = B_i \oplus S$.

* **Derivation (Case Analysis):**
    * **Case 1: $S = 0$ (Addition)**
        * $B'_i = B_i \oplus 0 = B_i$
        * The $B$ bits pass through the XOR gates **unchanged**.
    * **Case 2: $S = 1$ (Subtraction)**
        * $B'_i = B_i \oplus 1 = \overline{B_i}$
        * The $B$ bits are **inverted**, producing the 1's complement of $B$.

#### 2. Module 2: 8-Bit Adder

The two blocks in the center are 4-bit adders, cascaded to form a standard 8-bit ripple-carry adder. This module performs the final summation.

* **Input 1:** The 8-bit number $A$.
* **Input 2:** The 8-bit output from the XOR bank ($B'$).
* **Carry-In ($C_{in}$):** This is the key to the "+ 1" part of the 2's complement. The main control signal $S$ is wired directly to the $C_{in}$ of the first full adder (the LSB).
    * If $S=0$ (Add), $C_{in} = 0$.
    * If $S=1$ (Subtract), $C_{in} = 1$.

---

### Functional Truth Table

A full truth table is impossible ($2^{17} = 131,072$ rows). Instead, this functional table shows the two modes of operation based on the control signal $S$.

<img width="877" height="109" alt="image" src="https://github.com/user-attachments/assets/2563d180-434c-4706-b3a3-402143d0eb92" />


### Logical Expressions

The final 8-bit output is the sum from the adder. The logic for any single bit $i$ of the output is based on the full adder equations:

* **Input to Adder:** $A_i$ and $B'_i$, where $B'_i = B_i \oplus S$
* **Carry-in to Bit $i$:** $C_i$ (where the initial $C_0 = S$)

The logical expression for each output bit $i$ is:
$$Output_i = A_i \oplus B'_i \oplus C_i = A_i \oplus (B_i \oplus S) \oplus C_i$$

And the carry-out to the next bit is:
$$C_{i+1} = (A_i \cdot B'_i) + (A_i \cdot C_i) + (B'_i \cdot C_i)$$
$$C_{i+1} = (A_i \cdot (B_i \oplus S)) + (A_i \cdot C_i) + ((B_i \oplus S) \cdot C_i)$$
  </details>
  <details>
    <summary>Discriminant Calculator</summary>
    This module shows a "Discriminant Calculator" for a quadratic equation. It's designed to calculate $\Delta$ from the inputs $a$, $b$, and $c$.

The circuit is built to compute $\Delta = b^2 - 4ac$. However, the design includes a `sign_B` input in its control logic, which is unusual since $b^2$ is always positive. The analysis below describes the circuit *as it is drawn*.

The circuit uses 8-bit magnitudes for `A`, `B`, and `C`, and 1-bit signs (`sign_A`, `sign_B`, `sign_C`) where 0 is positive and 1 is negative.

---

### 1. Modules and Data Path

The circuit's data path consists of three multipliers, an input-swapping MUX, and an adder/subtractor.

1.  **Multiplier 1 (Top-Left):** Calculates $4 \times A$. It takes the 8-bit `A` input and a hardcoded 8-bit constant `04`.
2.  **Multiplier 2 (Top-Middle):** Calculates $4AC$. It takes the output of Multiplier 1 ($4A$) and the 8-bit `C` input.
3.  **Multiplier 3 (Middle-Left):** Calculates $B^2$. It takes the 8-bit `B` input for both of its operands.
4.  **Input MUX (Two 2-to-1 MUXes):** This block takes the $B^2$ and $4AC$ values. It acts as a swap, sending either ($X=B^2, Y=4AC$) or ($X=4AC, Y=B^2$) to the final calculation module.
5.  **Adder/Subtractor:** This is an 8-bit adder cum subtractor module that takes the $X$ and $Y$ inputs from the MUX. It performs $X+Y$ or $X-Y$ based on a control signal.

---

### 2. Control Logic Derivation

The circuit's behavior is controlled by three key signals derived from the input signs.

1.  **`sign_AC` (Sign of 4AC):** This is the result of `sign_A \oplus sign_C`. If $A$ and $C$ have the same sign, $sign_{AC}=0$ (positive). If they differ, $sign_{AC}=1$ (negative).
    * `sign_AC = sign_A \oplus sign_C`

2.  **`S_mux` (MUX Select):** This signal controls the input MUX.
    * `S_mux = sign_B \oplus sign_AC`

3.  **`S_op` (Operation Select):** This signal controls the Adder/Subtractor and its initial Carry-In. We assume **0 = Add** and **1 = Subtract**.
    * `S_op = \overline{sign_B} + sign_AC` (The logic is `(sign_B XOR 1) OR sign_AC`).

---

### 3. Functional Truth Table

This table shows the circuit's operation for the four possible sign combinations.

<img width="1008" height="176" alt="image" src="https://github.com/user-attachments/assets/e8a5dd03-a5b2-48f6-ae54-74fde1a6f21c" />

### 4. `sign_D` (Output Sign) Logic

The output sign is calculated by a final MUX and OR gate:
* `Out_MUX3 = (S_op \cdot sign_AC) + (\overline{S_op} \cdot sign_B)`
* `sign_D = S_mux + Out_MUX3`

<img width="719" height="177" alt="image" src="https://github.com/user-attachments/assets/e99363fa-195a-4497-a839-c5e31b2799ed" />


### Conclusion

The circuit as-designed does not correctly calculate $\Delta = B^2 - 4AC$ for all cases, likely due to the inclusion of the `sign_B` input.

* The standard formula requires $B^2$, which is always positive (so `sign_B` should be 0).
* If we look at the **`sign_B = 0`** rows (the expected case):
    * When $4AC$ is positive (Row 1), it correctly computes $D = B^2 - 4AC$ with `sign_D = 0`. This assumes $B^2 \ge 4AC$.
    * When $4AC$ is negative (Row 2), it should compute $D = B^2 + 4AC$ with `sign_D = 0`. Instead, the circuit computes $D = 4AC - B^2$ and gives `sign_D = 1`, which is incorrect.
  </details>
  <details>
    <summary>8 x 8 Multiplier</summary>
    This module shows a hierarchical **8x8 Multiplier**. It's built by combining smaller, identical modules, specifically four **4x4 multipliers** and three **8-bit adders**.

The circuit implements the standard "long multiplication" algorithm, which you can see by splitting the 8-bit inputs $A$ and $B$ into 4-bit high-order ($A_H, B_H$) and low-order ($A_L, B_L$) nibbles.

The formula is:
$$Product = (A_H \cdot 2^4 + A_L) \times (B_H \cdot 2^4 + B_L)$$
$$Product = (A_H \cdot B_H) \cdot 2^8 + (A_H \cdot B_L) \cdot 2^4 + (A_L \cdot B_H) \cdot 2^4 + (A_L \cdot B_L)$$

---

### Module Design and Derivation

The circuit calculates four "partial products" in parallel and then adds them together with the correct bit-shifts.

* $P_{LL} = A_L \times B_L$ (from the bottom-right 4x4 multiplier)
* $P_{LH} = A_L \times B_H$ (from the bottom-left 4x4 multiplier)
* $P_{HL} = A_H \times B_L$ (from the top-right 4x4 multiplier)
* $P_{HH} = A_H \times B_H$ (from the top-left 4x4 multiplier)

#### 1. Module 1: 4x4 Multiplier (Used 4 times)
This is the core building block.
* **Inputs:** Two 4-bit numbers.
* **Output:** One 8-bit product.
* **Internal Logic:** As seen in your previous image, this module itself is made of 16 AND gates to create partial products, which are then summed by an array of full-adders.

#### 2. Module 2: 8-Bit Adder (Used 3 times)
This is a standard 8-bit ripple-carry (or lookahead) adder.
* **Inputs:** Two 8-bit numbers, 1-bit Carry-In.
* **Output:** One 8-bit Sum, 1-bit Carry-Out.

---

### Circuit Structure and Logic

The circuit combines the partial products in three stages:

1.  **Stage 1: Calculate Partial Products.** The four 4x4 multipliers run in parallel to get $P_{LL}$, $P_{LH}$, $P_{HL}$, and $P_{HH}$.

2.  **Stage 2: Add Cross-Products.** The first 8-bit adder (middle-right) adds the two cross-products, which share the same $2^4$ shift:
    $$S_{cross} = P_{HL} + P_{LH}$$

3.  **Stage 3: Final Summation.** The final two 8-bit adders (top-right and bottom-right) work together as a 16-bit adder to combine all the pieces. This is a "split-adder" implementation of the final sum:
    $$Product = (P_{HH} \ll 8) + (S_{cross} \ll 4) + P_{LL}$$

    * The **bottom-right adder** calculates the low 8 bits of the product (`Product[7:0]`). It adds $P_{LL}$ to the low 8 bits of $(S_{cross} \ll 4)$.
    * The **top-right adder** calculates the high 8 bits of the product (`Product[15:8]`). It adds $P_{HH}$ to the high bits of $(S_{cross} \ll 4)$ and also adds the carry-out generated by the bottom-right adder.
  </details>
  <details>
    <summary>Root Calculator</summary>
    This module shows the top-level data path for the **Root Calculator**. It's the "master" circuit that connects many of the sub-modules you've sent (like the discriminant calculator, square root calculator, and adders) to implement the full quadratic formula:
$$x = \frac{-b \pm \sqrt{\Delta}}{2a}$$

Because this is a high-level block diagram of complex arithmetic units, it's not feasible to create a simple truth table or gate-level logical expression for the entire system. Instead, I will describe the function of each major sub-module as it's used in the data path.

---

### 1. Module 1: Discriminant Calculator

* **Location:** The large cluster of blocks and MUXes on the **left** side of the diagram.
* **Inputs:** `A`, `B`, `C`, and their corresponding sign bits.
* **Function:** This is the "Discriminant Calculator" module you sent earlier. It performs the calculation $\Delta = b^2 - 4ac$.
* **Outputs:**
    * An 8-bit magnitude for $\Delta$ (fed into the "sqrt" block).
    * A 1-bit sign for $\Delta$, which is used to generate the `real_Roots` output. If the sign of $\Delta$ is negative, `real_Roots` is set to 0.

### 2. Module 2: Square Root Calculator

* **Location:** The block labeled "sqrt" in the center.
* **Input:** The 8-bit $\Delta$ magnitude from Module 1.
* **Function:** This is the "Square Root Calculator" module. It finds the 8-bit integer square root of the discriminant.
* **Output:** An 8-bit magnitude for $\sqrt{\Delta}$.

### 3. Module 3: Denominator Calculator ($2a$)

* **Location:** The block that takes `A` as its input (labeled with a shift symbol).
* **Input:** The 8-bit `A` magnitude.
* **Function:** This is a **1-bit logical left-shifter**. It calculates $2 \times A$ by shifting all bits one position to the left, effectively multiplying it by 2.
* **Output:** An 8-bit magnitude for $2a$.

### 4. Module 4: Numerator Calculators ($-b \pm \sqrt{\Delta}$)

* **Location:** The two 8-bit "Adder cum Subtractor" modules in the center.
* **Inputs:** `B`, $\sqrt{\Delta}$, and control logic from `sign_B`.
* **Function:** These two modules work in parallel to find the two numerators:
    * **Numerator 1:** Calculates $(-b) + \sqrt{\Delta}$.
    * **Numerator 2:** Calculates $(-b) - \sqrt{\Delta}$.
    * The logic around `sign_B` ensures that $B$ is added or subtracted correctly to achieve the $-b$ term.

### 5. Module 5 & 6: Dividers (Root Calculation)

* **Location:** The two large blocks on the right (labeled with a division symbol).
* **Inputs:**
    * The two numerators from Module 4.
    * The denominator ($2a$) from Module 3.
* **Function:** These are 8-bit divider modules.
    * **Divider 1:** Computes $\frac{(-b) + \sqrt{\Delta}}{2a}$ to get `Root_1`.
    * **Divider 2:** Computes $\frac{(-b) - \sqrt{\Delta}}{2a}$ to get `Root_2`.
* **Output:** The 8-bit magnitudes for `Root_1` and `Root_2`.

### 6. Module 7: Output Sign Logic

* **Location:** The various MUXes and logic gates on the far right.
* **Inputs:** The signs of the numerators (from Module 4) and the sign of the denominator (`sign_A`).
* **Function:** This logic implements the rules of sign for division.
    * For `sign_Root_1`: It compares $sign(\text{Numerator 1})$ and $sign(2a)$. If they are the same, the output is 0 (positive). If they are different, the output is 1 (negative).
    * The same logic is applied for `sign_Root_2`.
  </details>
  <details>
    <summary>Division By 2</summary>
    This module performs an integer **Division by 2** on an 8-bit input `A` by implementing a **1-bit logical right shift**.

This operation shifts all the bits of `A` one position to the right. The Most Significant Bit (MSB) is filled with a '0', and the Least Significant Bit (LSB) is discarded (which truncates the remainder).

---

### Logical Expressions (Derivation)

The circuit is purely combinational and consists only of wire connections. The logic for each bit of the `Quotient` ($Q$) is a direct mapping from the input `A`.

* $Q_7 = 0$ (The MSB is hardwired to 0)
* $Q_6 = A_7$
* $Q_5 = A_6$
* $Q_4 = A_5$
* $Q_3 = A_4$
* $Q_2 = A_3$
* $Q_1 = A_2$
* $Q_0 = A_1$

(The input bit $A_0$ is discarded).

---

### Truth Table (Examples)

A full truth table would have $2^8 = 256$ rows. This table shows several examples to illustrate the operation.
<img width="878" height="244" alt="image" src="https://github.com/user-attachments/assets/232d6d09-24ee-4e73-8200-397f8e95b0db" />


  </details>
  <details>
    <summary>Decimal to Base Convertor</summary>
    This module, labeled "Decimal to Base Convertor," is designed to convert an 8-bit binary number (like `Root_1`) into an 8-bit, 2-digit BCD (Binary-Coded Decimal) number (like `Out_Root_1`). This is necessary to display the binary result on the 7-segment BCD displays.

The circuit is duplicated to handle both `Root_1` and `Root_2` independently. The sign bit (`sign_Root_1`) is passed directly to the output (`sign_Out_Root_1`) because the sign is not part of the base conversion itself.

The internal logic, which uses the sign bit to control multiplexers, is highly unconventional for a standard BCD converter. However, we can analyze the function of the modules as they are drawn.

---

### Functional Analysis

The circuit's behavior is controlled by the `sign_Root_1` input.

1.  **Case 1: `sign_Root_1` = 0 (Positive)**
    * The first MUX selects the **high nibble** (`Root_1[7:4]`).
    * The adder calculates: $S = \text{Root\_1} + \text{Root\_1[7:4]}$ (with zero-extension).
    * The second MUX selects this sum $S$.
    * The final output is $BCD\_Correct(S)$.

2.  **Case 2: `sign_Root_1` = 1 (Negative)**
    * The first MUX selects the **low nibble** (`Root\_1[3:0]`).
    * The adder calculates: $S = \text{Root\_1} + \text{Root\_1[3:0]}$ (with zero-extension).
    * The second MUX selects the **original `Root_1`**, discarding the adder's result.
    * The final output is $BCD\_Correct(\text{Root\_1})$.

---

### Module Design: BCD Correction Block (Final Stage)

The final stage of this circuit consists of two identical "Add 3" modules. This block takes the 8-bit result from the main logic, splits it into two 4-bit nibbles, and **unconditionally adds 3 to each nibble**.

#### 1. Module: 4-bit "Add 3" Adder
This is a 4-bit adder where one input is the 4-bit nibble ($A_3A_2A_1A_0$) and the other input is hardwired to $0011_b$ (3).

#### 2. Truth Table
This table shows the input nibble and the resulting 4-bit output after adding 3.

<img width="595" height="416" alt="image" src="https://github.com/user-attachments/assets/5fc88d0a-52c2-4b22-9bcd-f031ec96b934" />


#### 3. Logical Expressions (Derivation)
We can derive the logic for the 4-bit sum $S = A + 3$ by cascading 4 full adders. Let $C_0 = 0$.

* **Bit 0:** (Adds $A_0 + 1$)
    * $S_0 = A_0 \oplus 1 \oplus 0 = \overline{A_0}$
    * $C_1 = (A_0 \cdot 1) = A_0$

* **Bit 1:** (Adds $A_1 + 1 + C_1$)
    * $S_1 = A_1 \oplus 1 \oplus C_1 = \overline{A_1} \oplus C_1 = \overline{A_1} \oplus A_0$
    * $C_2 = (A_1 \cdot 1) + (A_1 \cdot C_1) + (1 \cdot C_1) = A_1 + C_1 = A_1 + A_0$

* **Bit 2:** (Adds $A_2 + 0 + C_2$)
    * $S_2 = A_2 \oplus 0 \oplus C_2 = A_2 \oplus C_2 = A_2 \oplus (A_1 + A_0)$
    * $C_3 = (A_2 \cdot 0) + (A_2 \cdot C_2) = A_2 \cdot C_2 = A_2(A_1 + A_0)$

* **Bit 3:** (Adds $A_3 + 0 + C_3$)
    * $S_3 = A_3 \oplus 0 \oplus C_3 = A_3 \oplus C_3 = A_3 \oplus (A_2(A_1 + A_0))$
    * $C_4 = (A_3 \cdot 0) + (A_3 \cdot C_3) = A_3 \cdot C_3 = A_3(A_2(A_1 + A_0))$
  </details>
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>
  
   <b>> UniQuad System</b><br>
    ![main](https://github.com/user-attachments/assets/419ffe62-87a1-4fa4-a16e-b6d3964f1c35)<br>

The UniQuad System is the top-level block diagram for the entire quadratic equation solver. It
shows the complete data flow, connecting the 8-bit BCD inputs (A, B, C) and their signs to all the
major sub-modules. It routes these inputs through the ‘Base Converter‘, ‘Discriminant Calculator‘,
and ‘Root Calculator‘, and finally sends the computed binary roots to the ‘Decimal to Base‘ converter
to produce the final BCD outputs (‘Root1‘and‘Root2‘).<br>
—
<br> <b>> 4-Bit Comparator</b><br>
<br>![4-bit Comparator](https://github.com/user-attachments/assets/af8c88f6-de78-4436-aa12-713de0fc8cec)
<br>
The 4-Bit Comparator determines the relationship between two 4-bit numbers, A and B. It
works by comparing the bits at each position, starting from the most significant bit (MSB). It uses
XNOR logic to check for bitwise equality and a cascade of AND/OR gates to implement the priority
logic, asserting one of the three final outputs: A < B, A = B, or A > B.<br>
—
<br><b>>Maximum Digit Calculator</b><br>
<br>![Max Digit](https://github.com/user-attachments/assets/d33a7096-6c14-4560-9aad-7f93911e172b)
<br>
The Maximum Digit Calculator finds the single largest 4-bit digit (nibble) from three 8-bit
BCD inputs. It works using a ”tournament-style” tree of five ”Max Modules.” Each Max Module
consists of a 4-bit comparator and a 2-to-1 MUX to select the larger of two inputs. The circuit first
finds the max digit *within* A, B, andC individually, then compares those results to find the overall
4-bit maximum.<br>
—
<br><b>>Base Calculator</b><br>
<br>![Base Calculator](https://github.com/user-attachments/assets/54154c49-861f-409a-b027-2731dc549a75)
<br>
The Base Calculator determines the minimum base required to represent the BCD inputs by
implementing the formula ‘Minimum Base = Maximum Digit + 1‘. It is a two-stage circuit: the
first block (labeled ‘V‘) is the ”Maximum Digit Calculator” which finds the largest 4-bit nibble from
all inputs. The second block (a 4-bit adder) is configured as an incrementor (by setting Cin = 1) to
add one to that digit.<br>
—
<br><b>>Base Converter</b><br>
<br>![Base Converter](https://github.com/user-attachments/assets/737d4357-8e34-4dca-9c8e-10699e440d5f)
<br>
The Base Converter translates a 2-digit number XY from a given 4-bit base b into its 8-bit
binary (base-10) equivalent. It works by implementing the standard polynomial formula: ‘Converted
Number = (X * b) + Y‘. It uses a 4x4 multiplier to compute the product of the high digit (X) and
the base (b), and then uses an 8-bit adder to add the low digit (Y ) to that product.<br>
—
<br><b>>4 x 4 Multiplier</b><br>
<br>![Multiplier](https://github.com/user-attachments/assets/71d7d3db-5a75-489c-bfc8-43a4dde698d4)
<br>
The 4x4 Multiplier computes the 8-bit product of two 4-bit inputs, A and B. It works in two
steps: first, an array of 16 AND gates generates all the 1-bit partial products (Ai · Bj ). Second,
a network of 4-bit adders (the blocks labeled ‘S‘) sums these partial products, which are shifted
relative to each other, to produce the final 8-bit ‘Product‘.<br>
—
<br><b>>Full Adder</b><br>
<br>![Full Adder](https://github.com/user-attachments/assets/ce286173-075d-404b-b44d-3350bf7e1d2a)
<br>
The Full Adder is a 1-bit circuit that performs the arithmetic sum of three 1-bit inputs (A,
B, and Cin). It produces a ‘Sum‘ output using two XOR gates (implementing A ⊕ B ⊕ Cin) and
a ‘Carry‘ output using a ”majority” logic of three AND gates and one OR gate (implementing
AB + ACin + BCin), which is true if two or more inputs are ’1’.<br>
—
<br><b>>4 Bit Adder</b><br>
<br>![4 Bit Adder](https://github.com/user-attachments/assets/86e50591-53d6-4baf-a969-88735854b6e3)
<br>
The 4-Bit Adder calculates the sum of two 4-bit numbers (A and B) plus an initial Cin. It works
as a ”ripple-carry” adder by connecting four 1-bit Full Adders in a chain.<br>
—
<br><b>>BCD Adder</b><br>
<br>![BCD Adder](https://github.com/user-attachments/assets/b26fd9c1-1e67-4785-8146-a8cb8b78f836)
<br>
The BCD Adder correctly adds two 4-bit BCD digits (0-9). It first performs a standard binary
addition using a 4-bit adder. A special detection circuit then checks if this binary sum is greater
than 9 (or if a carry was generated). If it is, this logic signals a *second* 4-bit adder to add a
”correction factor” of 6 (0110b) to the temporary sum, producing the valid BCD result (‘S0‘) and
carry digit (‘S1‘).<br>
—
<br><b>>Synchronous Up Counter</b><br>
<br>![Synchronous Up Counter](https://github.com/user-attachments/assets/87894e12-6a04-42b0-af22-509269a60b88)
<br>
The Synchronous Up Counter counts from 0000 to 1111, with all four JK-Flip-Flops sharing a
single ‘Clk‘ signal. The counting logic is managed by a chain of AND gates that control the ”toggle”
(J = K = 1) condition. The LSB (Q0) toggles on every clock pulse, while each subsequent flip-flop
(Qi) is only enabled to toggle when all the preceding bits (Qi−1 . . . Q0) are ’1’.<br>
—
<br><b>>8 Bit Comparator</b><br>
<br>![8-bit Comparator](https://github.com/user-attachments/assets/2d97c2c3-1648-495f-b10f-63b90da83b38)
<br>
The 8-Bit Comparator compares two 8-bit numbers (A and B) using a cascaded design. It first
compares the high 4 bits (AH , BH ) using one 4-bit comparator. If AH̸ = BH , the result is decided.
If and only if AH = BH , the circuit’s final output logic then uses the result from a *second* 4-bit
comparator (which compares AL, BL) to make the final determination.<br>
—
<br><b>>Square Root Calculator</b><br>
<br>![Square root](https://github.com/user-attachments/assets/d0df81ac-4310-4e11-b27d-e1827fed75ec)
<br>
The Square Root Calculator finds the 8-bit integer square root of an 8-bit input N . It works
as a large combinational lookup table by feeding N into a bank of 16 comparators, each checking
if N is less than a hardcoded perfect square (02, 12, . . . , 152). The inverted outputs (now N ≥ i2)
are fed into a 16-to-4 Priority Encoder, which finds the highest-priority true input i and outputs its
4-bit value.<br>
—
<br><b>>8 Bit Adder Cum Subtractor</b><br>
<br>![8 Bit Adder Subtractor](https://github.com/user-attachments/assets/5e76d2c6-8d23-4b3c-8c20-e6cc849f55ba)
<br>
The 8-Bit Adder cum Subtractor performs both A + B and A − B using 2’s complement logic.
A bank of 8 XOR gates acts as a programmable inverter for the B input: if the ‘(Add)’/Subtract‘
line is 0, it passes B; if it’s 1, it passes B (1’s complement). This same control line is fed into the
8-bit adder’s Cin, providing the crucial ”+ 1” to complete the 2’s complement subtraction.<br>
—
<br><b>>Discriminant Calculator</b><br>
<br>![Discriminant](https://github.com/user-attachments/assets/06fcc170-e9b7-43f8-9ba1-35c59efed8b5)
<br>
The Discriminant Calculator computes ∆ = b2 − 4ac by routing inputs A, B, andC through
a data path of arithmetic units. It uses three 4x4 multipliers in parallel (one for B2, and two to
find 4 × A × C). The results (B2 and 4AC) are then fed into a final 8-bit adder/subtractor, which,
guided by control logic based on the input signs, computes the final discriminant magnitude D and
its sign sign D.<br>
—
<br><b>>8 x 8 Multiplier</b><br>
<br>![Multiplier](https://github.com/user-attachments/assets/b5b3c984-1996-4c08-8786-75b3c116b85f)
<br>
The8x8 Multiplier uses a hierarchical design to compute a 16-bit product. It’s built from
four 4x4 multiplier modules and three 8-bit adders. It first calculates four 8-bit partial products
(AH · BH , AH · BL, AL · BH , AL · BL) in parallel. These results are then added together in stages by
the 8-bit adders, with the necessary bit-shifting, to form the final 16-bit ‘Product‘.<br>
—
<br><b>>Root Calculator</b><br>
<br>![Root Calculation](https://github.com/user-attachments/assets/6de0b086-b233-414a-a557-209353d5bded)
<br>
The Root Calculator is the top-level data path that implements the quadratic formula x =
−b±√∆
2a . It connects several sub-modules: it feeds A, B, andC into a ‘Discriminant Calculator‘, sends
its output ∆ to a ‘Square Root Calculator‘, then uses two adder/subtractors to get the numerators
(−b ± √∆). Finally, two divider modules divide these numerators by 2a (calculated by a bit-shifter)
to produce the final ‘Root1‘and‘Root2‘.<br>
—
<br><b>>Division By 2<b><br>
<br>![Division](https://github.com/user-attachments/assets/f0cee91e-2fd5-4112-82ec-3767720e544a)
<br>
The Division by 2 circuit performs an 8-bit integer division using a simple **1-bit logical right
shift**. This is a purely combinational circuit where each output bit Qi is directly wired to the
input bit Ai+1. The new most significant bit of the quotient (Q7) is hardwired to 0, and the original
least significant bit (A0) is discarded, effectively truncating any remainder.<br>
—
<br><b>>Decimal to Base Converter</b><br>
<br>![Decimal to base](https://github.com/user-attachments/assets/ca9bf4b2-01e0-4272-8481-aee1aab85303)
<br>
The Decimal to Base Convertor is designed to convert an 8-bit binary number (like ‘Root1‘)into a 2−
digit 8−bit BCD number.<br>

  
</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

  > Below are the three implementation levels of the Verilog design.

  ---

  <details>
  <summary>Gate-Level Modeling</summary>

  ```systemverilog
  // ===================== GATE-LEVEL IMPLEMENTATION =====================
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


```
  </details>

  <details> <summary>Dataflow Modeling</summary>
  
  ```systemverilog
  // ===================== DATAFLOW IMPLEMENTATION =====================
  `timescale 1ns/1ps

// ===================== 4-BIT COMPARATOR =====================
module comparator_4bit (
    input [3:0] A,
    input [3:0] B,
    output A_gt_B,
    output A_eq_B,
    output A_lt_B
);
    assign A_eq_B = (A == B);
    assign A_gt_B = (A > B);
    assign A_lt_B = (A < B);
endmodule

// ===================== FULL ADDER =====================
module full_adder (
    input A, B, Cin,
    output Sum, Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);
endmodule

// ===================== 4-BIT ADDER =====================
module adder_4bit (
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
);
    assign {Cout, Sum} = A + B + Cin;
endmodule

// ===================== 8-BIT ADDER =====================
module adder_8bit (
    input  [7:0] A,
    input  [7:0] B,
    output [7:0] S,
    output Cout
);
    assign {Cout, S} = A + B;
endmodule

// ===================== 4x4 MULTIPLIER =====================
module multiplier_4x4 (
    input  [3:0] A,
    input  [3:0] B,
    output [7:0] P
);
    assign P = A * B;
endmodule

// ===================== MAX SELECTOR =====================
module max_4bit_using_comparator (
    input  [3:0] A1,
    input  [3:0] A2,
    output [3:0] MAX
);
    assign MAX = (A1 >= A2) ? A1 : A2;
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

    // Find max within each number
    wire [3:0] max_X = (X1 > X0) ? X1 : X0;
    wire [3:0] max_Y = (Y1 > Y0) ? Y1 : Y0;
    wire [3:0] max_Z = (Z1 > Z0) ? Z1 : Z0;
    
    // Find max across all numbers
    wire [3:0] max_XY = (max_X > max_Y) ? max_X : max_Y;
    wire [3:0] max_digit = (max_XY > max_Z) ? max_XY : max_Z;
    
    // Minimum base is largest digit + 1
    assign MIN_BASE = max_digit + 1;
endmodule

// ===================== Base to Decimal Converter =====================
module base_to_decimal_converter_gate (
    input [3:0] digit_high,
    input [3:0] digit_low,
    input [3:0] base,
    output [7:0] decimal_value
);
    assign decimal_value = (digit_high * base) + digit_low;
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
```
</details>

<details> <summary>Behavioral Modeling</summary>
  
  ```systemverilog
// ===================== BEHAVIORAL IMPLEMENTATION =====================
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
```
</details> 
</details> 

## References
<details>
  <summary>Detail</summary>
> M. Morris Mano and M. D. Ciletti, Digital Design, 5th Edition, Pearson, 2013.<br>
> R. J. Tocci, N. S. Widmer, and G. L. Moss, Digital Systems: Principles and Applications, 11th
Edition, Pearson, 2016.<br>
> Charles Petzold, Code: The Hidden Language of Computer Hardware and Software, Microsoft
Press, 2000.<br>
> D. A. Patterson and J. L. Hennessy, Computer Organization and Design: The Hardware/Soft-
ware Interface, 5th Edition, Morgan Kaufmann, 2014.<br>
> A. V. Oppenheim and A. S. Willsky, Signals and Systems, 2nd Edition, Pearson, 1996<br>
</details>


