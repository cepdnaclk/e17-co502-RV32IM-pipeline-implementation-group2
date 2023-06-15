/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Instruction Cache for the RV32IM pipeline implementation
==============================================================
*/

`include "definitions.v"

module instruction_cache(ADDRESS, INSTRUCTION, BUSYWAIT, INS_MEM_READ, INS_MEM_ADDRESS, INS_MEM_INSTRUCTION, INS_MEM_BUSYWAIT, CLK, RESET);

    input               READ, CLK, RESET;
    input       [31:0]  ADDRESS;
    output reg  [31:0]  INSTRUCTION;
    output reg          BUSYWAIT;

    input       [127:0] INS_MEM_INSTRUCTION;
    input               INS_MEM_BUSYWAIT;
    output              INS_MEM_READ;
    output      [27:0]  INS_MEM_ADDRESS;


    reg [127:0] INSTRUCTION_array [7:0];        //declare a memory array for cache with size 128 x 8-bits
    reg [24:0]  TAG_array       [7:0];          //declare a tag array with size 25x8bits
    reg [1:0]   ValidBit_array  [7:0];          //declare a valid bit array of size 2x8-bits

    parameter   IDLE=1'b0, MEM_READ=1'b1;
    reg [1:0]   STATE,NEXT_STATE;

    //to handle state changes we declare variables
    reg         CURRENT_VALID;
    reg [24:0]  CURRENT_TAG;
    reg [31:0]  CURRENT_INSTRUCTION;
    wire        TAG_MATCH;

    reg [31:0]  TEMP_INSTRUCTION;               //To hold the INSTRUCTION from cache temporarly

    //To hold the values of memory module
    reg         INS_MEM_READ;
    reg [27:0]  INS_MEM_ADDRESS;
    wire[127:0] MAIN_MEM_READ_INSTRUCTION;
    wire        INS_MEM_BUSYWAIT;

    reg         READ_CACHE;                     //reg to store the READ to cache signal until positive clock edge occurs 
    reg         WRITE_CACHE;                    //reg to store the WRITE to cache signal until positive clock edge occurs 
    
    reg         WRITE_CACHE_MEM;                //To store wite enable  signal to write intoo the cache mem after a memory read occurs

    //To pass the decoded the address
    wire[24:0]  TAG;
    wire[2:0]   INDEX;
    wire[1:0]   OFFSET;

    //Decoding the address
    assign  TAG     = ADDRESS[31:7];
    assign  INDEX   = ADDRESS[6:4];
    assign  OFFSET  = ADDRESS[3:2];

    //Getting the INSTRUCTION loaded
    always @(*)
    begin
        CURRENT_VALID   = ValidBit_array[INDEX];
        CURRENT_TAG     = TAG_array[INDEX];
        CURRENT_INSTRUCTION    = INSTRUCTION_array[INDEX];
    end

    assign  #0.9 TAG_MATCH = (TAG == CURRENT_TAG); //matching the lower 3 bits of TAG with 3 bits of CURRENT_TAG

    reg [127:0] TEMP;

    //-------------------------------------------------------------------------------------------------------
    //Detecting incoming memeory access and Enabling READ_ACCESS and BUSYWAIT signals ON
    /*reg READ_ACCESS;
    always @(READ)  
    begin
        if(READ)
            begin
                BUSYWAIT=1'b1;
                READ_ACCESS=1'b1;
            end
    end*/
    // Set busywait when the PC value is sent to the cache memory
    always @(ADDRESS)
    begin
        if(ADDRESS != -32'b4) BUSYWAIT = 1;
    end

    //-------------------------------------------------------------------------------------------------------
    //Loading INSTRUCTION into output if the READ_ACCESS is ON
    always @(*)
    begin
        if(READ_ACCESS)
        #1
        begin
            TEMP=INSTRUCTION_array[INDEX];
            case(OFFSET)
                2'b00:  INSTRUCTION=INSTRUCTION_array[INDEX][31:0];
                2'b01:  INSTRUCTION=INSTRUCTION_array[INDEX][63:32];
                2'b10:  INSTRUCTION=INSTRUCTION_array[INDEX][95:64];
                2'b11:  INSTRUCTION=INSTRUCTION_array[INDEX][127:96];
            endcase
        end
    end

    //-------------------------------------------------------------------------------------------------------
    //Combinational NEXT_STATE logic
    always @(*)
    begin
        case(STATE)
            IDLE:
                NEXT_STATE = (!CURRENT_VALID && READ_ACCESS) ? MEM_READ:
                             (CURRENT_VALID && TAG_MATCH && READ_ACCESS) ? IDLE :
                             (CURRENT_VALID && !TAG_MATCH && READ_ACCESS) ? MEM_READ;
            
            MEM_READ:
                NEXT_STATE = (INS_MEM_BUSYWAIT) ? MEM_READ : IDLE;

        endcase
    end

    //-------------------------------------------------------------------------------------------------------
    //Output Logic
    always @(*)
    begin
        if(READ_ACCESS)
        begin
            case(STATE)
                IDLE:
                begin
                    INS_MEM_READ=1'b0; //Disable the main memory read and write signal

                    if(READ_ACCESS && TAG_MATCH && CURRENT_VALID)
                        begin
                            READ_CACHE=1'b1; //Enable the READ_CACHE
                        end
                    else READ_CACHE=1'b0;   //Disable the READ_CACHE
                end

                MEM_READ:
                begin
                    INS_MEM_READ=1'b1;
                    INS_MEM_ADDRESS={TAG,INDEX} //Setting the address to the main memory
                    
                    WRITE_CACHE_MEM= (!INS_MEM_BUSYWAIT) ? 1'b1 : 1'b0; //Enabling write into cache if BUSYWAIT is not HIGH
                end
            endcase
        end
    end

    //-------------------------------------------------------------------------------------------------------
    //Sequential logic for state transitioning
    always @(posedge RESET)
    begin
        if(RESET)
        begin
            busywait=1'b0;
            for (i=0;i<8;i++)
                begin
                    INSTRUCTION_array[i]=0;
                    ValidBit_array[i]=0;
                end
        end
    end

    //-------------------------------------------------------------------------------------------------------
    //State change logic

    always @(posedge CLK)
    begin
        if(!RESET)
            STATE=NEXT_STATE;
        else
            begin
                STATE=IDLE;
                NEXT_STATE=IDLE;
            end
    end

    //-------------------------------------------------------------------------------------------------------
    //Writing to cache after a memory read

    always @(posedge CLK)
    begin
        if(WRITE_CACHE_MEM)
        begin
            #1
            //Add the read INSTRUCTION into the cache
            INSTRUCTION_array[INDEX]       = INS_MEM_INSTRUCTION;
            TAG_array[INDEX]        = TAG;
            ValidBit_array[INDEX]   = 1'b1;
            WRITE_CACHE_MEM         = 1'b0;
        end
    end

    //-------------------------------------------------------------------------------------------------------
    //Deassert and write back on postivie clock edge

    always @ (posedge CLK)
    begin
        if(READ_CACHE)
        begin
            BUSYWAIT    = 1'b0;
            READ_CACHE  = 1'b0;
            READ_ACCESS = 1'b0;
        end
    end

endmodule