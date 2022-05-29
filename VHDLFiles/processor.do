vsim -gui work.processor(arch_processor)
# vsim -gui work.processor(arch_processor) 
# Start time: 03:05:02 on May 29,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.processor(arch_processor)
# Loading work.fetchstage(arch_fetchstage)
# Loading ieee.numeric_std(body)
# Loading work.adder(arch_adder)
# Loading work.pc(arch_pc)
# Loading work.memory(mymemory)
# Loading work.pipelinebuffer(arch_pipelinebuffer)
add wave -position insertpoint  \
sim:/processor/clk \
sim:/processor/NextInstAdd \
sim:/processor/Inst \
sim:/processor/s_NextInstAdd \
sim:/processor/s_Inst \
sim:/processor/buffer_in \
sim:/processor/buffer_out \
sim:/processor/state
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: khali  Hostname: LAPTOP-MDHCMJLP  ProcessID: 6016
#           Attempting to use alternate WLF file "./wlft9y6vny".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlft9y6vny
add wave -position insertpoint  \
sim:/processor/myFetchStage/pc_In
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/myFetchStage/pc_In 16#2 0
mem load -filltype value -filldata 22 -fillradix hexadecimal /processor/myFetchStage/myMEM/Memory(1)
mem load -filltype value -filldata 22 -fillradix hexadecimal /processor/myFetchStage/myMEM/Memory(2)
mem load -filltype value -filldata 1 -fillradix hexadecimal /processor/myFetchStage/myMEM/Memory(0)
mem load -filltype value -filldata 21 -fillradix hexadecimal /processor/myFetchStage/myMEM/Memory(2)
mem load -filltype value -filldata 23 -fillradix hexadecimal /processor/myFetchStage/myMEM/Memory(3)
force -freeze sim:/processor/myFetchStage/pc_In 16#1 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /processor/myFetchStage/myMEM
run
noforce sim:/processor/myFetchStage/pc_In
run
run
run

