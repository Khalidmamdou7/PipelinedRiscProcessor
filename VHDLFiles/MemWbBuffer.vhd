LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MemWbBuffer IS 
	PORT ( CLK: IN std_logic;
            ALUresult_in, MemRD_in: IN std_logic_vector (31 DOWNTO 0);
            rSrc1_in, rDst_in: IN std_logic_vector (2 downto 0);
            MovToReg_in, RegW_in: IN std_logic;
            ALUresult_out, MemRD_out: OUT std_logic_vector (31 DOWNTO 0);
            rSrc1_out, rDst_out: OUT std_logic_vector (2 downto 0);
            MovToReg_out, RegW_out: out std_logic

            );
END MemWbBuffer;


ARCHITECTURE arch_MemWbBuffer OF MemWbBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            ALUresult_out <= ALUresult_in;
            MemRD_out <= MemRD_in;
            rSrc1_out <= rSrc1_in;
            rDst_out <= rDst_in;
            MovToReg_out <= MovToReg_in;
            RegW_out <= RegW_in;
            
         END IF;
        



        end process;
		
		
  
END arch_MemWbBuffer;