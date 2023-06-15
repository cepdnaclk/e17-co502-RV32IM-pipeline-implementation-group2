`include "IMMEDIATE_SELECT.v"

module immediate_select_tb;

    reg             CLK, RESET;
    reg    [31:0]   INSTRUCTION;
    reg    [3:0]    SELECT;
    wire   [31:0]   OUTPUT;

    IMMEDIATE_SELECT IMM_SEL(INSTRUCTION, SELECT, OUTPUT);
    
    integer         n;
    reg     [31:0]  TEMP;
    
    
    initial begin
        
        // U-Type Instruction
        INSTRUCTION =  $random;
        SELECT = 4'b0000;
        TEMP = INSTRUCTION[31:12];
        #2
        $display ("U-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);
    
        // J-Type Instruction
        INSTRUCTION =  $random;
        SELECT = 4'b0001;
        TEMP = INSTRUCTION[31:12];
        #2
        $display ("J-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);

        INSTRUCTION =  $random;
        SELECT = 4'b1001;
        TEMP = INSTRUCTION[31:12];
        #2
        $display ("J-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);

        // S-Type Instruction
        INSTRUCTION =  $random;
        SELECT = 4'b0010;
        TEMP = INSTRUCTION[31:20];
        #2
        $display ("S-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);

        INSTRUCTION =  $random;
        SELECT = 4'b1010;
        TEMP = INSTRUCTION[31:20];
        #2
        $display ("S-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);

        // B-Type Instruction
        INSTRUCTION =  $random;
        SELECT = 4'b0011;
        TEMP = {INSTRUCTION[31:25], INSTRUCTION[11:7]};
        #2
        $display ("B-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);

        INSTRUCTION =  $random;
        SELECT = 4'b1011;
        TEMP = {INSTRUCTION[31:25], INSTRUCTION[11:7]};
        #2
        $display ("B-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);
        
         // I-Type Instruction
        INSTRUCTION =  $random;
        SELECT = 4'b0100;
        TEMP = {INSTRUCTION[31:25], INSTRUCTION[11:7]};
        #2
        $display ("I-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);

        INSTRUCTION =  $random;
        SELECT = 4'b1100;
        TEMP = {INSTRUCTION[31:25], INSTRUCTION[11:7]};
        #2
        $display ("I-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);
       
         // I-shift Instruction
        INSTRUCTION =  $random;
        SELECT = 4'b0101;
        TEMP = INSTRUCTION[29:25]; 
        #2
        $display ("I-TYPE --> Input: 0x%b | Output: 0x%b ", TEMP, OUTPUT);
        
        #20
        $finish;
    end

    // clock genaration.
    always begin
        #10 CLK = ~CLK;
    end

endmodule