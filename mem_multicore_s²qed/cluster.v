module cluster
    #(parameter NUM_CORES = 16,
      parameter LOCAL_MEMORY_SIZE = 512,
      parameter GLOBAL_MEMORY_SIZE = 8192,
      parameter GMEM_ADDR_WIDTH = $clog2(GLOBAL_MEMORY_SIZE) )

    (input          clk,
    input           reset,
    input  [15:0]   device_data_in,
    output          device_write_en, //need to verify device_output signals. It is based on device memory select
    output          device_read_en,
    output [9:0]    device_addr,
    output [15:0]   device_data_out,
    output reg [$clog2(NUM_CORES) - 1:0] device_core_id,

    input           axi_we,
    input  [15:0]   axi_addr,
    input  [15:0]   axi_data,
    output [15:0]   axi_q);
 
    
    wire[15:0] memory_addr;
    wire[15:0] core_memory_addr [0:NUM_CORES-1];
    
    wire[15:0] memory_read_val;
    
    wire memory_wren;
    wire core_memory_wren [NUM_CORES-1:0];
    
    wire memory_rden;
    wire core_memory_rden [NUM_CORES-1:0];
    
    wire[15:0] memory_write_val;
    wire[15:0] core_memory_write_val[0:NUM_CORES-1];
    
    wire[15:0] idata[0:NUM_CORES-1]; //modified
    
    wire[15:0] global_mem_q;
    wire device_memory_select;
    reg device_memory_select_l;
    wire global_mem_write;
    wire[NUM_CORES-1:0] core_enable;
    wire[NUM_CORES-1:0] core_request;
    
    assign memory_wren = core_memory_wren[device_core_id];
    assign memory_rden = core_memory_rden[device_core_id];
    assign memory_addr = core_memory_addr[device_core_id];
    assign memory_write_val = core_memory_write_val[device_core_id];

    genvar i;
    generate
        for (i = 0; i < NUM_CORES; i = i + 1)
        begin: core
            core #(LOCAL_MEMORY_SIZE) inst (
                .clk(clk),
                .reset(reset),
                .core_enable(core_enable[i]),
                .core_request(core_request[i]),
                .memory_addr(core_memory_addr[i]),
                .memory_wren(core_memory_wren[i]),    
                .memory_rden(core_memory_rden[i]),  //iaddr, idata comes from pipeline module which are internals of black boxed cache
                .memory_write_val(core_memory_write_val[i]),
                .memory_read_val(memory_read_val),
                .ins_data(idata));
        end
    endgenerate

    assign device_memory_select = memory_addr[15:10] == 6'b111111;  //doubt 
    assign device_addr = memory_addr[9:0];
    assign global_mem_write = !device_memory_select && memory_wren;
    assign memory_read_val = device_memory_select_l ? device_data_in : global_mem_q;
    assign device_write_en = device_memory_select && memory_wren; 
    assign device_read_en = device_memory_select && memory_rden;
    assign device_data_out = memory_write_val;

    // Convert one-hot to binary
    integer oh_index;
    always @*
    begin : convert
        device_core_id = 0;
        for (oh_index = 0; oh_index < NUM_CORES; oh_index = oh_index + 1)
        begin
            if (core_enable[oh_index])
            begin : convert
                 // Use 'or' to avoid synthesizing priority encoder
                device_core_id = device_core_id | oh_index[$clog2(NUM_CORES) - 1:0];
            end
        end
    end

    dpsram 
`ifdef FEATURE_FPGA
    #(GLOBAL_MEMORY_SIZE, 16, GMEM_ADDR_WIDTH, 1, `PROGRAM_PATH) 
`else
    #(GLOBAL_MEMORY_SIZE, 16, GMEM_ADDR_WIDTH) 
`endif
    global_memory(
        .clk(clk),
        //Port A
        .addr_a(memory_addr[GMEM_ADDR_WIDTH - 1:0]),
        .q_a(global_mem_q),
        .we_a(global_mem_write),
        .data_a(memory_write_val),
        //Port B
        .addr_b(axi_addr[GMEM_ADDR_WIDTH - 1:0]),
        .q_b(axi_q),
        .we_b(axi_we),
        .data_b(axi_data));

    always @(posedge reset, posedge clk)
    begin
        if (reset)
            device_memory_select_l <= 0;
        else 
            device_memory_select_l <= device_memory_select;
    end

`ifdef STATIC_ARBITRATION
    reg[NUM_CORES - 1:0] core_enable_ff;
    
    assign core_enable = core_enable_ff;

    always @(posedge reset, posedge clk)
    begin
        if (reset)
            core_enable_ff <= {{NUM_CORES - 1{1'b0}}, 1'b1};
        else 
            core_enable_ff = { core_enable_ff[NUM_CORES - 2:0], core_enable_ff[NUM_CORES - 1] };
    end
`else
    arbiter #(NUM_CORES) global_mem_arbiter(
        .clk(clk),
        .reset(reset),
        .request(core_request),
        .grant_oh(core_enable));
`endif
endmodule
