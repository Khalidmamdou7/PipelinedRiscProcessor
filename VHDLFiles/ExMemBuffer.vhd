LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

USE work.EXMEMp.all;

ENTITY ExMemBuffer IS 
	PORT ( CLK: IN std_logic;
            EXMEMs_in : IN EXMEMs;
            EXMEMs_out : OUT EXMEMs
            );
END ExMemBuffer;


ARCHITECTURE arch_ExMemBuffer OF ExMemBuffer is
	BEGIN
    process(clk) IS
    begin
        IF (falling_edge(clk)) THEN
            EXMEMs_out <= EXMEMs_in;
         END IF;
         
        end process;
		
		
  
END arch_ExMemBuffer;