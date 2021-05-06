module cache_and_ram(
    input [31:0] address,
    input [31:0] data,
    input rst,
    input clk,
    input mode, //mode equal to 1 when we write and equal to 0 when we read
    input [31:0] pseudo_ram, // open input for ram
    output [31:0] ram,       //open output for ram
    output [31:0] out
);

reg [31:0] addr;
reg [31:0] temp_out;


reg [5:0] index; // for keeping index of current address
reg [5:0] tag;  // for keeping tag of ceurrent address

parameter size = 64;        // cache size
parameter index_size = 6;   // index size

reg [31:0] cache [0:size - 1]; //registers for the data in cache
reg [11 - index_size:0] tag_array [0:size - 1]; // for all tags in cache
reg valid_array [0:size - 1]; //0 - there is no data 1 - there is data

parameter ram_size = 4096; //size of a ram in bits

// reg [31:0] ram [0:ram_size-1]; //data matrix for ram

always @(posedge clk or negedge rst)
begin

    if (rst==1'b0)
      begin: initialization
        integer i;
        for (i = 0; i < size; i = i + 1)
        begin
            valid_array[i] = 6'b000000;
            tag_array[i] = 6'b000000;
            cache[i] = 'b0;
           // ram[i] = 'b0;
            if (i < 32)
		          temp_out = 'b0;
        end
        index = 0;
        tag = 0;
      end
     else 
        begin
            addr = address % ram_size;
            tag = addr >> index_size; // tag = first bits of address except index ones (In our particular case - 6)
            index = address % size;       // index value = last n (n = size of cache) bits of address

            if (mode == 1)      // write to cache and memory
              begin
                ram = data;
                //write new data to the relevant cache block if there is such one
                if (valid_array[index] == 1 && tag_array[index] == tag)
                  cache[index] = data;
                  //  end
              end
            else             // read cache
              begin
                //write new data to the relevant cache's block, because the one we addressing to will be possibly addressed one more time soon
                if (valid_array[index] == 1 && tag_array[index] == tag)  
                  temp_out = cache[index];
                else                                           //(valid_array[index] != 1 || tag_array[index] != tag)
                  begin
                    valid_array[index] = 1;
                    tag_array[index] = tag;
                    cache[index] = pseudo_ram;
                    temp_out = pseudo_ram;
                  end
               end
        end
end

assign out = temp_out;

endmodule 
