module cache_top	#(	
					parameter DATA_WIDTH = 32,
					//parameter TAG_WIDTH = 10,
					//parameter INDEX_WIDTH = 9,
					parameter ADDRESS_WIDTH = 22,
					parameter BLOCK_OFFSET_WIDTH = 2,
					parameter ASSOCIATIVITY = 1, // for n-way associative caching
					// TODO adjust index_width to consider associativity
					parameter INDEX_WIDTH = 9,  // number of sets in bits (size of cache)  9= 8kb(512*16),10 = 16kb, 11 = 32kb, 12 = 64kb.
					parameter TAG_WIDTH = 21 - INDEX_WIDTH - BLOCK_OFFSET_WIDTH,
					parameter MEM_MASK_WIDTH = 3 // What's this for?
				)
				(	// Inputs
					input i_Clk,
					input i_Reset_n,
					input i_Valid,
					input [MEM_MASK_WIDTH-1:0] i_Mem_Mask,
					input [(TAG_WIDTH+INDEX_WIDTH+BLOCK_OFFSET_WIDTH)-1:0] i_Address,	// 32-bit aligned address
					input i_Read_Write_n,
					input [DATA_WIDTH-1:0] i_Write_Data,

					// Outputs
					output o_Ready_1,
					output o_Ready_2,
					output /*reg*/ o_Valid_1, //LD: Don't use registered outputs in the miter
					output /*reg*/ o_Valid_2,			// If done reading out a value.
					output [DATA_WIDTH-1:0] o_Data_1,
					output [DATA_WIDTH-1:0] o_Data_2,
					
					// Mem Transaction
					output /*reg*/ o_MEM_Valid_1,
					output /*reg*/ o_MEM_Valid_2,
					output /*reg*/ o_MEM_Read_Write_n_1,
					output /*reg*/ o_MEM_Read_Write_n_2,
					output /*reg*/ [(TAG_WIDTH+INDEX_WIDTH+BLOCK_OFFSET_WIDTH):0] o_MEM_Address_1,	// output 2-byte aligned addresses
					output /*reg*/ [(TAG_WIDTH+INDEX_WIDTH+BLOCK_OFFSET_WIDTH):0] o_MEM_Address_2,
					output /*reg*/ [DATA_WIDTH-1:0] o_MEM_Data_1,
					output /*reg*/ [DATA_WIDTH-1:0] o_MEM_Data_2,
					input i_MEM_Valid,
					input i_MEM_Data_Read,
					input i_MEM_Last,
					input [DATA_WIDTH-1:0] i_MEM_Data
				);
				
				
				
      d_cache #(
      . DATA_WIDTH(DATA_WIDTH),
      .ADDRESS_WIDTH(ADDRESS_WIDTH),
      .BLOCK_OFFSET_WIDTH(BLOCK_OFFSET_WIDTH),
      .ASSOCIATIVITY(ASSOCIATIVITY),
      .INDEX_WIDTH(INDEX_WIDTH),
      .TAG_WIDTH(TAG_WIDTH),
      .MEM_MASK_WIDTH(MEM_MASK_WIDTH)
      ) cache_instance1 (
          .i_Clk(i_Clk),
          .i_Reset_n(i_Reset_n),
          .i_Valid(i_Valid),
          .i_Mem_Mask(i_Mem_Mask),
          .i_Address(i_Address),
          .i_Read_Write_n(i_Read_Write_n),
          .i_Write_Data( i_Write_Data),
          .o_Ready(o_Ready_1),
          .o_Valid(o_Valid_1),
          .o_Data(o_Data_1),
          .o_MEM_Valid(o_MEM_Valid_1),
          .o_MEM_Read_Write_n(o_MEM_Read_Write_n_1),
          .o_MEM_Address(o_MEM_Address_1),
          .o_MEM_Data(o_MEM_Data_1),
          .i_MEM_Valid(i_MEM_Valid),
          .i_MEM_Data_Read(i_MEM_Data_Read),
          .i_MEM_Last(i_MEM_Last),
          .i_MEM_Data(i_MEM_Data)
          );
          
          
          
      d_cache #(
      . DATA_WIDTH(DATA_WIDTH),
      .ADDRESS_WIDTH(ADDRESS_WIDTH),
      .BLOCK_OFFSET_WIDTH(BLOCK_OFFSET_WIDTH),
      .ASSOCIATIVITY(ASSOCIATIVITY),
      .INDEX_WIDTH(INDEX_WIDTH),
      .TAG_WIDTH(TAG_WIDTH),
      .MEM_MASK_WIDTH(MEM_MASK_WIDTH)
      ) cache_instance2 (
          .i_Clk(i_Clk),
          .i_Reset_n(i_Reset_n),
          .i_Valid(i_Valid),
          .i_Mem_Mask(i_Mem_Mask),
          .i_Address(i_Address),
          .i_Read_Write_n(i_Read_Write_n),
          .i_Write_Data( i_Write_Data),
          .o_Ready(o_Ready_2),
          .o_Valid(o_Valid_2),
          .o_Data(o_Data_2),
          .o_MEM_Valid(o_MEM_Valid_2),
          .o_MEM_Read_Write_n(o_MEM_Read_Write_n_2),
          .o_MEM_Address(o_MEM_Address_2),
          .o_MEM_Data(o_MEM_Data_2),
          .i_MEM_Valid(i_MEM_Valid),
          .i_MEM_Data_Read(i_MEM_Data_Read),
          .i_MEM_Last(i_MEM_Last),
          .i_MEM_Data(i_MEM_Data)
          );
          
          
       

endmodule : cache_top  
