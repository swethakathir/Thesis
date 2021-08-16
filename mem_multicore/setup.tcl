read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/cluster.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/arbiter.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/dpsram.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/core.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/pipeline.v }


set_elaborate_option -loop_iter_threshold 20000
elaborate -golden -verbose
set_compile_option -golden -black_box_instances { {core[0]/inst} {core[1]/inst} {core[2]/inst} {core[3]/inst} {core[4]/inst} {core[5]/inst} {core[6]/inst} {core[7]/inst} {core[8]/inst} {core[9]/inst} {core[10]/inst} {core[11]/inst} {core[12]/inst} {core[13]/inst} {core[14]/inst} {core[15]/inst} } -black_box { } -cut_signal  {} -top {} -dontcare_handling sim -macro_iterations 4 -undriven_value sim -time_step macro -feedback_loop_latch {} -clock {} -no_clock {} -signal_domains {};

compile -golden

set_mode mv
read_itl  {/home/kathiresan/ifx_svuvm_alu/mem_multicore/prop.vli}
