read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/cache_1.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/cache_2.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/cache_top.sv }

elaborate -golden -verbose

set_mode mv

read_itl  {/home/kathiresan/ifx_svuvm_alu/cachesubsystem_opensource/cache_s2qed.vli}
