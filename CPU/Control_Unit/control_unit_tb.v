/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Testbench for the Control Unit for the RV32IM pipeline implementation
==============================================================
*/

`include "definitions.v"
`include "control_unit.v"

`define CONTROL_UNIT_DELAY #2

`define assert(sig, val) \
    if (sig !== val) begin \
        $display("ASSERTION FAILED in %m: sig != %d [original value %d]", val, sig); \
        $finish; \
    end

module control_unit_tb;

    reg [31:0] INSTRUCTION;

    wire OP1_SEL, OP2_SEL, REG_WRITE_ENABLE;
    wire [2:0]MEM_READ, IMM_SEL, BRANCH_JUMP;
    wire [1:0]MEM_WRITE, WB_SEL;
    wire [4:0]ALU_OPCODE;

    control_unit my_control_unit(INSTRUCTION, IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

    initial 
    begin

        // Tests for the I-Type Instructions
        /*===========================================
            TEST 01
            INSTRUCTION : LB
        =============================================*/
        $display("Test 01 : LB Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx000xxxxx0000011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`LB);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : LB, Test Status : Passed\n");

        //test_control_unit(`I_TYPE, `DATA1, `IMM, `ADD, `MEM_WRITE_0, `LH, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);

        /*===========================================
            TEST 02
            INSTRUCTION : LH
        =============================================*/
        $display("Test 02 : LH Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx001xxxxx0000011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`LH);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        //test_control_unit(`I_TYPE, `DATA1, `IMM, `ADD, `MEM_WRITE_0, `LH, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : LH, Test Status : Passed\n");


        /*===========================================
            TEST 03
            INSTRUCTION : LW
        =============================================*/
        $display("Test 03 : LW Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx010xxxxx0000011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`LW);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);


        //test_control_unit(`I_TYPE, `DATA1, `IMM, `ADD, `MEM_WRITE_0, `LW, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : LW, Test Status : Passed\n");


        /*===========================================
            TEST 04
            INSTRUCTION : LBU
        =============================================*/
        $display("Test 04 : LBU Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx100xxxxx0000011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`LBU);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `ADD, `MEM_WRITE_0, `LBU, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : LBU, Test Status : Passed\n");


        /*===========================================
            TEST 05
            INSTRUCTION : LHU
        =============================================*/
        $display("Test 05 : LHU Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx101xxxxx0000011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`LHU);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `ADD, `MEM_WRITE_0, `LHU, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : LHU, Test Status : Passed\n");


        /*===========================================
            TEST 06
            INSTRUCTION : ADDI
        =============================================*/
        $display("Test 06 : ADDI Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx000xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `ADD, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : ADDI, Test Status : Passed\n");


        /*===========================================
            TEST 07
            INSTRUCTION : SLTI
        =============================================*/
        $display("Test 07 : SLTI Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx010xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`SLT);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `SLT, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SLTI, Test Status : Passed\n");


        /*===========================================
            TEST 08
            INSTRUCTION : SLTIU
        =============================================*/
        $display("Test 08 : SLTIU Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx011xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE_UNSIGNED);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`SLTU);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE_UNSIGNED, `DATA1, `IMM, `SLTU, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SLTIU, Test Status : Passed\n");


        /*===========================================
            TEST 09
            INSTRUCTION : XORI
        =============================================*/
        $display("Test 09 : XORI Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx100xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`XOR);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `XOR, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : XORI, Test Status : Passed\n");


        /*===========================================
            TEST 10
            INSTRUCTION : ORI
        =============================================*/
        $display("Test 10 : ORI Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx110xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`OR);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `OR, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : ORI, Test Status : Passed\n");


        /*===========================================
            TEST 11
            INSTRUCTION : ANDI
        =============================================*/
        $display("Test 11 : ANDI Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx111xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`AND);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `AND, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : ANDI, Test Status : Passed\n");


        /*===========================================
            TEST 12
            INSTRUCTION : SLLI
        =============================================*/
        $display("Test 12 : SLLI Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx001xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE_SHIFT);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`SLL);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE_SHIFT, `DATA1, `IMM, `SLL, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SLLI, Test Status : Passed\n");


        /*===========================================
            TEST 13
            INSTRUCTION : SRLI
        =============================================*/
        $display("Test 13 : SRLI Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx101xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE_SHIFT);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`SRL);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE_SHIFT, `DATA1, `IMM, `SRL, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SRLI, Test Status : Passed\n");


        /*===========================================
            TEST 14
            INSTRUCTION : SRAI
        =============================================*/
        $display("Test 14 : SRAI Instruction\n");
        INSTRUCTION = 32'b0100000xxxxxxxxxx101xxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE_SHIFT);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`SRA);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE_SHIFT, `DATA1, `IMM, `SRA, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SRAI, Test Status : Passed\n");


        /*===========================================
            TEST 15
            INSTRUCTION : JALR
        =============================================*/
        $display("Test 15 : JALR Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100111;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`I_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`JUMP);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`I_TYPE, `DATA1, `IMM, `ADD, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `PC_VALUE, `JUMP);
        
        $display("Instruction : JALR, Test Status : Passed\n");


        // Tests for the S-Type Instructions
        /*===========================================
            TEST 16
            INSTRUCTION : SB
        =============================================*/
        $display("Test 16 : SB Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx000xxxxx0100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`S_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`SB);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`S_TYPE, `DATA1, `IMM, `ADD, `SB, `MEM_READ_0, `REG_WRITE_ENABLE_0, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SB, Test Status : Passed\n");


        /*===========================================
            TEST 17
            INSTRUCTION : SH
        =============================================*/
        $display("Test 17 : SH Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx001xxxxx0100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`S_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`SH);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`S_TYPE, `DATA1, `IMM, `ADD, `SH, `MEM_READ_0, `REG_WRITE_ENABLE_0, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SH, Test Status : Passed\n");


        /*===========================================
            TEST 18
            INSTRUCTION : SW
        =============================================*/
        $display("Test 18 : SW Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx010xxxxx0100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`S_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`SW);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`S_TYPE, `DATA1, `IMM, `ADD, `SW, `MEM_READ_0, `REG_WRITE_ENABLE_0, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SW, Test Status : Passed\n");


        // Tests for the R-Type Instructions  
        /*===========================================
            TEST 19
            INSTRUCTION : ADD
        =============================================*/
        $display("Test 19 : ADD Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx000xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `ADD, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : ADD, Test Status : Passed\n");


        /*===========================================
            TEST 20
            INSTRUCTION : SUB
        =============================================*/
        $display("Test 20 : SUB Instruction\n");
        INSTRUCTION = 32'b0100000xxxxxxxxxx000xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`SUB);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `SUB, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SUB, Test Status : Passed\n");


        /*===========================================
            TEST 21
            INSTRUCTION : SLL
        =============================================*/
        $display("Test 21 : SLL Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx001xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`SLL);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `SLL, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SLL, Test Status : Passed\n");


        /*===========================================
            TEST 22
            INSTRUCTION : SLT
        =============================================*/
        $display("Test 22 : SLT Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx010xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`SLT);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `SLT, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SLT, Test Status : Passed\n");


        /*===========================================
            TEST 23
            INSTRUCTION : SLTU
        =============================================*/
        $display("Test 23 : SLTU Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx011xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`SLTU);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `SLTU, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SLTU, Test Status : Passed\n");


        /*===========================================
            TEST 24
            INSTRUCTION : XOR
        =============================================*/
        $display("Test 24 : XOR Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx100xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`XOR);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `XOR, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : XOR, Test Status : Passed\n");


        /*===========================================
            TEST 25
            INSTRUCTION : SRL
        =============================================*/
        $display("Test 25 : SRL Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx101xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`SRL);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `SRL, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SRL, Test Status : Passed\n");


        /*===========================================
            TEST 26
            INSTRUCTION : SRA
        =============================================*/
        $display("Test 26 : SRA Instruction\n");
        INSTRUCTION = 32'b0100000xxxxxxxxxx101xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`SRA);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);


        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `SRA, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : SRA, Test Status : Passed\n");


        /*===========================================
            TEST 27
            INSTRUCTION : OR
        =============================================*/
        $display("Test 27 : OR Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx110xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`OR);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `OR, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : OR, Test Status : Passed\n");


        /*===========================================
            TEST 28
            INSTRUCTION : AND
        =============================================*/
        $display("Test 28 : AND Instruction\n");
        INSTRUCTION = 32'b0000000xxxxxxxxxx111xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`AND);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `AND, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : AND, Test Status : Passed\n");


        /*===========================================
            TEST 29
            INSTRUCTION : MUL
        =============================================*/
        $display("Test 29 : MUL Instruction\n");
        INSTRUCTION = 32'b0000001xxxxxxxxxx000xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`MUL);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `MUL, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : MUL, Test Status : Passed\n");


        /*===========================================
            TEST 30
            INSTRUCTION : MULH
        =============================================*/
        $display("Test 30 : MULH Instruction\n");
        INSTRUCTION = 32'b0000001xxxxxxxxxx001xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`MULH);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `MULH, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : MULH, Test Status : Passed\n");


        /*===========================================
            TEST 31
            INSTRUCTION : MULHSU
        =============================================*/
        $display("Test 31 : MULHSU Instruction\n");
        INSTRUCTION = 32'b0000001xxxxxxxxxx010xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`MULHSU);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `MULHSU, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : MULHSU, Test Status : Passed\n");


        /*===========================================
            TEST 32
            INSTRUCTION : MULHU
        =============================================*/
        $display("Test 32 : MULHU Instruction\n");
        INSTRUCTION = 32'b0000001xxxxxxxxxx011xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`MULHU);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `MULHU, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : MULHU, Test Status : Passed\n");


        /*===========================================
            TEST 33
            INSTRUCTION : DIV
        =============================================*/
        $display("Test 33 : DIV Instruction\n");
        INSTRUCTION = 32'b0000001xxxxxxxxxx100xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`DIV);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `DIV, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : DIV, Test Status : Passed\n");


        /*===========================================
            TEST 34
            INSTRUCTION : REM
        =============================================*/
        $display("Test 34 : REM Instruction\n");
        INSTRUCTION = 32'b0000001xxxxxxxxxx110xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`REM);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `REM, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : REM, Test Status : Passed\n");


        /*===========================================
            TEST 35
            INSTRUCTION : REMU
        =============================================*/
        $display("Test 35 : REMU Instruction\n");
        INSTRUCTION = 32'b0000001xxxxxxxxxx111xxxxx0110011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        `assert(OP1_SEL,`DATA1);
        `assert(OP2_SEL,`DATA2);
        `assert(ALU_OPCODE,`REMU);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);

        
        //test_control_unit(`U_TYPE, `DATA1, `DATA2, `REMU, `MEM_WRITE_0, `MEM_READ_0, `REG_WRITE_ENABLE_1, `ALU_RESULT, `BRANCH_JUMP_0);
        
        $display("Instruction : REMU, Test Status : Passed\n");

        
        // U-Type Instructions
        /*===========================================
            TEST 36
            INSTRUCTION : LUI
        =============================================*/
        $display("Test 36 : LUI Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        //`assert(OP1_SEL,`DATA1);
        //`assert(OP2_SEL,`DATA2);
        //`assert(ALU_OPCODE,`REMU);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`IMM_VALUE);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : LUI, Test Status : Passed\n");



        /*===========================================
            TEST 37
            INSTRUCTION : AUIPC
        =============================================*/
        $display("Test 37 : AUIPC Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxxxxxxxxxx0010011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`U_TYPE);
        //`assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        //`assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`ALU_RESULT);
        `assert(BRANCH_JUMP,`BRANCH_JUMP_0);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : AUIPC, Test Status : Passed\n");


        // J-Type Instructions
        /*===========================================
            TEST 38
            INSTRUCTION : JAL
        =============================================*/
        $display("Test 38 : JAL Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`J_TYPE);
        `assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_1);
        `assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`JUMP);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : JAL, Test Status : Passed\n");


        // B-Type Instructions
        /*===========================================
            TEST 39
            INSTRUCTION : BEQ
        =============================================*/
        $display("Test 39 : BEQ Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx000xxxxx1100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        //`assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`BEQ);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : BEQ, Test Status : Passed\n");


        /*===========================================
            TEST 40
            INSTRUCTION : BNE
        =============================================*/
        $display("Test 40 : BNE Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx001xxxxx1100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        //`assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`BNE);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : BNE, Test Status : Passed\n");


        /*===========================================
            TEST 41
            INSTRUCTION : BLT
        =============================================*/
        $display("Test 41 : BLT Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx100xxxxx1100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        //`assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`BLT);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : BLT, Test Status : Passed\n");


        /*===========================================
            TEST 42
            INSTRUCTION : BGE
        =============================================*/
        $display("Test 42 : BGE Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx101xxxxx1100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        //`assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`BGE);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : BGE, Test Status : Passed\n");


        /*===========================================
            TEST 43
            INSTRUCTION : BLTU
        =============================================*/
        $display("Test 43 : BLTU Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx110xxxxx1100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        //`assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`BLTU);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : BLTU, Test Status : Passed\n");


        /*===========================================
            TEST 44
            INSTRUCTION : BGEU
        =============================================*/
        $display("Test 44 : BGEU Instruction\n");
        INSTRUCTION = 32'bxxxxxxxxxxxxxxxxx111xxxxx1100011;
        `CONTROL_UNIT_DELAY;

        `assert(IMM_SEL,`B_TYPE);
        `assert(OP1_SEL,`PC);
        `assert(OP2_SEL,`IMM);
        `assert(ALU_OPCODE,`ADD);
        `assert(MEM_WRITE,`MEM_WRITE_0);
        `assert(MEM_READ,`MEM_READ_0);
        `assert(REG_WRITE_ENABLE,`REG_WRITE_ENABLE_0);
        //`assert(WB_SEL,`PC_VALUE);
        `assert(BRANCH_JUMP,`BGEU);
        // Display the correct results
        $display("IMM_SEL: %b, OP1_SEL: %b, OP2_SEL: %b, ALU_OPCODE: %b, MEM_WRITE: %b, MEM_READ: %b, REG_WRITE_ENABLE: %b, WB_SEL: %b, BRANCH_JUMP: %b\n", IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP);
        $display("Instruction : BGEU, Test Status : Passed\n");

        $finish;

    end

endmodule