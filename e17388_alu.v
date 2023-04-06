 /*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda
        Group 2
        ALU unit for the RV32IM pipeline implementation
==============================================================
 */

 module alu(DATA1, DATA2, RESULT, OPCODE);
    
    input [31:0] DATA1, DATA2;              // Declaring a 32 bit port for data inputs
    input [4:0] ALU_OPCODE;                 // Declaring a 5 bit port to input the opcode of ALU
    output [31:0] ALU_RESULT;               // Declaring a 32 bit port for the output of ALU

    // Declaration of wires to get the immediate results
    wire [31:0] RESULT_ADD,
                RESULT_SUB,
                RESULT_SLL,
                RESULT_SRL,
                RESULT_SRA,
                RESULT_SLT,
                RESULT_SLTU,
                RESULT_AND,
                RESULT_OR,
                RESULT_XOR,
                RESULT_MUL,
                RESULT_MULH,
                RESULT_MULHU,
                RESULT_MULHSU,
                RESULT_DIV,
                RESULT_DIVU,
                RESULT_REM,
                RESULT_REMU;

    // Defining the functions of the ALU
    assign #2 RESULT_ADD = DATA1 + DATA2;       // Addition    
    assign #2 RESULT_SUB = DATA1 - DATA2;       // Substraction

    assign #2 RESULT_SLL = DATA1 << DATA2;      // Logical shift left
    assign #2 RESULT_SRL = DATA1 >> DATA2;      // Logical shift right
    assign #2 RESULT_SRA = DATA1 >>> DATA2;     // Arithmatic shift right

    assign #2 RESULT_SLT = ($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;             // Set less than
    assign #2 RESULT_SLTU = ($unsigned(DATA1) < $unsigned(DATA2)) ? 1'b1 : 1'b0;        // Set less than for unsigned integer

    assign #1 RESULT_AND = DATA1 & DATA2;       // Bitwise AND operation
    assign #1 RESULT_OR = DATA1 | DATA2;        // Bitwise OR operation
    assign #1 RESULT_XOR = DATA1 ^ DATA2;       // Bitwise XOR operation

    assign #3 RESULT_MUL = DATA1 * DATA2;                       // Multiplication
    assign #3 RESULT_MULH = $signed(DATA1) * $signed(DATA2);    // Multiplication of signed x signed integer
    assign #3 RESULT_MULHU = $unsigned(DATA1) * $unsigned(DATA2);
    assign #3 RESULT_MULHSU = $signed(DATA1) * $unsigned(DATA2);

    assign #3 RESULT_DIV = $signed(DATA1) / $signed(DATA2);         // Division of signed integers
    assign #3 RESULT_DIVU = $unsigned(DATA1) / $unsigned(DATA2);    // Division of unsigned integers
    assign #3 RESULT_REM = $signed(DATA1) % $signed(DATA2);         // Remainder of signed integers
    assign #3 RESULT_REMU = $unsigned(DATA1) % $unsigned(DATA2);    // Remainder of unsigned integers

    always @(*)
    begin
        case(OPCODE)
            `ADD:    ALU_RESULT = RESULT_ADD; 
            `SUB:    ALU_RESULT = RESULT_SUB; 
            `SLL:    ALU_RESULT = RESULT_SLL; 
            `SRL:    ALU_RESULT = RESULT_SRL; 
            `SRA:    ALU_RESULT = RESULT_SRA; 
            `SLT:    ALU_RESULT = RESULT_SLT; 
            `SLTU:   ALU_RESULT = RESULT_SLTU; 
            `AND:    ALU_RESULT = RESULT_AND;
            `OR:     ALU_RESULT = RESULT_OR;
            `XOR:    ALU_RESULT = RESULT_XOR;              
            `MUL:    ALU_RESULT = RESULT_MUL; 
            `MULH:   ALU_RESULT = RESULT_MULH[63:32]; 
            `MULHSU: ALU_RESULT = RESULT_MULHU[63:32]; 
            `MULHU:  ALU_RESULT = RESULT_MULHSU[63:32]; 
            `DIV:    ALU_RESULT = RESULT_DIV; 
            `DIVU:   ALU_RESULT = RESULT_DIVU; 
            `REM :   ALU_RESULT = RESULT_REM; 
            `REMU:   ALU_RESULT = RESULT_REMU; 
                
            default:  ALU_RESULT = 0 ;  
                                
        endcase
    end

endmodule