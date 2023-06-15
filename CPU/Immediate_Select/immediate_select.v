`timescale 1ns/100ps

module immediate_select(INSTRUCTION, SELECT, OUTPUT);
    input       [31:0]  INSTRUCTION;
    input       [3:0]   SELECT;
    output reg  [31:0]  OUTPUT;

    wire    [19:0]  TYPE_1, TYPE_2;
    wire    [11:0]  TYPE_3, TYPE_4, TYPE_5;
    wire    [4:0]   TYPE_6;

    //checking for the combinations
    assign  TYPE_1= INSTRUCTION[31:12];
    assign  TYPE_2= INSTRUCTION[31:12];
    assign  TYPE_3= INSTRUCTION[31:20];
    assign  TYPE_4= {INSTRUCTION[31:25],INSTRUCTION[11:7]};
    assign  TYPE_5= {INSTRUCTION[31:25],INSTRUCTION[11:7]};
    assign  TYPE_6= INSTRUCTION[29:25];

    //by considering the different cases using the SELECT signal 
    always @(*) begin
        case(SELECT[2:0])
            //U - Immediate
            3'b000: 
                OUTPUT = {TYPE_1, {12{1'b0}}};

            //J - Immediate
            3'b001:
                OUTPUT =    (SELECT[3]==1'b1) ? {{11{1'b0}}, TYPE_2, 1'b0} :   //unsigned
                                                {{12{INSTRUCTION[31]}}, INSTRUCTION[19:12], INSTRUCTION[20], INSTRUCTION[30:21], 1'b0}; //signed

            //S - Immediate
            3'b010:
                OUTPUT =    (SELECT[3]==1'b1) ? {{20{1'b0}}, TYPE_3} : //unsigned
                                                {{20{TYPE_3[11]}}, TYPE_3}; //signed

            //B - Immediate
            3'b011:
                OUTPUT =    (SELECT[3]==1'b1) ?  {{20{1'b0}},               INSTRUCTION[31], INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0} : //unsigned
                                                 {{20{INSTRUCTION[31]}},    INSTRUCTION[31], INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0};  //signed

            //I - Immediate
            3'b100:
                OUTPUT =    (SELECT[3]==1'b1) ? {{20{1'b0}}, TYPE_5} : //unsigned
                                                {{20{TYPE_5[11]}}, TYPE_5}; //signed

            //I_Shift
            3'b101:
                OUTPUT = {{27{1'b0}}, TYPE_6};

        endcase
    end

endmodule

            
