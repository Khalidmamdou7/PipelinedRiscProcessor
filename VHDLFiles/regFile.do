vsim -gui work.regfile(myregfile)
# vsim -gui work.regfile(myregfile) 
# Start time: 00:10:49 on May 30,2022
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.regfile(myregfile)
# Loading work.my_ndff(b_my_ndff)
# Loading work.my_dff(a_my_dff)
add wave -position insertpoint  \
sim:/regfile/n \
sim:/regfile/Clk \
sim:/regfile/Rst \
sim:/regfile/readreg1 \
sim:/regfile/readreg2 \
sim:/regfile/wrtreg \
sim:/regfile/wrtdata \
sim:/regfile/regwrite \
sim:/regfile/IORead \
sim:/regfile/ReadData1 \
sim:/regfile/ReadData2 \
sim:/regfile/Reg0Out \
sim:/regfile/Reg1Out \
sim:/regfile/Reg2Out \
sim:/regfile/Reg3Out \
sim:/regfile/Reg4Out \
sim:/regfile/Reg5Out \
sim:/regfile/Reg6Out \
sim:/regfile/Reg7Out \
sim:/regfile/w1_en_signal
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: khali  Hostname: LAPTOP-MDHCMJLP  ProcessID: 6016
#           Attempting to use alternate WLF file "./wlftzjr5c7".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftzjr5c7
force -freeze sim:/regfile/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/regfile/Rst 0 0
force -freeze sim:/regfile/wrtreg 16#0 0
force -freeze sim:/regfile/wrtdata 16#22 0
force -freeze sim:/regfile/regwrite 1 0
force -freeze sim:/regfile/IORead 0 0
force -freeze sim:/regfile/readreg1 000 0
force -freeze sim:/regfile/readreg2 001 0
run
run
run
force -freeze sim:/regfile/wrtreg 001 0
run
run
