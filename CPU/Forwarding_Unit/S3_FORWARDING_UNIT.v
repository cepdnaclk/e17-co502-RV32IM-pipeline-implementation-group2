module S3_FORWARD_UNIT(ADDR_1, ADDR_2, STAGE3_ADDR, STAGE4_ADDR, STAGE5_ADDR, OP1MUX_OUT, OP2MUX_OUT,STAGE3_REGWRITE_EN, STAGE4_REGWRITE_EN, STAGE5_REGWRITE_EN);

input       [4:0]   ADDR_1,ADDR_2;

output reg  [1:0]   OP1MUX_OUT, OP2MUX_OUT;

input       [4:0]   STAGE3_ADDR, STAGE4_ADDR, STAGE5_ADDR;
input               STAGE3_REGWRITE_EN, STAGE4_REGWRITE_EN, STAGE5_REGWRITE_EN;

always @ (*)
begin
    //for operand 1
    STAGE3_REGWRITE_EN == 1'b1 && STAGE3_ADDR == ADDR_1 ?
    begin
        OP1MUX_OUT=2'b01;
    end :
    STAGE4_REGWRITE_EN == 1'b1 && STAGE4_ADDR == ADDR_1 ?
    begin
        OP1MUX_OUT=2'b10;
    end :
    STAGE5_REGWRITE_EN == 1'b1 && STAGE5_ADDR == ADDR_1 ?
    begin
        OP1MUX_OUT=2'b11;
    end :
    begin
        OP1MUX_OUT=2'b00;
    end

    //--------------------------------------------------
    //for operand 2

    STAGE3_REGWRITE_EN == 1'b1 && STAGE3_ADDR == ADDR_2 ?
    begin
        OP2MUX_OUT=2'b01;
    end :
    STAGE4_REGWRITE_EN == 1'b1 && STAGE4_ADDR == ADDR_2 ?
    begin
        OP2MUX_OUT=2'b10;
    end :
    STAGE5_REGWRITE_EN == 1'b1 && STAGE5_ADDR == ADDR_2 ?
    begin
        OP2MUX_OUT=2'b11;
    end :
    begin
        OP2MUX_OUT=2'b00;
    end

end

endmodule

