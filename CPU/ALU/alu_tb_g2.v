/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Testbench for the ALU unit for the RV32IM pipeline implementation
==============================================================
*/


`include "alu_g2.v"
`include "definitions.v"

`define assert(sig, val) \
    if (sig !== val) begin \
        $display("ASSERTION FAILED in %m: sig != %d [original value %d]", val, sig); \
        $finish; \
    end

/*
function print_results([4:0]opcode, [31:0]test_result, [31:0]actual_result);
    begin
        if (test_result != actual_result)
        begin
            $display("ASSERTION FAILED in %m: sig != %d [original value %d]", test_result, actual_result);
            $finish;
        end
    end
endfunction
*/
module alu_tb;

    reg CLK, RESET;
    reg [31:0] DATA1, DATA2;
    reg [4:0] ALU_OPCODE;
    wire [31:0] ALU_RESULT;

    alu myalu(DATA1, DATA2, ALU_RESULT, ALU_OPCODE);
    /*
    intital 
    begin
        $dumpfile("alu_wavedata.vcd");
        $dumpvars(0, alu_tb);
    end
    */
    // The test cases to test the alu operations

    initial
    begin
        /*===========================================
            TEST 01
            ADDITION OPERATION
            DATA1 = 20, DATA2 = 10, ALU_OCODE = ADD 
            ALU_RESULT = 30
        =============================================*/
        ALU_OPCODE = `ADD;
        DATA1 = 32'd20;
        DATA2 = 32'd10;
        #3 
        `assert(ALU_RESULT, 32'd30);
        $display ("Test 01\n ALU operation : ADD.\t Status : Passed\n");

        /*===========================================
            TEST 02
            SUBTRACTION OPERATION
            DATA1 = 20, DATA2 = 10, ALU_OCODE = SUB
            ALU_RESULT = 10
        =============================================*/
        ALU_OPCODE = `SUB;
        DATA1 = 32'd20;
        DATA2 = 32'd10;
        #3 
        `assert(ALU_RESULT, 32'd100);
        $display ("Test 01\n ALU operation : SUB.\t Status : Passed\n");

        $finish;
    end

endmodule

