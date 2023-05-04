 /*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Register File for the RV32IM pipeline implementation
==============================================================
 */

 
module reg_file(DATA1, DATA2, WRITE_DATA, DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS, WRITE_ENABLE, CLK, RESET);

    reg [31:0] REGISTER[0:31];                                      // An 8x8 byte register array

    input WRITE_ENABLE, CLK, RESET;                                 // Decleration of ports
    input [31:0] WRITE_DATA;
    input [4:0] DATA1_ADDRESS, DATA2_ADDRESS, WRITE_ADDRESS;
    output [31:0] DATA1, DATA2;

    integer count;                                                  // An integer variable to count the registers

    //Reset the registers
    always @ (*) begin
        if (RESET) begin  
            #2 for (count = 0; count < 32; count = count + 1)
                REGISTER[count] = 32'd0;
        end
    end

    //Writing values to a register
    always @ (posedge CLK) begin
        #1
        if (WRITE_ENABLE & !RESET & WRITE_ADDRESS != 0) begin
            REGISTER[WRITE_ADDRESS] = WRITE_DATA;
        end
    end

    // Reading values from a register
    assign #2 DATA1 = REGISTER[DATA1_ADDRESS];                      
    assign #2 DATA2 = REGISTER[DATA2_ADDRESS];

endmodule