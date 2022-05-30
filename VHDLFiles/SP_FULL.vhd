LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;

ENTITY SP_FULL IS
    PORT(
        clk : IN std_logic;
        Push : IN std_logic;
        Pop : IN std_logic
    );
END ENTITY;


ARCHITECTURE a_SP_FULL OF SP_FULL IS
COMPONENT SP_reg IS
PORT(
    d : IN std_logic_vector (19 DOWNTO 0);
    clk : IN std_logic;
    rst : IN std_logic;
    en : IN std_logic;
    q : OUT std_logic_vector (19 DOWNTO 0)
);
END COMPONENT;
signal temp : std_logic_vector(19 DOWNTO 0);
signal dummy : std_logic_vector(19 DOWNTO 0);
BEGIN
temp <= dummy when Push = '0' and Pop = '0' else
(dummy - "00000000000000000001") when Push = '1' and clk = '1' else
(dummy + "00000000000000000001") when Pop = '1' and clk = '1';

f0: SP_reg port map (temp, clk, '0', '1', dummy);
END ARCHITECTURE;
