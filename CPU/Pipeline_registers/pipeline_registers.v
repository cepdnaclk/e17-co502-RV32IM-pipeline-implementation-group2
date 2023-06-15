/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Pipeline register modules for each stage of the RV32IM pipeline implementation
==============================================================
*/

/*
--------------------------------------------------------------------------
 Instruction Fetching Stage to Instruction Decode Stage Pipeline Register
--------------------------------------------------------------------------
*/

module inst_fetch_pipeline_reg(CLOCK, RESET, INSTRUCTION_IN, INSTRUCTION_OUT, PC_IN, PC_OUT);

    input [31:0] INSTRUCTION_IN, PC_IN;
    input CLOCK, RESET, BUSYWAIT;
    output reg [31:0] INSTRUCTION_OUT, PC_OUT;

    // Reset the registers
    always @(*)
    begin
        if (RESET)
        begin
            #1
            INSTRUCTION_OUT <= 32'dx;
            PC_OUT <= 32'dx;
        end
    end

    // Writing values to the output registers
    always @(posedge CLOCK)
    begin
        if (!BUSYWAIT)
        begin
            #1
            INSTRUCTION_OUT <= INSTRUCTION_IN;
            PC_OUT <= PC_IN;
        end
    end

endmodule


/*
-------------------------------------------------------------------
 Instruction Decoding Stage to Execution Stage Pipeline Register
-------------------------------------------------------------------
*/

module inst_decode_pipeline_reg(
    CLOCK, RESET, BUSYWAIT,
    INSTRUCTION_IN, INSTRUCTION_OUT, 
    PC_IN, PC_OUT,
    DATA1_IN, DATA1_OUT,
    DATA2_IN, DATA2_OUT,
    IMMEDIATE_IN, IMMEDIATE_OUT,
    OP1_SEL_IN, OP1_SEL_OUT,
    OP2_SEL_IN, OP2_SEL_OUT,
    ALU_OPCODE_IN, ALU_OPCODE_OUT,
    BRANCH_JUMP_IN, BRANCH_JUMP_OUT,
    DATA_MEM_READ_IN, DATA_MEM_READ_OUT,
    DATA_MEM_WRITE_IN, DATA_MEM_WRITE_OUT,
    WB_SEL_IN, WB_SEL_OUT,
    REG_WRITE_ENABLE_IN, REG_WRITE_ENABLE_OUT);

    input CLOCK, RESET, BUSYWAIT;
    
    input [3:0] ALU_OPCODE_IN; 
    input [4:0] INSTRUCTION_IN;
    input [2:0] BRANCH_JUMP_IN;
    input [1:0] DATA_MEM_WRITE_IN, WB_SEL_IN, OP1_SEL_IN, OP2_SEL_IN;
    input [2:0] DATA_MEM_READ_IN;
    input [31:0] PC_IN, DATA1_IN, DATA2_IN, IMMEDIATE_IN;
    input REG_WRITE_ENABLE_IN;

    output reg [3:0] ALU_OPCODE_OUT;
    output reg [4:0] INSTRUCTION_OUT;
    output reg [2:0] BRANCH_JUMP_OUT;
    output reg [1:0] DATA_MEM_WRITE_OUT, WB_SEL_OUT, OP1_SEL_OUT, OP2_SEL_OUT;
    output reg [2:0] DATA_MEM_READ_OUT;
    output reg [31:0] PC_OUT, DATA1_OUT, DATA2_OUT, IMMEDIATE_OUT;
    output reg REG_WRITE_ENABLE_OUT;

    // Reset the registers
    always @(*)
    begin
        if (RESET)
        begin
            #1
            ALU_OPCODE_OUT <= 4'dx;
            INSTRUCTION_OUT <= 5'dx;
            BRANCH_JUMP_OUT <= 3'dx;
            WB_SEL_OUT <= 2'dx;
            OP1_SEL_OUT <= 2'dx;
            OP2_SEL_OUT <= 2'dx;
            DATA_MEM_WRITE_OUT <= 2'dx;
            DATA_MEM_READ_OUT <= 3'dx;
            PC_OUT <= 32'dx;
            DATA1_OUT <= 32'dx;
            DATA2_OUT <= 32'dx;
            IMMEDIATE_OUT <= 32'dx;
            REG_WRITE_ENABLE_OUT <= 1'dx;
        end
    end

    // Writing values to the output registers
    always @(posedge CLOCK)
    begin
        if (!BUSYWAIT)
        begin
            #1
            ALU_OPCODE_OUT <= ALU_OPCODE_IN;
            INSTRUCTION_OUT <= INSTRUCTION_IN;
            BRANCH_JUMP_OUT <= BRANCH_JUMP_IN;
            WB_SEL_OUT <= WB_SEL_IN;
            OP1_SEL_OUT <= OP1_SEL_IN;
            OP2_SEL_OUT <= OP2_SEL_IN;
            DATA_MEM_WRITE_OUT <= DATA_MEM_WRITE_IN;
            DATA_MEM_READ_OUT <= DATA_MEM_READ_IN;
            PC_OUT <= PC_IN;
            DATA1_OUT <= DATA1_IN;
            DATA2_OUT <= DATA2_IN;
            IMMEDIATE_OUT <= IMMEDIATE_IN;
            REG_WRITE_ENABLE_OUT <= REG_WRITE_ENABLE_IN;
        end
    end

endmodule


/*
--------------------------------------------------------------
 Execution Stage to Memory Access Stage Pipeline Register
--------------------------------------------------------------
*/

module execute_pipeline_reg(CLOCK, RESET, 
    INSTRUCTION_IN, INSTRUCTION_OUT, 
    PC_IN, PC_OUT,
    ALU_RESULT_IN, ALU_RESULT_OUT,
    DATA2_IN, DATA2_OUT,
    IMMEDIATE_IN, IMMEDIATE_OUT,
    DATA_MEM_READ_IN, DATA_MEM_READ_OUT,
    DATA_MEM_WRITE_IN, DATA_MEM_WRITE_OUT,
    WB_SEL_IN, WB_SEL_OUT,
    REG_WRITE_ENABLE_IN, REG_WRITE_ENABLE_OUT
    );

    input CLOCK, RESET, BUSYWAIT;
    
    input [4:0] INSTRUCTION_IN;
    input [1:0] DATA_MEM_WRITE_IN, WB_SEL_IN;
    input [2:0] DATA_MEM_READ_IN;
    input [31:0] PC_IN, ALU_RESULT_IN, DATA2_IN, IMMEDIATE_IN;
    input REG_WRITE_ENABLE_IN;

    output reg [4:0] INSTRUCTION_OUT;
    output reg [1:0] DATA_MEM_WRITE_OUT, WB_SEL_OUT;
    output reg [2:0] DATA_MEM_READ_OUT;
    output reg [31:0] PC_OUT, ALU_RESULT_OUT, DATA2_OUT, IMMEDIATE_OUT;
    output reg REG_WRITE_ENABLE_OUT;

    // Reset the registers
    always @(*)
    begin
        if (RESET)
        begin
            #1
            INSTRUCTION_OUT <= 5'dx;
            WB_SEL_OUT <= 2'dx;
            DATA_MEM_WRITE_OUT <= 2'dx;
            DATA_MEM_READ_OUT <= 3'dx;
            PC_OUT <= 32'dx;
            DATA2_OUT <= 32'dx;
            IMMEDIATE_OUT <= 32'dx;
            REG_WRITE_ENABLE_OUT <= 1'dx;
            ALU_RESULT_OUT <= 32'dx;
        end
    end

    // Writing values to the output registers
    always @(posedge CLOCK)
    begin
        if (!BUSYWAIT)
        begin
            #1
            INSTRUCTION_OUT <= INSTRUCTION_IN;
            WB_SEL_OUT <= WB_SEL_IN;
            DATA_MEM_WRITE_OUT <= DATA_MEM_WRITE_IN;
            DATA_MEM_READ_OUT <= DATA_MEM_READ_IN;
            PC_OUT <= PC_IN;
            DATA2_OUT <= DATA2_IN;
            IMMEDIATE_OUT <= IMMEDIATE_IN;
            REG_WRITE_ENABLE_OUT <= REG_WRITE_ENABLE_IN;
            ALU_RESULT_OUT <= ALU_RESULT_IN;
        end
    end

endmodule


/*
--------------------------------------------------------------
 Memory Access Stage to Write Back Stage Pipeline Register
--------------------------------------------------------------
*/

module memory_access_pipeline_reg(CLOCK, RESET, 
    INSTRUCTION_IN, INSTRUCTION_OUT, 
    PC_ADDER_IN, PC_ADDER_OUT,
    ALU_RESULT_IN, ALU_RESULT_OUT,
    IMMEDIATE_IN, IMMEDIATE_OUT,
    DATA_MEM_RESULT_IN, DATA_MEM_RESULT_OUT,
    WB_SEL_IN, WB_SEL_OUT,
    REG_WRITE_ENABLE_IN, REG_WRITE_ENABLE_OUT)

    input CLOCK, RESET, BUSYWAIT;
    
    input [4:0] INSTRUCTION_IN;
    input [1:0] WB_SEL_IN;
    input [31:0] PC_ADDER_IN, ALU_RESULT_IN, IMMEDIATE_IN, DATA_MEM_RESULT_IN;
    input REG_WRITE_ENABLE_IN;

    output reg [4:0] INSTRUCTION_OUT;
    output reg [1:0] WB_SEL_OUT;
    output reg [31:0] PC_ADDER_OUT, ALU_RESULT_OUT, IMMEDIATE_OUT, DATA_MEM_RESULT_OUT;
    output reg REG_WRITE_ENABLE_OUT;

    // Reset the registers
    always @(*)
    begin
        if (RESET)
        begin
            #1
            INSTRUCTION_OUT <= 5'dx;
            WB_SEL_OUT <= 2'dx;
            PC_ADDER_OUT <= 32'dx;
            IMMEDIATE_OUT <= 32'dx;
            REG_WRITE_ENABLE_OUT <= 1'dx;
            ALU_RESULT_OUT <= 32'dx;
            DATA_MEM_RESULT_OUT <= 32'dx;
        end
    end

    // Writing values to the output registers
    always @(posedge CLOCK)
    begin
        if (!BUSYWAIT)
        begin
            #1
            INSTRUCTION_OUT <= INSTRUCTION_IN;
            WB_SEL_OUT <= WB_SEL_IN;
            PC_ADDER_OUT <= PC_ADDER_IN;
            IMMEDIATE_OUT <= IMMEDIATE_IN;
            REG_WRITE_ENABLE_OUT <= REG_WRITE_ENABLE_IN;
            ALU_RESULT_OUT <= ALU_RESULT_IN;
            DATA_MEM_RESULT_OUT <= DATA_MEM_RESULT_IN;
        end
    end

endmodule


/*
--------------------------------------------------------------
 Extra Pipeline Register - Pipeline register 5
--------------------------------------------------------------
*/
module write_back_pipeline_reg(CLOCK, RESET, 
    WB_DATA_IN, WB_DATA_OUT, 
    REG_WRITE_EN_IN, REG_WRITE_EN_OUT,
    REG_ADDR_IN, REG_ADDR_OUT)

    input CLOCK, RESET;
    
    input [4:0] REG_ADDR_IN;
    input [31:0] WB_DATA_IN;
    input REG_WRITE_EN_IN;

    output reg [4:0] REG_ADDR_IN;
    output reg [31:0] WB_DATA_IN;
    output reg REG_WRITE_EN_IN;

    // Reset the registers
    always @(*)
    begin
        if (RESET)
        begin
            #1
            REG_ADDR_OUT <= 5'dx;
            WB_DATA_OUT <= 32'dx;
            REG_WRITE_ENABLE_OUT <= 1'dx;
        end
    end

    // Writing values to the output registers
    always @(posedge CLOCK)
    begin
        if (!BUSYWAIT)
        begin
            #1
            REG_ADDR_OUT <= REG_ADDR_IN;
            WB_DATA_OUT <= WB_DATA_IN;
            REG_WRITE_ENABLE_OUT <= REG_WRITE_ENABLE_IN;
        end
    end

endmodule
