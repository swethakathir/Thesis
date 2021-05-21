read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/riscv_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/ariane_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/wt_cache_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/cva6_icache.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/sram.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/SyncSpRamBeNx64.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/lfsr_8bit.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/lzc.sv }

elaborate -golden -verbose -top cva6_icache

set_mode mv

read_itl  {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/cache_property.vli}
