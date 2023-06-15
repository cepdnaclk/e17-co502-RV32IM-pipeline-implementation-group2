/*
==============================================================
        CO 502 - Advanced Computer Architecture
        E/17/388 - W.A.L.M. Weragoda,  E/17/035 - K.T.M. Chamika
        Group 2
        Data Cache for the RV32IM pipeline implementation
==============================================================
*/

`include "definitions.v"

// DATA CAHCE
module data_cache(
    clock, reset, read, write, read_data, write_data, address, busywait,
    mem_read, mem_write, mem_read_data, mem_write_data, mem_address, mem_busywait
);

    // Declaration of variables
    input clock, reset, mem_busywait;
    input [2:0] read;
    input [1:0] write;
    input [31:0] write_data, address;
    input [127:0] mem_readdata; 

    output reg busywait, mem_read, mem_write;
    output reg [31:0] read_data;
    output reg [27:0] mem_address;
    output reg  [127:0] mem_write_data;

    reg [24:0] tag, stored_tag;
    reg [2:0] index;
    reg [1:0] offset, byte_offset;
    reg [31:0] data_block;                      // Temporary variable to hold data from the cache
    reg [1:0] valid_bit, dirty_bit;
    reg [127:0] data_arr [7:0];                 // Data cache memory array : 128x8 bits
    reg [24:0] tag_arr [7:0];                   // Tag array : 25x8 bits
    reg [1:0] dirty_bit_arr [7:0];               // Dirty Bit array : 2x8 bits
    reg [1:0] valid_bit_arr [7:0];               // Valid Bit array : 2x8 bits
    reg tag_out, hit;


    reg read_access, write_access;              // Signals to detect whether a read from or write to the cahce occurs
    reg [31:0] temp_read_data, temp_write_data; // Register to store the read and write data from the cache temporarily
    reg [1:0] state, next_state;
    parameter IDLE = 2'b00, MEM_READ = 2'b01, MEM_WRITE = 2'b10;
    reg tag_out, hit;

    integer i;

    /*---------------------------------------
        DATA CACHE
    -----------------------------------------*/

    // Checking whether the signal is a read or write and asserting the busywait signal 				
    always @(read,write) begin
        busywait = (read_access || write_access) ? 1 : 0;
    end

    // Splitting the address sent to the cache
    always @(address) begin
        tag = address[31:7];
        index = address[6:4];
        offset = address[3:2];
        byte_offset = address[1:0];
    end

    // Extracting the data block, tag, valid bit and drity bit
	always @(*) begin
		#1
		data_block = data_arr[index];
        stored_tag = tag_arr[index];
        valid_bit = valid_bit_arr[index];
        dirty_bit = dirty_bit_arr[index];
	end

    // Generating the hit signal
	always @(tag,stored_tag,valid_bit) begin
		#0.9 tag_out = (tag == stored_tag) ? 1 : 0;
		hit = tag_out && valid_bit;
	end

    // Detecting a read from or write to the memory
    always @(read, write)
    begin
        if ((read == 3'bx && write = 2'bx) || (read == MEM_READ_0 && write == MEM_WRITE_0)) 
            busywait = 1'b0;
        else   
        begin
            busywait = 1'b1;
            read_access = ((read != MEM_READ_0) && (write == MEM_WRITE_0)) ? 1 : 0;
            write_access = ((read == MEM_READ_0) && (write != MEM_WRITE_0)) ? 1 : 0;
        end
    end

    /* ---------------------------------------------------------------------------
            READ DATA FROM THE CACHE
    ---------------------------------------------------------------------------- */

    // Selecting the relavant 32 bit data blcok from the cache in a read access
    always @(*) 
    begin
        if (read_access)
        #1
        begin
            case (offset)
                2'b00: temp_read_data = data_array[index][31:0];   
                2'b01: temp_read_data = data_array[index][63:32];   
                2'b10: temp_read_data = data_array[index][95:64];   
                2'b11: temp_read_data = data_array[index][127:96];   
            endcase
        end
    end

    // Reading the specific data block from the data block
	always @(*) 
    begin
		case (read)
            `LB:
			case (byte_offset)
				2'b00:  read_data = {{24{temp_read_data[7]}}, temp_read_data[7:0]};
				2'b01:  read_data = {{24{temp_read_data[15]}}, temp_read_data[15:8]};
                2'b10:  read_data = {{24{temp_read_data[23]}}, temp_read_data[23:16]};
                2'b11:  read_data = {{24{temp_read_data[31]}}, temp_read_data[31:24]};
			endcase

            `LH:
            case (byte_offset)
                2'b00:  read_data = {{16{temp_read_data[15]}}, temp_read_data[15:0]}; 
                2'b10:  read_data = {{16{temp_read_data[31]}}, temp_read_data[31:16]}; 
            endcase
            
            `LW:
                read_data = temp_read_data;

            `LBU:
            case (byte_offset)
                2'b00:  read_data = {24'b0, temp_read_data[7:0]};
				2'b01:  read_data = {24'b0, temp_read_data[15:8]};
                2'b10:  read_data = {24'b0, temp_read_data[23:16]};
                2'b11:  read_data = {24'b0, temp_read_data[31:24]};
            endcase

            `LHU:
            case (byte_offset)
                2'b00:  read_data = {16'b0, temp_read_data[15:0]};
                2'b10:  read_data = {16'b0, temp_read_data[31:16]}; 
            endcase
        endcase
	end

    /* ---------------------------------------------------------------------------
            CACHE CONTROLLER FSM
    ---------------------------------------------------------------------------- */

    // Selecting the next state using combinational logic
    always @(*)
    begin
        case (state)
            IDLE:
                if ((read_access || write_access) && !dirty_bit && !hit)    next_state = MEM_READ;
                else if ((read_access || write_access) && dirty_bit && !hit)    next_state = MEM_WRITE;
                else next_state = IDLE;

            MEM_READ:
				if (!mem_busywait)
					next_state = IDLE;
				else 
					next_state = MEM_READ;

			MEM_WRITE:
				if (!mem_busywait)
					next_state = MEM_READ;
				else 
					next_state = MEM_WRITE; 
        endcase
    end    

    // Combinational logic outputs for the states
    always @(state)
    begin
        case (state)
            IDLE:
			begin
				mem_read = 0;
				mem_write = 0;
				mem_address = 28'dx;
				mem_writedata = 128'dx;
			end

			MEM_READ:
			begin
				mem_read = 1;
				mem_write = 0;
				mem_address = {tag,index};
				mem_writedata = 128'dx;
			end
			
            MEM_WRITE:
			begin
				mem_read = 0;
				mem_write = 1;
				mem_address = {tag,index};
				mem_writedata = data_block;
			end 
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clock, reset)
    begin
        if (reset) state = IDLE;
        else state = next_state;
    end



    /* ---------------------------------------------------------------------------
            WRITE DATA TO THE CACHE
    ---------------------------------------------------------------------------- */

    // Writing the data obtained from the data memory to the cache
    always @(negedge mem_busywait)
    begin   
        if (state == MEM_READ)
        begin
            #1
            data_arr[index] = mem_read_data;
            tag_arr[index] = tag;
            valid_bit_arr[index] = 1'b1;
            dirty_bit_arr[index] = 1'b0;
        end
    end


    // Store the write data according to the byte offset in a temporary register
    always @(*)
    begin
        case (write)
            `SB:
            case (byte_offset)
                2'b00: temp_write_data = {{24{1'b1}},write_data[7:0]};
                2'b01: temp_write_data = {{16{1'b1}},write_data[7:0],8{1'b1}};
                2'b10: temp_write_data = {{8{1'b1}},write_data[7:0],{16{1'b1}}};
                2'b11: temp_write_data = {write_data[7:0],{24{1'b1}}};
            endcase
            
            `SH:
            case (byte_offset)
                2'b00: temp_write_data = {{16{1'b1}},write_data[15:0]};
                2'b10: temp_write_data = {write_data[15:0],{16{1'b1}}};
            endcase

            `SW:
                temp_write_data = write_data;
        endcase
    end
    
    // Writing data to the cache and controlling the busywaiit signal on a hit 
    always @(*)
    begin
        if (read_access && hit) busywait = 1'b0;
        else if(write_access && hit)
        begin
            busywait = 1'b0;
            dirty_bit_arr[index] = 1'b1;
            #1 case (offset)
                2'b00: data_arr[index][31:0] = temp_write_data;
                2'b01: data_arr[index][63:32] = temp_write_data;
                2'b10: data_arr[index][95:64] = temp_write_data;
                2'b11: data_arr[index][127:96] = temp_write_data;
            endcase
        end 
    end

    // Resetting the cache at the positive edge of the reset signal

    integer i;

    always @(posedge reset)
    begin
        for (i = 0; i < 16; i++)
        begin
            data_arr[i] = 128'b0;
            valid_bit_arr[i] = 0;
            dirty_bit_arr[i] = 0;
            tag_arr[i] = 25'b0;
        end
    end

endmodule
