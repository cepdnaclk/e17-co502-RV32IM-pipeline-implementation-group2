/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        CPU module for the RV32IM pipeline implementation
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


module cpu (
    CLOCK, RESET, 
    INST_CACHE_READ_DATA, INST_CACHE_READ_ENABLE, INST_CACHE_BUSYWAIT, INST_CACHE_ADDRESS, 
    DATA_CACHE_READ_DATA, DATA_CACHE_WRITE_DATA, DATA_CACHE_READ_ENABLE, DATA_CACHE_WRITE_ENABLE, DATA_CACHE_BUSYWAIT, DATA_CACHE_ADDRESS
)

    /*---------------------------------------------------
        INPUT AND OUTPUT SIGNALS TO THE CPU
    ---------------------------------------------------*/

    input CLOCK, RESET;
    input [31:0] INST_CACHE_READ_DATA;
    input INST_CACHE_BUSYWAIT;
    output INST_CACHE_READ_ENABLE;
    output [31:0] INST_CACHE_ADDRESS;

    input [31:0] DATA_CACHE_READ_DATA;
    input DATA_CACHE_BUSYWAIT;
    output DATA_CACHE_READ_ENABLE, DATA_CACHE_WRITE_ENABLE;
    output [31:0] DATA_CACHE_ADDRESS, DATA_CACHE_WRITE_DATA;


    /*---------------------------------------------------
        WIRES CONNECTING THE MODULES
    ---------------------------------------------------*/
    
    wire [4:0] ALU_OPCODE;
    wire [31:0] OPERAND1, OPERAND2, ALU_RESULT, WRITE_DATA, IMM_OUT;
    
    wire [31:0] DATA1, DATA2;
    wire [31:0] INSTRUCTION;
    wire OP1_SEL, OP2_SEL, REG_WRITE_ENABLE, WRITE_ENABLE;
    wire [2:0] IMM_SEL, MEM_READ, BRANCH_JUMP_SEL;
    wire [1:0] MEM_WRITE, WB_SEL;  

    wire [4:0] DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS;


    assign INSTRUCTION = INST_CACHE_READ_DATA;
    assign DATA1_ADDRESS = INST_CACHE_READ_DATA[19:15];
    assign DATA2_ADDRESS = INST_CACHE_READ_DATA[24:20];
    assign WRITE_ADDRESS = INST_CACHE_READ_DATA[11:7];

    /*--------------------------------
        INSTRUCTION FETCHING STAGE
    ---------------------------------*/
    adder_4bit pc_adder_inst(PC_ADDER_IN, PC_ADDER_OUT);
    //instruction_cache ins_cache(PC_OUT, INSTRUCTION, BUSYWAIT, INS_MEM_READ, INS_MEM_ADDRESS, INS_MEM_INSTRUCTION, INS_MEM_BUSYWAIT, CLK, RESET);
    mux_2x1 pc_sel_mux(PC_IN, PC_ADDER_OUT, ALU_RESULT);
    program_counter pc(CLOCK, RESET, BUSYWAIT, PC_IN, PC_OUT);

    /*--------------------------------
        INSTRUCTION DECODE STAGE
    ---------------------------------*/
    reg_file my_reg_file(DATA1, DATA2, WRITE_DATA, DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS, WRITE_ENABLE, CLK, RESET);
    immediate_select my_imm_sel(INSTRUCTION, IMM_SEL, IMM_OUT);
    control_unit my_control_unit(INSTRUCTION, IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP_SEL/*, RESET*/);
    
    /*--------------------------------
        ALU EXECUTE STAGE
    ---------------------------------*/
    mux_2x1 alu_in_mux1(OPERAND1, PC_OUT, DATA1, OP1_SEL);
    mux_2x1 alu_in_mux2(OPERAND2, DATA2, IMM_OUT, OP2_SEL);

    alu my_alu(DATA1, DATA2, ALU_RESULT, ALU_OPCODE);
    // ***Include the module for the branch select***
    branch_select branch_select(BRANCH_JUMP_OUT, DATA1, DATA2, BRANCH_JUMP_SEL);

    /*--------------------------------
        MEMORY ACCESS STAGE
    ---------------------------------*/
    //data_cache data_cache(CLOCK, RESET, MEM_READ, MEM_WRITE, read_data, write_data, ALU_RESULT, busywait, mem_read, mem_write, mem_read_data, mem_write_data, mem_address, mem_busywait);
    adder_4bit pc_out_adder(PC_OUT, WRITE_ADDRESS);

    /*---------------------------------------------------
        WRITE BACK STAGE
    ---------------------------------------------------*/    
    mux_4x1 wb_sel_mux(WRITE_DATA, PC_OUT, ALU_RESUTL, IMM_OUT, DATA_OUT, WB_SEL);


endmodule