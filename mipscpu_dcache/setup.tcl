read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/tryout_cache_git/cache_opensource.v }
set_elaborate_option -loop_iter_threshold 5000
elaborate -golden -verbose

set_mode mv
read_itl  {/home/kathiresan/ifx_svuvm_alu/tryout_cache_git/cache_prop.vli}
