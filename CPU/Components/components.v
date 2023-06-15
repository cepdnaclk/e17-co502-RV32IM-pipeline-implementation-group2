/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        File containing all components for the RV32IM pipeline implementation
==============================================================
*/


/*------------------------------------------
    2 X 1 MUX
-------------------------------------------*/
module mux_2x1(OUT, I1, I2, SEL)
    //port declaration
    output reg [31:0] OUT;
    input [31:0] I1,I2;
    input SEL;

    always(*)
    begin
        case (SEL)
            1'b0: OUT = I1;
            1'b1: OUT = I2;
        endcase
    end

endmodule


/*------------------------------------------
    4 X 1 MUX
-------------------------------------------*/
module mux_4x1(OUT,I1,I2,I3,I4,SEL)
    //port declaration
    output reg [31:0] OUT;
    input [31:0] I1,I2,I3,I4;
    input [1:0] SEL;

    always(*)
    begin
        case (SEL)
            2'b00: OUT = I1;
            2'b01: OUT = I2;
            2'b10: OUT = I3;
            2'b11: OUT = I4;
        endcase
    end
    

endmodule


/*------------------------------------------------------------
    Program Counter
--------------------------------------------------------------*/
module program_counter (CLOCK, RESET, BUSYWAIT, IN, OUT)
    input CLOCK, RESET, BUSYWAIT;
    input [31:0] IN;
    output reg [31:0] OUT;

    always @(RESET)
    begin
        if (RESET) #1 OUT = -32'd4;
    end

    always @(posedge CLOCK)
    begin
        #1 if (!RESET & !BUSYWAIT) OUT = IN;
    end
endmodule

/*------------------------------------------------------------
    Module to update and increment the Program Counter
--------------------------------------------------------------*/
module adder_4bit(IN, OUT)
    input [31:0] IN;
    output [31:0] OUT;

    assign #1 OUT = IN + 32'd4;

endmodule
