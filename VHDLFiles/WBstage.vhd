LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;

entity WBstage IS
    PORT(
        MemToReg: IN std_logic;
        ReadDfromMem, aluResult: IN std_logic_vector (31 downto 0);
        WBresult: OUT std_logic_vector (31 downto 0)
    );
END entity;

ARCHITECTURE arch_WBstage OF WBstage IS

    BEGIN
        WBresult <= ReadDfromMem when MemToReg = '0' else aluResult;
END ARCHITECTURE;