/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda, E/17/035 - K.T.M. Chamika
        Group 2
        Control Unit for the RV32IM pipeline implementation
==============================================================
*/

`include "../Support_Files/definitions.v"

module control_unit(INSTRUCTION, IMM_SEL, OP1_SEL, OP2_SEL, ALU_OPCODE, MEM_WRITE, MEM_READ, REG_WRITE_ENABLE, WB_SEL, BRANCH_JUMP/*, RESET*/); 

    input [31:0]INSTRUCTION;                        // 32 bit instruction
    //input RESET;                                    // Reset signals

    output reg OP1_SEL, OP2_SEL, REG_WRITE_ENABLE;
    output reg [2:0]MEM_READ, IMM_SEL, BRANCH_JUMP;
    output reg [1:0]MEM_WRITE, WB_SEL;
    output reg [4:0]ALU_OPCODE;

    wire [2:0]FUNC3;
    wire [6:0]OPCODE, FUNC7;

    assign OPCODE = INSTRUCTION[6:0];
    assign FUNC3 = INSTRUCTION[14:12];
    assign FUNC7 = INSTRUCTION[31:25];

    always @(*) begin
        case(OPCODE)
            #1
            //I-Type Instructions.
            7'b0000011:
                begin
                    IMM_SEL = `I_TYPE;
                    OP1_SEL = `DATA1;
                    OP2_SEL = `IMM;
                    ALU_OPCODE = `ADD;
                    MEM_WRITE = `MEM_WRITE_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_1;
                    WB_SEL = `ALU_RESULT;
                    BRANCH_JUMP = `BRANCH_JUMP_0;

                    case(FUNC3)
                        3'b000: MEM_READ = `LB;
                        3'b001: MEM_READ = `LH;
                        3'b010: MEM_READ = `LW;
                        3'b100: MEM_READ = `LBU;
                        3'b101: MEM_READ = `LHU;
                    endcase
                end

            7'b0010011:
                begin
                    OP1_SEL = `DATA1;
                    OP2_SEL = `IMM;
                    MEM_WRITE = `MEM_WRITE_0;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_1;
                    WB_SEL = `ALU_RESULT;
                    BRANCH_JUMP = `BRANCH_JUMP_0;                

                    case(FUNC3)
                        3'b000:
                            begin
                                IMM_SEL = `I_TYPE;
                                ALU_OPCODE = `ADD;
                            end
                        3'b010:
                            begin
                                IMM_SEL = `I_TYPE;
                                ALU_OPCODE = `SLT;
                            end
                        3'b011:
                            begin
                                IMM_SEL = `I_TYPE_UNSIGNED;
                                ALU_OPCODE = `SLTU;
                            end
                        3'b100:
                            begin
                                IMM_SEL = `I_TYPE;
                                ALU_OPCODE = `XOR;
                            end
                        3'b110:
                            begin
                                IMM_SEL = `I_TYPE;
                                ALU_OPCODE = `OR;
                            end
                        3'b111:
                            begin
                                IMM_SEL = `I_TYPE;
                                ALU_OPCODE = `AND;
                            end
                        3'b001:
                            begin
                                IMM_SEL = `I_TYPE_SHIFT;
                                ALU_OPCODE = `SLL;
                            end
                        3'b101:
                            begin
                                IMM_SEL = `I_TYPE_SHIFT;
                                case (FUNC7)
                                    7'b0000000: ALU_OPCODE = `SRL;
                                    7'b0100000: ALU_OPCODE = `SRA;
                                endcase
                            end
                    endcase
                end

            7'b1100111:                                         // Instruction - JALR
                begin
                    IMM_SEL = `I_TYPE;
                    OP1_SEL = `DATA1;
                    OP2_SEL = `IMM;
                    ALU_OPCODE = `ADD;
                    MEM_WRITE = `MEM_WRITE_0;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_1;
                    WB_SEL = `PC_VALUE;
                    BRANCH_JUMP = `JUMP;
                end


            // S-Type Instructions
            7'b0100011:
                begin
                    IMM_SEL = `S_TYPE;
                    OP1_SEL = `DATA1;
                    OP2_SEL = `IMM;
                    ALU_OPCODE = `ADD;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_0;
                    WB_SEL = `ALU_RESULT;
                    BRANCH_JUMP = `BRANCH_JUMP_0;
                                                                        
                    case(FUNC3)
                        3'b000: MEM_WRITE = `SB;
                        3'b001: MEM_WRITE = `SH;
                        3'b010: MEM_WRITE = `SW;
                    endcase
                end
            

            // R-Type Instructions
            7'b0110011:
                begin
                    IMM_SEL = `U_TYPE;
                    OP1_SEL = `DATA1;
                    OP2_SEL = `DATA2;
                    MEM_WRITE = `MEM_WRITE_0;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_1;
                    WB_SEL = `ALU_RESULT;
                    BRANCH_JUMP = `BRANCH_JUMP_0;
                    
                    case(FUNC3)
                        3'b000: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `ADD;
                                    7'b0100000: ALU_OPCODE = `SUB;
                                    7'b0000001: ALU_OPCODE = `MUL;
                                endcase
                            end
                        3'b001: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `SLL;
                                    7'b0000001: ALU_OPCODE = `MULH;
                                endcase
                            end
                        3'b010: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `SLT;
                                    7'b0000001: ALU_OPCODE = `MULHSU;
                                endcase
                            end
                        3'b011: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `SLTU;
                                    7'b0000001: ALU_OPCODE = `MULHU;
                                endcase
                            end
                        3'b100: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `XOR;
                                    7'b0000001: ALU_OPCODE = `DIV;
                                endcase
                            end
                        3'b101: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `SRL;
                                    7'b0100000: ALU_OPCODE = `SRA;
                                endcase
                            end
                        3'b110: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `OR;
                                    7'b0000001: ALU_OPCODE = `REM;
                                endcase
                            end
                        3'b111: 
                            begin
                                case(FUNC7)
                                    7'b0000000: ALU_OPCODE = `AND;
                                    7'b0000001: ALU_OPCODE = `REMU;
                                endcase
                            end
                    endcase
                end
            

            // U-Type Instructions
            7'b0110111:                                         // Instruction :- LUI
                begin
                    IMM_SEL = `U_TYPE;
                    MEM_WRITE = `MEM_WRITE_0;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_1;
                    WB_SEL = `IMM_VALUE;
                    BRANCH_JUMP = `BRANCH_JUMP_0;
                end

            7'b0010011:                                         // Instruction :- AUIPC
                begin
                    IMM_SEL = `U_TYPE;
                    OP1_SEL = `PC;
                    OP2_SEL = `IMM;
                    ALU_OPCODE = `ADD;
                    MEM_WRITE = `MEM_WRITE_0;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_1;
                    WB_SEL = `ALU_RESULT;
                    BRANCH_JUMP = `BRANCH_JUMP_0;  
                end
            

            // J-Type Instructions
            7'b1101111:                                         // Instruction - JAL
                begin
                    IMM_SEL = `J_TYPE;
                    OP1_SEL = `PC;
                    OP2_SEL = `IMM;
                    ALU_OPCODE = `ADD;
                    MEM_WRITE = `MEM_WRITE_0;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_1;
                    WB_SEL = `PC_VALUE;
                    BRANCH_JUMP = `JUMP;
                end
            

            // B-Type Instructions
            7'b1100011:
                begin
                    IMM_SEL = `B_TYPE;
                    OP1_SEL = `PC;
                    OP2_SEL = `IMM;
                    ALU_OPCODE = `ADD;
                    MEM_WRITE = `MEM_WRITE_0;
                    MEM_READ = `MEM_READ_0;
                    REG_WRITE_ENABLE = `REG_WRITE_ENABLE_0;
                    
                    case(FUNC3)
                        3'b000: BRANCH_JUMP = `BEQ;
                        3'b001: BRANCH_JUMP = `BNE;
                        3'b100: BRANCH_JUMP = `BLT;
                        3'b101: BRANCH_JUMP = `BGE;
                        3'b110: BRANCH_JUMP = `BLTU;
                        3'b111: BRANCH_JUMP = `BGEU;
                    endcase
                end
        endcase
    end

endmodule