LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ALU IS
	PORT(
	ALU_OP: IN std_logic_vector (2 downto 0);
        Op1: IN std_logic_vector (31 DOWNTO 0);
        Op2: IN std_logic_vector (31 downto 0);
	flags_in: IN std_logic_vector (2 downto 0);
        result: OUT std_logic_vector (31 downto 0);
	flags_out: OUT std_logic_vector (2 downto 0)
	);
END ENTITY;

ARCHITECTURE myALU OF ALU IS

component my_32adder IS
PORT (a, b : IN std_logic_vector(31 DOWNTO 0) ;
cin : IN std_logic;
addORsub : IN std_logic;
s : OUT std_logic_vector(31 DOWNTO 0);
cout : OUT std_logic);
END component;
SIGNAL overflow : std_logic;
SIGNAL addORsub : std_logic;
SIGNAL output : std_logic_vector(31 DOWNTO 0);
SIGNAL semi_out : std_logic_vector(31 DOWNTO 0);
	BEGIN
	
	addORsub <= '1' when ALU_OP = "001" else
	'0';
	
	semi_out <= output when ALU_OP = "000" else
        output when ALU_OP = "001" else
        not Op1 when ALU_OP = "010" else
        std_logic_vector( unsigned(Op1) + 1 ) when ALU_OP = "011" else
        Op1 AND Op2 when ALU_OP = "100" else
        Op1 when ALU_OP = "101" else
        Op1 when ALU_OP = "110" else
        Op2 when ALU_OP = "111";

        flags_out(0) <= '1' when (semi_out = x"00000000" and (ALU_OP /="110" and ALU_OP /= "111")) else
        flags_in(0) when ALU_OP ="110" OR ALU_OP = "111" OR ALU_OP = "101" else
        '0';

        flags_out(1) <= '1' when ((signed(semi_out) < 0) and (ALU_OP /="110" and ALU_OP /= "111")) else
        flags_in(1) when ALU_OP ="110" OR ALU_OP = "111" else
        '0';

        flags_out(2) <= overflow when ALU_OP = "000" else
        overflow when ALU_OP = "001" else
        '1' when ALU_OP = "101" else
        flags_in(2) when ALU_OP ="110" OR ALU_OP = "111" else
        '0';
	result <= semi_out;
	f0: my_32adder port map (Op1, OP2, '0', addORsub, output, overflow);
END Architecture;