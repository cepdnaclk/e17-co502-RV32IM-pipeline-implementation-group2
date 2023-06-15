/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Data Memory for the RV32IM pipeline implementation
==============================================================
*/

`include "definitions.v"

module data_memory(
        clock, reset, read, write, address, write_data, read_data, busywait
);

        // Declaration of variables
        input clock, reset, read, write;
        input [27:0] address;
        input [127:0] write_data;
        output reg [127:0] read_data;
        output reg busywait;

        reg [7:0] data_memory_array [255:0];            // Data memory array of size 256x8 bitss
        reg readaccess, writeaccess;

        // Check whether the data memory is being accessed
        always @(read, write)
        begin
                busywait = (read || write) ? 1 : 0;
                readaccess = (read && !write) ? 1 : 0;
                writeaccess = (!read && write) ? 1 : 0;
        end

        // Reading and writing data from the data memory
        always @(posedge clock)
        begin
                if (readaccess)
                begin
                        readdata[7:0]   = #4 data_memory_array[{address,4'b0000}];
                        readdata[15:8]  = #4 data_memory_array[{address,4'b0001}];
                        readdata[23:16] = #4 data_memory_array[{address,4'b0010}];
                        readdata[31:24] = #4 data_memory_array[{address,4'b0011}];

                        readdata[39:32] = #4 data_memory_array[{address,4'b0100}];
                        readdata[47:40] = #4 data_memory_array[{address,4'b0101}];
                        readdata[55:48] = #4 data_memory_array[{address,4'b0110}];
                        readdata[63:56] = #4 data_memory_array[{address,4'b0111}];

                        readdata[71:64] = #4 data_memory_array[{address,4'b1000}];
                        readdata[79:72] = #4 data_memory_array[{address,4'b1001}];
                        readdata[87:80] = #4 data_memory_array[{address,4'b1010}];
                        readdata[95:88] = #4 data_memory_array[{address,4'b1011}];

                        readdata[103:96]  = #4 data_memory_array[{address,4'b1100}];
                        readdata[111:104] = #4 data_memory_array[{address,4'b1101}];
                        readdata[119:112] = #4 data_memory_array[{address,4'b1110}];
                        readdata[127:120] = #4 data_memory_array[{address,4'b1111}];

                        busywait = 0;
                        readaccess = 0;
                end

                if(writeaccess)
                begin
                        data_memory_array[{address,4'b0000}] = #40 writedata[7:0];
                        data_memory_array[{address,4'b0001}] = #40 writedata[15:8];
                        data_memory_array[{address,4'b0010}] = #40 writedata[23:16];
                        data_memory_array[{address,4'b0011}] = #40 writedata[31:24];
                        
                        data_memory_array[{address,4'b0100}] = #40 writedata[39:32];
                        data_memory_array[{address,4'b0101}] = #40 writedata[47:40];
                        data_memory_array[{address,4'b0110}] = #40 writedata[55:48];
                        data_memory_array[{address,4'b0111}] = #40 writedata[63:56];

                        data_memory_array[{address,4'b1000}] = #40 writedata[71:64];
                        data_memory_array[{address,4'b1001}] = #40 writedata[79:72];
                        data_memory_array[{address,4'b1010}] = #40 writedata[87:80];
                        data_memory_array[{address,4'b1011}] = #40 writedata[95:88];

                        data_memory_array[{address,4'b1100}] = #40 writedata[103:96];
                        data_memory_array[{address,4'b1101}] = #40 writedata[111:104];
                        data_memory_array[{address,4'b1110}] = #40 writedata[119:112];
                        data_memory_array[{address,4'b1111}] = #40 writedata[127:120];

                        busywait = 0;
                        writeaccess = 0;
                end
        end

        // Reset memory
        integer i;

        always @(posedge reset)
        begin
                if (reset)
                begin
                        for (i=0; i<256; i++) data_memory_array[i] = 0;

                        busywait = 0;
                        readaccess = 0;
                        writeaccess = 0;
                end
        end

endmodule