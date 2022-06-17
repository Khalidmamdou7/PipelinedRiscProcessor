vsim -gui work.processor(arch_processor)
# vsim -gui work.processor(arch_processor) 
# Start time: 14:09:40 on Jun 17,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.ifidp
# Loading work.idexp
# Loading work.exmemp
# Loading work.memwbp
# Loading work.processor(arch_processor)
# Loading work.ifidbuffer(arch_ifidbuffer)
# Loading work.idexbuffer(arch_idexbuffer)
# Loading work.exmembuffer(arch_exmembuffer)
# Loading work.memwbbuffer(arch_memwbbuffer)
# Loading work.fetchstage(arch_fetchstage)
# Loading ieee.numeric_std(body)
# Loading work.adder(arch_adder)
# Loading work.pc(arch_pc)
# Loading work.decodestage(arch_decodestage)
# Loading work.regfile(myregfile)
# Loading work.my_ndff(b_my_ndff)
# Loading work.my_dff(a_my_dff)
# Loading work.control(mycontrol)
# Loading work.signext(mysignext)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.exestage(myexe)
# Loading work.alu(myalu)
# Loading work.my_32adder(a_my_32adder)
# Loading work.my_adder(a_my_adder)
# Loading work.flagreg(myflag)
# Loading work.dff(mydff)
# Loading work.memstage(mymem)
# Loading work.sp_full(a_sp_full)
# Loading work.sp_reg(a_sp_reg)
# Loading work.sp_dff(a_sp_dff)
# Loading work.wbstage(arch_wbstage)
# Loading work.memory(mymemory)
add wave -position insertpoint  \
sim:/processor/clk \
sim:/processor/RST \
sim:/processor/IFIDs_in \
sim:/processor/IFIDs_out \
sim:/processor/IDEXs_in \
sim:/processor/IDEXs_out \
sim:/processor/EXMEMs_in \
sim:/processor/EXMEMs_out \
sim:/processor/MEMWBs_in \
sim:/processor/MEMWbs_out \
sim:/processor/IF_flush \
sim:/processor/IF_write \
sim:/processor/pcSrc1 \
sim:/processor/s_InstAdd \
sim:/processor/s_BranchAddressResult \
sim:/processor/s_spAddress \
sim:/processor/s_address \
sim:/processor/s_writeData \
sim:/processor/s_WBresult
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: khali  Hostname: LAPTOP-MDHCMJLP  ProcessID: 6016
#           Attempting to use alternate WLF file "./wlftjykz6m".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftjykz6m
force -freeze sim:/processor/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/processor/RST 1 0
run
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 0  Instance: /processor/myExStage/f0
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 1  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 1  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 1  Instance: /processor/myExStage
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 50 ps  Iteration: 0  Instance: /processor/myMemory
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 50 ps  Iteration: 1  Instance: /processor/myExStage
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 50 ps  Iteration: 1  Instance: /processor/myExStage
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 50 ps  Iteration: 1  Instance: /processor/myExStage/f0
# ** Warning: NUMERIC_STD."<": metavalue detected, returning FALSE
#    Time: 50 ps  Iteration: 3  Instance: /processor/myExStage/f0
add wave -position insertpoint  \
sim:/processor/myFetchStage/pc_In

force -freeze sim:/processor/myFetchStage/pc_In 16#0 0
force -freeze sim:/processor/RST 0 0
force -freeze sim:/processor/IF_flush 0 0
force -freeze sim:/processor/IF_write 0 0
mem load -filltype value -filldata 11000100010001000100000000000000 -fillradix symbolic /processor/myMemory/Memory(0)
mem load -filltype value -filldata 11000100010001000100100100100100 -fillradix symbolic /processor/myMemory/Memory(1)
mem load -filltype value -filldata 11000100010001000101001001000100 -fillradix symbolic /processor/myMemory/Memory(2)
mem load -filltype value -filldata 11000100010001000110010010000011 -fillradix symbolic /processor/myMemory/Memory(3)
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 150 ps  Iteration: 0  Instance: /processor/myMemory
noforce sim:/processor/myFetchStage/pc_In
run
run

run