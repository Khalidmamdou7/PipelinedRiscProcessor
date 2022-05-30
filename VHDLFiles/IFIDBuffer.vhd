LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY IFIDBuffer IS 
	PORT ( CLK: IN std_logic;
            IF_flush, IF_write: IN std_logic;
            inst_in, nextInst_in: IN std_logic_vector (31 DOWNTO 0);
            inst_out, nextInst_out: OUT std_logic_vector (31 DOWNTO 0)
            );
END IFIDBuffer;


ARCHITECTURE arch_IFIDBuffer OF IFIDBuffer is
	BEGIN
    process(clk, IF_flush, IF_Write) IS
    begin
        IF (falling_edge(clk) and IF_write = '0') THEN
            inst_out <= inst_in;
            nextInst_out <= nextInst_in;
        END IF;
        IF (IF_FLUSH = '1') THEN
            inst_out <= X"00000000";
            nextInst_out <= X"00000000";
        END IF;



        end process;
		
		
  
END arch_IFIDBuffer;