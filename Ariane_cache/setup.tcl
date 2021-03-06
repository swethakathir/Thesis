read_verilog -golden  -pragma_ignore {}  -version sv2012 {riscv_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {ariane_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {wt_cache_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {cva6_icache.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {sram.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {SyncSpRamBeNx64.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {lfsr_8bit.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {lzc.sv }

elaborate -golden -verbose -top cva6_icache

set_mode mv

read_itl  {cache_property.vli}
