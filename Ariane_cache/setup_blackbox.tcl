read_verilog -golden  -pragma_ignore {}  -version sv2012 {riscv_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {ariane_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {wt_cache_pkg.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {cva6_icache.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {sram.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {SyncSpRamBeNx64.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {lfsr_8bit.sv }
read_verilog -golden  -pragma_ignore {}  -version sv2012 {lzc.sv }

elaborate -golden

set_compile_option -golden -black_box_instances {  {gen_sram[0]/data_sram} {gen_sram[0]/tag_sram} {gen_sram[1]/data_sram} {gen_sram[1]/tag_sram} {gen_sram[2]/data_sram} {gen_sram[2]/tag_sram} {gen_sram[3]/data_sram} {gen_sram[3]/tag_sram} } -black_box {  } -cut_signal  {} -top {} -dontcare_handling sim -macro_iterations 4 -undriven_value sim -time_step macro -feedback_loop_latch {} -clock {} -no_clock {} -signal_domains {};

compile -golden

set_mode mv