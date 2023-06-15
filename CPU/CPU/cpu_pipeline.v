/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        CPU Pipelined module for the RV32IM pipeline implementation
==============================================================
*/

`include "../Support_Files/definitions.v"
`include "../ALU/alu.v"
`include "../Control_Unit/control_unit.v"
`include "../Immediate_Select/immediate_select.v"
`include "../Register_File/register_file.v"
`include "../Components/components.v"
`include "../Instruction_Cache/INS_CACHE_MEM.v"
`include "../Data_Cache/data_cache.v"
`include "../Pipeline_registers/pipeline_registers.v"
`include "../Hazard_Handling/hazard_handing.v"

module cpu_pipeline(
    CLOCK, RESET, 
    INST_MEM_READ_DATA, INST_MEM_READ_ENABLE, INST_MEM_BUSYWAIT, INST_MEM_ADDRESS, 
    DATA_MEM_READ_DATA, DATA_MEM_WB_DATA_PR5_IN,  DATA_MEM_READ_ENABLE, DATA_MEM_WRITE_ENABLE, DATA_MEM_BUSYWAIT, DATA_MEM_ADDRESS)

    /*---------------------------------------------------
        INPUT AND OUTPUT SIGNALS TO THE CPU
    ---------------------------------------------------*/

    input CLOCK, RESET;
    input [127:0] INST_MEM_READ_DATA;
    input INST_MEM_BUSYWAIT;
    output INST_MEM_READ_ENABLE;
    output [27:0] INST_MEM_ADDRESS;

    input [127:0] DATA_MEM_READ_DATA;
    input DATA_MEM_BUSYWAIT;
    output DATA_MEM_READ_ENABLE, DATA_MEM_WRITE_ENABLE;
    output [127:0] DATA_MEM_WB_DATA_PR5_IN; 
    output [27:0] DATA_MEM_ADDRESS;


    /*---------------------------------------------------
        WIRES CONNECTING THE MODULES
    ---------------------------------------------------*/
    
    wire [31:0] PC_IN, PC_OUT, PC_ADDER_IN, PC_ADDER_OUT, PC_PR1_OUT, PC_PR2_OUT, PC_PR3_OUT, PC_PR4_IN, PC_PR4_OUT;

    wire [4:0] ALU_OPCODE;
    wire [31:0] OPERAND1, OPERAND2, ALU_RESULT, WB_DATA_PR5_IN, WB_DATA_PR5_OUT; 
    
    wire [31:0] DATA1, DATA1_PR2_IN, DATA1_PR2_OUT; 
    wire [31:0] DATA2, DATA2_PR2_IN, DATA2_PR2_OUT;
    wire [31:0] IMM_PR2_IN, IMM_PR2_OUT, IMM_PR3_OUT, IMM_PR4_OUT;

    wire [31:0] INSTRUCTION, INSTRUCTION_PR1_OUT;
    wire OP1_ALU_SEL_PR2_IN, OP1_ALU_SEL_PR2_OUT, OP2_ALU_SEL_PR2_IN, OP2_ALU_SEL_PR2_OUT; 
    wire REG_WRITE_ENABLE, WRITE_ENABLE;
    wire [2:0] IMM_SEL, MEM_READ, BRANCH_JUMP_SEL;
    wire [1:0] MEM_WRITE, WB_SEL;  
    wire [1:0] DATA1_BJ_SEL_PR2_IN, DATA1_BJ_SEL_PR2_PR2_OUT, DATA2_BJ_SEL_PR2_IN, DATA2_BJ_SEL_PR2_PR2_OUT;

    wire [4:0] DATA1_ADDRESS, DATA2_ADDRESS, REG_ADDR_PR4_OUT, WRITE_ADDRESS;

    wire [4:0] REG_ADDR_PR2_IN, REG_ADDR_PR2_OUT, REG_ADDR_PR3_OUT, REG_ADDR_PR4_OUT, REG_ADDR_PR5_OUT;

    assign INSTRUCTION = INST_CACHE_READ_DATA;
    assign DATA1_ADDRESS = INST_CACHE_READ_DATA[19:15];
    assign DATA2_ADDRESS = INST_CACHE_READ_DATA[24:20];
    assign WRITE_ADDRESS = INST_CACHE_READ_DATA[11:7];

    wire PC_SEL, P_REG1_FLUSH, P_REG2_FLUSH;
    
    wire REG_WRITE_EN_PR4_OUT, REG_WRITE_EN_PR2_IN, REG_WRITE_EN_PR2_OUT, REG_WRITE_EN_PR3_OUT, REG_WRITE_EN_PR5_OUT, REG_ADDR1_PR2_OUT, REG_ADDR2_PR2_OUT;

    wire [31:0] ALU_DATA1, ALU_DATA2, ALU_RESULT_PR3_IN, ALU_RESULT_PR3_OUT, ALU_RESULT_PR4_OUT;

    wire OP1_SEL_PR2_IN, OP2_SEL_PR2_IN, OP1_SEL_PR2_OUT, OP2_SEL_PR2_OUT;

    wire [4:0] ALU_OPCODE_PR2_IN, ALU_OPCODE_PR2_OUT;

    wire [1:0] DATA_MEM_WRITE_PR2_IN, DATA_MEM_WRITE_PR2_OUT, DATA_MEM_WRITE_PR3_OUT, FU_OP1_SEL, FU_OP2_SEL;

    wire [2:0] DATA_MEM_READ_PR2_IN, DATA_MEM_READ_PR2_OUT, DATA_MEM_READ_PR3_OUT, DATA_MEM_READ_PR4_OUT;

    wire [2:0] BRANCH_JUMP_PR2_IN, BRANCH_JUMP_PR2_OUT;

    wire WB_SEL_PR2_IN, WB_SEL_PR2_OUT, WB_SEL_PR3_OUT, WB_SEL_PR4_OUT, MEM_ADDR_SEL;

    wire [127:0] MEM_DATA_IN, MEM_DATA_OUT_PR4_IN, MEM_DATA_OUT_PR4_OUT; 

    /*--------------------------------
        INSTRUCTION FETCHING STAGE
    ---------------------------------*/
    mux_2x1 pc_sel_mux(PC_IN, PC_ADDER_OUT, ALU_RESULT_PR3_IN, PC_SEL);
    program_counter program_counter(CLOCK, RESET, PC_IN, PC_OUT);
    instruction_mem inst_mem(PC_OUT, INSTRUCTION, CLOCK, RESET); //
    adder_4bit pc_adder_inst(PC_OUT, PC_ADDER_OUT);

    inst_fetch_pipeline_reg if_id_p_reg(CLOCK, P_REG1_FLUSH, INSTRUCTION, INSTRUCTION_PR1_OUT, PC_OUT, PC_PR1_OUT);


    /*--------------------------------
        INSTRUCTION DECODE STAGE
    ---------------------------------*/
    reg_file my_reg_file(DATA1_PR2_IN, DATA2_PR2_IN, WB_DATA_PR5_IN,  DATA1_ADDRESS, DATA2_ADDRESS, REG_ADDR_PR4_OUT, REG_WRITE_EN_PR4_OUT, CLOCK, RESET);
    immediate_select my_imm_sel(INSTRUCTION_PR1_OUT, IMM_SEL, IMM_PR2_IN);
    control_unit my_control_unit(INSTRUCTION_PR1_OUT, IMM_SEL, OP1_SEL_PR2_IN, OP2_SEL_PR2_IN, ALU_OPCODE_PR2_IN, DATA_MEM_WRITE_PR2_IN, DATA_MEM_READ_PR2_IN, REG_WRITE_EN_PR2_IN, WB_SEL_PR2_IN, BRANCH_JUMP_PR2_IN);
    
    flushing_unit bj_flushing_unit(BJ_SIG, P_REG1_FLUSH, P_REG2_FLUSH);

    inst_decode_pipeline_reg id_ie_p_reg(CLOCK, P_REG2_FLUSH, BUSYWAIT,
    REG_ADDR_PR2_IN, REG_ADDR_PR2_OUT, 
    PC_PR1_OUT, PC_PR2_OUT,
    DATA1_PR2_IN, DATA1_PR2_OUT,
    DATA2_PR2_IN, DATA2_PR2_OUT,
    IMM_PR2_IN, IMM_PR2_OUT,
    OP1_SEL_PR2_IN, OP1_SEL_PR2_OUT,
    OP2_SEL_PR2_IN, OP2_SEL_PR2_OUT,
    ALU_OPCODE_PR2_IN, ALU_OPCODE_PR2_OUT,
    BRANCH_JUMP_PR2_IN, BRANCH_JUMP_PR2_OUT,
    DATA_MEM_READ_PR2_IN, DATA_MEM_READ_PR2_OUT,
    DATA_MEM_WRITE_PR2_IN, DATA_MEM_WRITE_PR2_OUT,
    WB_SEL_PR2_IN, WB_SEL_PR2_OUT,
    REG_WRITE_EN_PR2_IN, REG_WRITE_EN_PR2_OUT);

    /*--------------------------------
        INSTRUCTION EXECUTION STAGE
    ---------------------------------*/
    mux_4x1 data1_sel_mux(DATA1, DATA1_PR2_OUT, ALU_RESULT_PR3_OUT, WB_DATA_PR5_IN, WB_DATA_PR5_OUT, FU_OP1_SEL);
    mux_4x1 data2_sel_mux(DATA2, DATA2_PR2_OUT, ALU_RESULT_PR3_OUT, WB_DATA_PR5_IN, WB_DATA_PR5_OUT, FU_OP2_SEL);

    mux_2x1 data1_alu_sel_mux(ALU_DATA1, DATA1, PC_PR2_OUT, OP1_SEL_PR2_OUT);
    mux_2x1 data2_alu_sel_mux(ALU_DATA2, DATA2, IMM_PR2_OUT, OP2_SEL_PR2_OUT);


    alu my_alu(ALU_DATA1, ALU_DATA2, ALU_RESULT_PR3_IN, ALU_OPCODE_PR2_OUT);
    branch_select branch_select(PC_SEL, DATA1, DATA2, BRANCH_JUMP_PR2_OUT);

    forwarding_unit_1 fowarding_unit_1(REG_WRITE_EN_PR3_OUT, REG_ADDR_PR2_OUT, REG_WRITE_EN_PR4_OUT, REG_ADDR_PR3_OUT, REG_WRITE_EN_PR5_OUT, REG_ADDR_PR5_OUT, FU_OP1_SEL, FU_OP2_SEL, REG_ADDR1_PR2_OUT, REG_ADDR2_PR2_OUT);

    execute_pipeline_reg ie_ma_p_reg(CLOCK, RESET, 
    REG_ADDR_PR2_OUT, REG_ADDR_PR3_OUT, // 
    PC_PR2_OUT, PC_PR3_OUT,
    ALU_RESULT_PR3_IN, ALU_RESULT_PR3_OUT,
    DATA2_PR2_OUT, DATA2_PR3_OUT,
    IMM_PR2_OUT, IMM_PR3_OUT, // 
    DATA_MEM_READ_PR2_OUT, DATA_MEM_READ_PR3_OUT,
    DATA_MEM_WRITE_PR2_OUT, DATA_MEM_WRITE_PR3_OUT,
    WB_SEL_PR2_OUT, WB_SEL_PR3_OUT,
    REG_WRITE_EN_PR2_OUT, REG_WRITE_EN_PR3_OUT);


    /*--------------------------------
        MEMORY STAGE
    ---------------------------------*/
    data_cache data_cache(CLOCK, RESET, DATA_MEM_READ_PR3_OUT, DATA_MEM_WRITE_PR3_OUT, MEM_DATA_IN, ALU_RESULT_PR3_OUT, MEM_DATA_OUT_PR4_IN);
    adder_4bit pc_out_adder(PC_OUT, REG_ADDR_PR4_OUT);

    forwarding_unit_2 forwarding_unit_2(DATA_MEM_WRITE_PR3_OUT, ALU_RESULT_PR3_OUT, DATA_MEM_READ_PR4_OUT, ALU_RESULT_PR4_OUT, MEM_ADDR_SEL);

    mux_2x1 data2_alu_sel_mux(MEM_DATA_IN, ALU_RESULT_PR3_OUT, MEM_DATA_OUT_PR4_OUT, MEM_ADDR_SEL);

    adder_4bit pc_adder_inst(PC_PR3_OUT, PC_PR4_IN);

    memory_access_pipeline_reg ma_wb_p_reg(CLOCK, RESET, 
    REG_ADDR_PR3_OUT, REG_ADDR_PR4_OUT, //
    PC_PR4_IN, PC_PR4_OUT,
    ALU_RESULT_PR3_OUT, ALU_RESULT_PR4_OUT,
    IMM_PR3_OUT, IMM_PR4_OUT, //
    MEM_DATA_OUT_PR4_IN, MEM_DATA_OUT_PR4_OUT,
    WB_SEL_PR3_OUT, WB_SEL_PR4_OUT,
    REG_WRITE_EN_PR3_OUT, REG_WRITE_EN_PR4_OUT);

    /*--------------------------------
        WRITE BACK STAGE
    ---------------------------------*/
    mux_4x1 wb_sel_mux(WB_DATA_PR5_IN,  PC_PR4_OUT, IMM_PR4_OUT, MEM_DATA_OUT_PR4_OUT, ALU_RESULT_PR4_OUT, WB_SEL_PR4_OUT);

    write_back_pipeline_reg wb_extra_p_reg(CLOCK, RESET, 
    WB_DATA_PR5_IN,  WB_DATA_PR5_OUT, 
    REG_WRITE_EN_PR4_OUT, REG_WRITE_EN_PR5_OUT,
    REG_ADDR_PR4_OUT, REG_ADDR_PR5_OUT);


endmodule