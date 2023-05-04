/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Definitions used for the RV32IM pipeline implementation
==============================================================
*/

// Defining the OPCODES for the functions used in the ALU
`define ADD 5'b00000
`define SUB 5'b00010
`define SLL 5'b00100
`define SLT 5'b01000
`define SLTU 5'b01100
`define XOR 5'b10000
`define SRL 5'b10100
`define SRA 5'b10110
`define OR 5'b11000
`define AND 5'b11100
`define MUL 5'b00001
`define MULH 5'b00101
`define MULHSU 5'b01001
`define MULHU 5'b01101
`define DIV 5'b10001
`define DIVU 5'b10101
`define REM 5'b11001
`define REMU 5'b11101



// Encoding formats for the signals from the Control Unit
// OP1_SEL - Selection of 2x1 MUX 1
`define DATA1 1'b0
`define PC 1'b1

// OP2_SEL - Selection of 2x1 MUX 2
`define DATA2 1'b0
`define IMM 1'b1

// MEM_READ - Select the required load(read) instruction
`define MEM_READ_0 3'b000                                   // Doesn't read anything
`define LB 3'b001
`define LH 3'b010
`define LW 3'b011
`define LBU 3'b100
`define LHU 3'b101

// MEM_WRITE - Select the required store(write) instruction
`define MEM_WRITE_0 2'b00                                   // Doesn't write anything
`define SB 2'b01
`define SH 2'b10
`define SW 2'b11

// BRANCH_JUMP - Select the relavant Branch or Jump action
`define BRANCH_JUMP_0 3'b000
`define BEQ 3'b001
`define BNE 3'b010
`define BLT 3'b011
`define BGE 3'b100
`define BLTU 3'b101
`define BGEU 3'b110
`define JUMP 3'b111


// IMM_SEL - Select the Immediate values and signals 
`define U_TYPE 3'b000
`define J_TYPE 3'b001
`define S_TYPE 3'b010
`define B_TYPE 3'b011
`define I_TYPE 3'b100
`define I_TYPE_SHIFT 3'b110
`define I_TYPE_UNSIGNED 3'b111

// WB_SEL - Select the control signal of the 4x1 MUX which is used to store data in the reister (Write Signal)
`define ALU_RESULT 2'b00
`define DATA_MEM 2'b01
`define IMM_VALUE 2'b10
`define PC_VALUE 2'b11

// REG_WRITE_ENABLE - Select the Write Enable signal
`define REG_WRITE_ENABLE_0 1'b0
`define REG_WRITE_ENABLE_1 1'b1













