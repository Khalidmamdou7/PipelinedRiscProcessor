LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY CONTROL IS
PORT(
	OPcode : IN  std_logic_vector(4 DOWNTO 0);

	RegWrite : OUT std_logic;
    IOread : OUT std_logic;
    IOwrite : OUT std_logic;

    ISbranch : OUT std_logic;
    branchSRC : OUT std_logic_vector (1 DOWNTO 0);

    ALUoperation : OUT  std_logic_vector(2 DOWNTO 0);
    ALUSRC : OUT std_logic;

    Push : out std_logic;
    Pop : out std_logic;
    MemRead : out std_logic;
    MemWrite : out std_logic;

    RTI : out std_logic;
    RET : out std_logic;

    MemIndex : out std_logic_vector(1 DOWNTO 0);
    UseMemIndex : out std_logic;

    MemtoReg : out std_logic;

    selectorforCALL : out std_logic;
    selectorforINT : out std_logic
);
END ENTITY;

ARCHITECTURE myCONTROL OF CONTROL IS
	BEGIN
    RegWrite <= '0' when OPcode = "00000" OR OPcode = "00010" OR OPcode = "00101" OR OPcode = "00110" OR OPcode = "10001" OR OPcode = "10010" OR OPcode = "10011" OR OPcode = "10100" OR OPcode = "10101" OR OPcode = "10110" OR OPcode = "10111" OR OPcode = "11000" OR OPcode = "11001" else
    '1';

    IOread <= '1' when OPcode = "00110" else
    '0';

    IOwrite <= '1' when OPcode = "00101" else
    '0';

    ISbranch <= '1' when OPcode = "10010" OR OPcode = "10011" OR OPcode = "10100" OR OPcode = "10101" OR OPcode = "10110" else
    '0';

    branchSRC <= "11" when OPcode = "00000" OR OPcode = "10101" OR OPcode = "10110" OR OPcode = "10111" OR OPcode = "11000" OR OPcode = "11001" else
    "01" when OPcode = "10011" else
    "10" when OPcode = "10100" else
    "00";

    ALUoperation <= "000" when OPcode = "01001" OR OPcode = "01100" OR OPcode = "10000" OR OPcode = "10001" else
    "001" when OPcode = "01010" else
    "010" when OPcode = "00011" else
    "011" when OPcode = "00100" else
    "100" when OPcode = "01011" else
    "101" when OPcode = "00010" else
    "111" when OPcode = "01000" else
    "110";

    ALUSRC <= '1' when OPcode = "00011" OR OPcode = "00100" OR OPcode = "00111" OR OPcode = "01000" OR OPcode = "01001" OR OPcode = "01010" OR OPcode = "01011" else
    '0';

    Push <= '1' when OPcode = "10110" OR OPcode = "11000" else
    '0';

    Pop <= '1' when OPcode = "01110" OR OPcode = "10111" OR OPcode = "11001" else
    '0';

    MemRead <= '1' when OPcode = "10000" else
    '0';

    MemWrite <= '1' when OPcode = "10001" else
    '0';

    RTI <= '1' when OPcode = "11001" else
    '0';

    RET <= '1' when OPcode = "10111" OR OPcode = "11000" OR OPcode = "11001" else
    '0';

    MemIndex <= "00";
    UseMemIndex <= '0';

    MemtoReg <= '1' when OPcode = "00011" OR OPcode = "00100" OR OPcode = "00111" OR OPcode = "01000" OR OPcode = "01001" OR OPcode = "01010" OR OPcode = "01011" OR OPcode = "01100" OR OPcode = "01111" else
    '0';

    selectorforCALL <= '0' when OPcode = "10110" OR OPcode = "10111" OR OPcode = "11000" OR OPcode = "11001" else
    '1';

    selectorforINT <= '0' when OPcode = "10111" OR OPcode = "11000" OR OPcode = "11001" else
    '1';
END Architecture;