module mem_top
    #(parameter NUM_CORES = 16,
      parameter LOCAL_MEMORY_SIZE = 512,
      parameter GLOBAL_MEMORY_SIZE = 8192,
      parameter GMEM_ADDR_WIDTH = $clog2(GLOBAL_MEMORY_SIZE) )

    (input          clk,
    input           reset,
    input  [15:0]   device_data_in,
    output          device_write_en_1, //need to verify device_output signals. It is based on device memory select
    output          device_read_en_1,
    output [9:0]    device_addr_1,
    output [15:0]   device_data_out_1,
    output reg [$clog2(NUM_CORES) - 1:0] device_core_id_1,
    
    output          device_write_en_2, //need to verify device_output signals. It is based on device memory select
    output          device_read_en_2,
    output [9:0]    device_addr_2,
    output [15:0]   device_data_out_2,
    output reg [$clog2(NUM_CORES) - 1:0] device_core_id_2,

    input           axi_we,
    input  [15:0]   axi_addr,
    input  [15:0]   axi_data,
    output [15:0]   axi_q_1,
    output [15:0]   axi_q_2);
    
    cluster #(
        .NUM_CORES(NUM_CORES),
        .LOCAL_MEMORY_SIZE(LOCAL_MEMORY_SIZE),
        .GLOBAL_MEMORY_SIZE (GLOBAL_MEMORY_SIZE),
        .GMEM_ADDR_WIDTH (GMEM_ADDR_WIDTH)
      ) cluster_1 (
          .clk    ( clk ),
          .reset  ( reset ),
          .device_data_in   ( device_data_in ),
          .device_write_en  ( device_write_en_1 ),
          .device_read_en   ( device_read_en_1 ),
          .device_addr      ( device_addr_1 ),
          .device_data_out  ( device_data_out_1 ),
          .device_core_id   (device_core_id_1 ),
          .axi_we   (axi_we ),
          .axi_addr (axi_addr ),
          .axi_data (axi_data ),
          .axi_q    (axi_q_1 )
      );
      
      cluster #(
        .NUM_CORES(NUM_CORES),
        .LOCAL_MEMORY_SIZE(LOCAL_MEMORY_SIZE),
        .GLOBAL_MEMORY_SIZE (GLOBAL_MEMORY_SIZE),
        .GMEM_ADDR_WIDTH (GMEM_ADDR_WIDTH)
      ) cluster_2 (
          .clk    ( clk ),
          .reset  ( reset ),
          .device_data_in   ( device_data_in ),
          .device_write_en  ( device_write_en_2 ),
          .device_read_en   ( device_read_en_2 ),
          .device_addr      ( device_addr_2 ),
          .device_data_out  ( device_data_out_2 ),
          .device_core_id   ( device_core_id_2 ),
          .axi_we   ( axi_we ),
          .axi_addr ( axi_addr ),
          .axi_data ( axi_data ),
          .axi_q    ( axi_q_2 )
      );
      
endmodule : mem_top
