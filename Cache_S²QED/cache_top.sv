module cache #(
  parameter ADDR_WIDTH = 7,
  parameter DATA_DEPTH = 128, // usually 2**ADDR_WIDTH, but can be lower 7,128 = for 8kb ; 9,512 = 32kb; 10,1024 = 64kb; 8,256 = 16kb; 6,64 = 4kb; 
  parameter OUT_REGS   = 0,    // set to 1 to enable outregs 5,32 = 2kb; 4,16 = 1kb;
  parameter SIM_INIT   = 1     // for simulation only, will not be synthesized
                               // 0: no init, 1: zero init, 2: random init, 3: deadbeef init
                               // note: on verilator, 2 is not supported. define the VERILATOR macro to work around.
)(
  input  logic                  Clk_CI,
  input  logic                  Rst_RBI,
  input  logic                  CSel_SI,
  input  logic                  WrEn_SI,
  input  logic [7:0]            BEn_SI,
  input  logic [63:0]           WrData_DI,
  input  logic [ADDR_WIDTH-1:0] Addr_DI,
  output logic [63:0]           RdData_DO_1,
  output logic [63:0]           RdData_DO_2
);

      cache_1 #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_DEPTH(DATA_DEPTH),
        .OUT_REGS (OUT_REGS),
        // this initializes the memory with 0es. adjust to taste...
        // 0: no init, 1: zero init, 2: random init, 3: deadbeef init
        .SIM_INIT (SIM_INIT)
      ) cache1_sram (
          .Clk_CI    ( Clk_CI ),
          .Rst_RBI   ( Rst_RBI ),
          .CSel_SI   ( CSel_SI ),
          .WrEn_SI   ( WrEn_SI ),
          .BEn_SI    ( BEn_SI ),
          .WrData_DI ( WrData_DI ),
          .Addr_DI   ( Addr_DI ),
          .RdData_DO ( RdData_DO_1 )
      );
      
      cache_2 #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_DEPTH(DATA_DEPTH),
        .OUT_REGS (OUT_REGS),
        // this initializes the memory with 0es. adjust to taste...
        // 0: no init, 1: zero init, 2: random init, 3: deadbeef init
        .SIM_INIT (SIM_INIT)
      ) cache2_sram (
          .Clk_CI    ( Clk_CI ),
          .Rst_RBI   ( Rst_RBI ),
          .CSel_SI   ( CSel_SI ),
          .WrEn_SI   ( WrEn_SI ),
          .BEn_SI    ( BEn_SI ),
          .WrData_DI ( WrData_DI ),
          .Addr_DI   ( Addr_DI ),
          .RdData_DO ( RdData_DO_2 )
      );

endmodule : cache
