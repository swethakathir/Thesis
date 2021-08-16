read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/cluster.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/arbiter.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/dpsram.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/core.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/pipeline.v }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {/home/kathiresan/ifx_svuvm_alu/mem_multicore/mem_top.v }


set_elaborate_option -loop_iter_threshold 20000
elaborate -golden -verbose

set_compile_option -golden -black_box_instances { {cluster_1/core[0]/inst} {cluster_1/core[1]/inst} {cluster_1/core[2]/inst} {cluster_1/core[3]/inst} {cluster_1/core[4]/inst} {cluster_1/core[5]/inst} {cluster_1/core[6]/inst} {cluster_1/core[7]/inst} {cluster_1/core[8]/inst} {cluster_1/core[9]/inst} {cluster_1/core[10]/inst} {cluster_1/core[11]/inst} {cluster_1/core[12]/inst} {cluster_1/core[13]/inst} {cluster_1/core[14]/inst} {cluster_1/core[15]/inst} {cluster_2/core[0]/inst} {cluster_2/core[1]/inst} {cluster_2/core[2]/inst} {cluster_2/core[3]/inst} {cluster_2/core[4]/inst} {cluster_2/core[5]/inst} {cluster_2/core[6]/inst} {cluster_2/core[7]/inst} {cluster_2/core[8]/inst} {cluster_2/core[9]/inst} {cluster_2/core[10]/inst} {cluster_2/core[11]/inst} {cluster_2/core[12]/inst} {cluster_2/core[13]/inst} {cluster_2/core[14]/inst} {cluster_2/core[15]/inst} } -black_box { } -cut_signal  {} -top {} -dontcare_handling sim -macro_iterations 4 -undriven_value sim -time_step macro -feedback_loop_latch {} -clock {} -no_clock {} -signal_domains {};

compile -golden

set_mode mv

read_itl  {/home/kathiresan/ifx_svuvm_alu/mem_multicore/s2qed_prop.vli}
