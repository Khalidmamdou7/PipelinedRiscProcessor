LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE IEEE.numeric_std.all;

entity EXEstage IS
    PORT(
        clk : IN std_logic;

        ALUsrc : IN std_logic;
        ALUOperation : IN std_logic_vector (2 DOWNTO 0);

        NextInstAddress : IN std_logic_vector (19 DOWNTO 0);
        ReadData1 : IN std_logic_vector (31 DOWNTO 0);
        ReadData2 : IN std_logic_vector (31 DOWNTO 0);
        SignExtend : IN std_logic_vector (31 DOWNTO 0);

        ALUresult : OUT std_logic_vector (31 DOWNTO 0);
        Flags : OUT std_logic_vector (2 DOWNTO 0);
        Rsrc1Val : OUT std_logic_vector (31 DOWNTO 0);
        BranchAddressResult : OUT std_logic_vector (19 DOWNTO 0)

    );
END entity;

ARCHITECTURE myEXE OF EXEstage IS

COMPONENT ALU IS
	PORT(
	ALU_OP: IN std_logic_vector (2 DOWNTO 0);
        Op1: IN std_logic_vector (31 DOWNTO 0);
        Op2: IN std_logic_vector (31 DOWNTO 0);
	flags_in: IN std_logic_vector (2 DOWNTO 0);
        result: OUT std_logic_vector (31 DOWNTO 0);
	flags_out: OUT std_logic_vector (2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT FlagReg is 
    generic (n: integer :=3);
    port(
    clk : in std_logic;
    D : in std_logic_vector (n-1 DOWNTO 0);
    Q : out std_logic_vector (n-1 DOWNTO 0)
    );
end COMPONENT;

SIGNAL operand1 : std_logic_vector(31 DOWNTO 0);
SIGNAL operand2 : std_logic_vector(31 DOWNTO 0);
SIGNAL flagsTOalu : std_logic_vector(2 DOWNTO 0);
SIGNAL flagsFROMalu : std_logic_vector(2 DOWNTO 0);
SIGNAL dummy : std_logic_vector(20 DOWNTO 0);

BEGIN
    operand1 <= ReadData1 when ALUsrc = '1' else
    SignExtend;

    Flags <= flagsFROMalu;
    dummy <= ('0'&NextInstAddress) + ('0'&SignExtend(19 DOWNTO 0));
    BranchAddressResult <= dummy(19 DOWNTO 0);

    operand2 <= ReadData2;
    Rsrc1Val <= operand1;
    f0 : ALU port map (ALUOperation, operand1, operand2, flagsTOalu, ALUresult, flagsFROMalu);
    f1 : FlagReg port map (clk, flagsFROMalu, flagsTOalu);
END ARCHITECTURE;