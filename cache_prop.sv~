module cache_prop(address,data,rst,clk,mode,pseudo_ram,ram,out);

input logic [31:0] address;
input logic [31:0] data;
input logic clk;
input logic rst;
input logic mode; //mode equal to 1 when we write and equal to 0 when we read
input logic [31:0] pseudo_ram;
input logic [31:0] ram;
input logic [31:0] out;

`define index cache_and_ram.index
`define cache cache_and_ram.cache
`define valid_array cache_and_ram.valid_array
`define tag_array cache_and_ram.tag_array
`define tag cache_and_ram.tag


property reset;
!rst |=> 
    // Internal States
    (`cache == 0) and 
    (`valid_array == 0) and 
    (`tag_array == 0) and
    // Outputs
    (ram == 0) and
    (out == 0);
endproperty


property read_hit;
    (!mode and
    (`valid_array[`index] == 1) && (`tag_array[`index] == `tag))
    |=> 
    // Internal States
    (`cache == $past(`cache)) and
    (`valid_array == $past(`valid_array)) and 
    (`tag_array == $past(`tag_array)) and
    // Outputs
    (out == `cache[$past(`index)]) and
    (ram == $past(ram));
endproperty


property write_hit;
    (mode and
    (`valid_array[`index] == 1) && (`tag_array[`index] == `tag))
    |=> 
    // Internal States
    (`cache[$past(`index)] == $past(data)) and
    (`valid_array == $past(`valid_array)) and 
    (`tag_array == $past(`tag_array)) and
    // Outputs
    (out == $past(out)) and
    (ram == $past(data));
endproperty


property write_miss;
    (mode and
    ((`valid_array[`index] != 1) || (`tag_array[`index] != `tag)))
    |=> 
    // Internal States
    (`cache == $past(`cache)) and
    (`valid_array == $past(`valid_array)) and 
    (`tag_array == $past(`tag_array)) and
    // Outputs
    (out == $past(out)) and
    (ram == $past(data));
endproperty

property read_miss(n);
    (!mode and ((`valid_array[`index] != 1) || (`tag_array[`index] != `tag)))
    |=> 
    // Internal States
    (`valid_array[$past(`index)] == 1) and 
    (`tag_array[$past(`index)] == $past(address[11:6])) and
    (`cache[n] == (($past(`index) == n) ? $past(pseudo_ram) : $past(`cache[n]))) and
    (`cache[$past(`index)] == $past(pseudo_ram)) and
    // Outputs
    (out == $past(pseudo_ram)) and
    (ram == $past(ram));
endproperty

//(!mode && ((`valid_array[`index] != 1) || (`tag_array[`index] != `tag)))|=> ((out==`ram[$past(`addr)]) && (`cache[$past(`index)] == `ram[$past(`addr)]));



read_hit_prop:assert property(@(posedge clk) disable iff(!rst) read_hit); 

for (genvar i = 0; i < 64; i = i + 1) begin
read_miss_prop:assert property(@(posedge clk) disable iff(!rst) read_miss(i));
end

write_miss_prop:assert property(@(posedge clk) disable iff(!rst) write_miss);

write_hit_prop:assert property(@(posedge clk) disable iff(!rst) write_hit); 

reset_prop:assert property(@(posedge clk) reset);



endmodule

//---------------------------------------------------------------------------------------------
bind cache_and_ram cache_prop cache_prop_inst(.*);
//---------------------------------------------------------------------------------------------


