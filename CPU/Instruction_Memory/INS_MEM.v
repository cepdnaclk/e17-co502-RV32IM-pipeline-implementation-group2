/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Instruction Memory for the RV32IM pipeline implementation
==============================================================
*/

`include "definitions.v"


module INS_MEM(READ,ADDRESS,INSTRUCTION_OUT, BUSYWAIT, CLOCK);

    input               READ,CLOCK;
    input       [27:0]  ADDRESS;
    output reg  [127:0] INSTRUCTION_OUT;
    output reg          BUSYWAIT;

    //reg READ_ACCESS;

    //decalring of a memory array of 1024x8-bits
    reg [7:0] MEM_ARRAY [1023:0];

    initial
    begin
        BUSYWAIT=1'b0;
        //READ_ACCESS=1'b0;
    end

    //detecting incoming memory access
    always @(READ)
    begin
        BUSYWAIT    = (READ) ? 1:0;
        //READ_ACCESS = (READ) ? 1:0; 
    end

    // Hard coded instructions
    initial
    begin
        
    end

    always @(posedge CLK)
    begin
        if(READ)
        begin
            INSTRUCTION_OUT[7:0]       = #40 MEM_ARRAY[{ADDRESS,4'b0000}];
            INSTRUCTION_OUT[15:8]      = #40 MEM_ARRAY[{ADDRESS,4'b0001}];
            INSTRUCTION_OUT[23:16]     = #40 MEM_ARRAY[{ADDRESS,4'b0010}];
            INSTRUCTION_OUT[31:24]     = #40 MEM_ARRAY[{ADDRESS,4'b0011}];
            INSTRUCTION_OUT[39:32]     = #40 MEM_ARRAY[{ADDRESS,4'b0100}];
            INSTRUCTION_OUT[47:40]     = #40 MEM_ARRAY[{ADDRESS,4'b0101}];
            INSTRUCTION_OUT[55:48]     = #40 MEM_ARRAY[{ADDRESS,4'b0110}];
            INSTRUCTION_OUT[63:56]     = #40 MEM_ARRAY[{ADDRESS,4'b0111}];
            INSTRUCTION_OUT[71:64]     = #40 MEM_ARRAY[{ADDRESS,4'b1000}];
            INSTRUCTION_OUT[79:72]     = #40 MEM_ARRAY[{ADDRESS,4'b1001}];
            INSTRUCTION_OUT[87:80]     = #40 MEM_ARRAY[{ADDRESS,4'b1010}];
            INSTRUCTION_OUT[95:88]     = #40 MEM_ARRAY[{ADDRESS,4'b1011}];
            INSTRUCTION_OUT[103:96]    = #40 MEM_ARRAY[{ADDRESS,4'b1100}];
            INSTRUCTION_OUT[111:104]   = #40 MEM_ARRAY[{ADDRESS,4'b1101}];
            INSTRUCTION_OUT[119:112]   = #40 MEM_ARRAY[{ADDRESS,4'b1110}];
            INSTRUCTION_OUT[127:120]   = #40 MEM_ARRAY[{ADDRESS,4'b1111}];
            BUSYWAIT    = 0;
            //READ_ACCESS = 0; 
        end
    end

endmodule