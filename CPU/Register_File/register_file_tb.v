 /*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Testbench for the Register File for the RV32IM pipeline implementation
==============================================================
 */

`include "register_file.v"

module

    reg CLK, RESET, WRTIE_ENABLE;
    reg [4:0] DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS;
    reg [31:0] WRITE_DATA;
    wire [31:0] DATA1, DATA2;

    reg_file my_reg_file(DATA1, DATA2, WRITE_DATA, DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS, WRITE_ENABLE, CLK, RESET);

    initial begin
        $dumpfile("reg_file_wavedata.vcd");
        $dumpvars(0, reg_file_tb);
    end

    initial begin
        CLK = 1'b0;
        RESET = 1'b0;
        WRITE_ENABLE = 1'b0;
        WRITE_DATA = 32'd0;
        DATA1_ADDRESS = 5'b0;
        DATA2_ADDRESS = 5'b0;
        WRITE_ADDRESS = 5'b0;
        
        #5 RESET = 1'b1;
        #5 RESET = 1'b0;

        WRITE_ADDRESS = 5'd1;
        WRITE_DATA = 32'd5;
        WRITE_ENABLE = 1'd1;

        @(posedge CLK) begin
            #3;
            DATA1_ADDRESS = 5'b1;
            #3;
            `assert(DATA1,32'd5);
            $display("Test 1 passed");
        end

        WRITE_ADDRESS = 5'd0;
        WRITE_DATA = 32'd10;
        WRITE_ENABLE = 1'b1;

        @(posedge CLK) begin
            #3;
            DATA1_ADDRESS = 5'd0;
            #3
            `assert(DATA1, 32'd0);
            $display("Test 2 passed");
        end

        #50
        $finish

    end

    always begin
        #4 CLK = ~CLK;
    end

endmodule