LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ExMemBuffer IS 
	PORT ( CLK: IN std_logic;
            nextInstAdd_in, ALUresult_in, rSrc1Val_in: IN std_logic_vector (31 DOWNTO 0);
            rSrc1_in, rDst_in, flags_in: IN std_logic_vector (2 downto 0);
            MemIndex_in: IN std_logic_vector (1 downto 0);
            MovToReg_in, RegW_in, Push_in, pop_in,
             MEMW_in, MEMR_in, RTI_in, RET_in, PCsrc2_in, useMEMindex_in, selectorForCall_in, selectorForINT_in: IN std_logic;
            nextInstAdd_out, ALUresult_out, rSrc1Val_out: OUT std_logic_vector (31 DOWNTO 0);
            rSrc1_out, rDst_out, flags_out: OUT std_logic_vector (2 downto 0);
            MemIndex_out: OUT std_logic_vector (1 downto 0);
            MovToReg_out, RegW_out, Push_out, pop_out,
             MEMW_out, MEMR_out, RTI_out, RET_out, PCsrc2_out, useMEMindex_out, selectorForCall_out, selectorForINT_out: out std_logic

            );
END ExMemBuffer;


ARCHITECTURE arch_ExMemBuffer OF ExMemBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            nextInstAdd_out <= nextInstAdd_in;
            ALUresult_out <= ALUresult_in;
            rSrc1Val_out <= rSrc1Val_in;
            rSrc1_out <= rSrc1_in;
            rDst_out <= rDst_in;
            flags_out <= flags_in;
            MemIndex_out <= MemIndex_in;
            MovToReg_out <= MovToReg_in;
            RegW_out <= RegW_in;
            Push_out <= Push_in;
            pop_out <= pop_in;
            MEMW_out <= MEMW_in;
            MEMR_out <=  MEMR_in;
            RTI_out <=  RTI_in;
            RET_out <= RET_in;
            PCsrc2_out <=  PCsrc2_in;
            useMEMindex_out <= useMEMindex_in;  
            selectorForCall_out <=  selectorForCall_in;
            selectorForINT_out <= selectorForINT_in;
         END IF;
        



        end process;
		
		
  
END arch_ExMemBuffer;