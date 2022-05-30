LIBRARY IEEE;
USE IEEE.std_logic_1164.all;



ENTITY IDEXBuffer IS 
	PORT ( CLK: IN std_logic;
            nextInstAdd_in, rd1_in, rd2_in, offset_in: IN std_logic_vector (31 DOWNTO 0);
            rSrc1_in, rSrc2_in, rDst_in, ALUop_in: IN std_logic_vector (2 downto 0);
            BranchSrc_in, MemIndex_in: IN std_logic_vector (1 downto 0);
            isBranch_in, ALUsrc_in, MovToReg_in, RegW_in, Push_in, pop_in,
             MEMW_in, MEMR_in, RTI_in, RET_in, PCsrc2_in, useMEMindex_in, selectorForCall_in, selectorForINT_in: IN std_logic;
            nextInstAdd_out, rd1_out, rd2_out, offset_out: OUT std_logic_vector (31 DOWNTO 0);
            rSrc1_out, rSrc2_out, rDst_out, ALUop_out: OUT std_logic_vector (2 downto 0);
            BranchSrc_out, MemIndex_out: OUT std_logic_vector (1 downto 0);
            isBranch_out, ALUsrc_out, MovToReg_out, RegW_out, Push_out, pop_out,
             MEMW_out, MEMR_out, RTI_out, RET_out, PCsrc2_out, useMEMindex_out, selectorForCall_out, selectorForINT_out: out std_logic

            );
END IDEXBuffer;


ARCHITECTURE arch_IDEXBuffer OF IDEXBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            nextInstAdd_out <= nextInstAdd_in;
            rd1_out <= rd1_in;
            rd2_out <= rd2_in;
            offset_out <= offset_in;
            rSrc1_out <= rSrc1_in;
            rSrc2_out <= rSrc2_in;
            rDst_out <= rDst_in;
            ALUop_out <= ALUop_in;
            BranchSrc_out <= BranchSrc_in;
            MemIndex_out <= MemIndex_in;
            isBranch_out <= isBranch_in;
            ALUsrc_out <= ALUsrc_in;
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
		
		
  
END arch_IDEXBuffer;