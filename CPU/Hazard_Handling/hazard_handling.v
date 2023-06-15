/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Hazard Handling for the RV32IM pipeline implementation
==============================================================
*/


/*--------------------------------
    FORWARDING UNIT 1
----------------------------------*/
module forwarding_unit_1(REG_W_EN_S3, ADDR_S3, REG_W_EN_S4, ADDR_S4, REG_W_EN_S5, ADDR_S5, OP1_SEL, OP2_SEL, REG_ADDR1, REG_ADDR2)
    input [4:0] ADDR_S3, ADDR_S4, ADDR_S5, REG_ADDR1, REG_ADDR2;
    input REG_W_EN_S3, REG_W_EN_S4, REG_W_EN_S5;
    output reg [1:0] OP1_SEL, OP2_SEL;

    always(*)
    begin
        // To select the operand 1 value
        if (REG_W_EN_S3 && (ADDR_S3 == REG_ADDR1))
            OP1_SEL = 2'b01;
        else if (REG_W_EN_S4 && (ADDR_S4 == REG_ADDR1))
            OP1_SEL = 2'b10;
        else if (REG_W_EN_S5 && (ADDR_S5 == REG_ADDR1))
            OP1_SEL = 2'b11;
        else
            OP1_SEL = 2'b00;

        // To select the operand 2 value
        if (REG_W_EN_S3 && (ADDR_S3 == REG_ADDR2))
            OP2_SEL = 2'b01;
        else if (REG_W_EN_S4 && (ADDR_S4 == REG_ADDR2))
            OP2_SEL = 2'b10;
        else if (REG_W_EN_S5 && (ADDR_S5 == REG_ADDR2))
            OP2_SEL = 2'b11;
        else
            OP2_SEL = 2'b00;
    end


endmodule


/*----------------------------------------------------------
    FORWARDING UNIT 2 :- Forwarding unit for the stage 4
------------------------------------------------------------*/
module forwarding_unit_2(MEM_WRITE_S3, REG_R_ADDR_S3, MEM_READ_S4, REG_W_ADDR_S4, MEM_ADDR_SEL)
    input [4:0] REG_W_ADDR_S4, REG_R_ADDR_S3;
    input MEM_READ_S4, MEM_WRITE_S3;
    output reg MEM_ADDR_SEL;

    always(*)
    begin
        if (MEM_READ_S4 && MEM_WRITE_S3)
            begin
                if (REG_W_ADDR_S4 == REG_R_ADDR_S3)
                    MEM_ADDR_SEL = 1'b1;
                else   
                    MEM_ADDR_SEL = 1'b0;
            end
        else
            MEM_ADDR_SEL = 1'b0;
    end

endmodule


/*----------------------------------------------------------------
    FLUSHING UNIT TO FLUSH THE FIRST 2 REGISTERS IN A BRANCH/JUMP 
------------------------------------------------------------------*/
module flushing_unit(BJ_SIG, P_REG1, P_REG2)

    input BJ_SIG;
    output P_REG1, P_REG2;

    always(*)
    begin
        if (BJ_SIG)
        begin
            P_REG1 = 1'b1;
            P_REG2 = 1'b1;
        end
        else
        begin
            P_REG1 = 1'b0;
            P_REG2 = 1'b0;
        end
    end
    
endmodule
