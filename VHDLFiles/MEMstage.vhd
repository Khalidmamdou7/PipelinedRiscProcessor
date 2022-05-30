LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY MEMstage IS
PORT(
    clk : IN std_logic;
    rst : IN std_logic;

	
    Rsrc1Val : in std_logic_vector(31 DOWNTO 0);
    ALUresult_in : in std_logic_vector(31 DOWNTO 0);
    ALUflags : in std_logic_vector(2 DOWNTO 0);
    NextInstAddress : in std_logic_vector(19 DOWNTO 0);

    
    ALUresult_out : OUT std_logic_vector(31 DOWNTO 0);

    Push : IN std_logic;
    Pop : IN std_logic;
    UseMemIndex : IN std_logic;
    MemIndex: IN STD_logic_vector(1 downto 0);
    selectorforCALL : IN std_logic;
    selectorforINT : IN std_logic;

    sp_address : OUT std_logic_vector(19 DOWNTO 0);
    address : OUT std_logic_vector(19 DOWNTO 0);
    WriteData : OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE myMEM OF MEMstage IS
COMPONENT SP_FULL IS
PORT(
    clk : IN std_logic;
    Push : IN std_logic;
    Pop : IN std_logic;
    rst : IN std_logic;
    addressout : OUT std_logic_vector (19 DOWNTO 0)
);
END COMPONENT;

signal extendedFlags : std_logic_vector (31 DOWNTO 0);
signal extendedNextAddress : std_logic_vector (31 DOWNTO 0);
	BEGIN
    ALUresult_out <= ALUresult_in;

    address <= ALUresult_in(19 DOWNTO 0) when UseMemIndex = '0' else
        "00" & X"0000" & MemIndex;
    

    extendedFlags <= std_logic_vector(resize(signed(ALUflags), extendedFlags'length));
    extendedNextAddress <= std_logic_vector(resize(signed(NextInstAddress), extendedNextAddress'length));

    WriteData <= extendedFlags when selectorforINT = '0' and selectorforCALL = '0' else
    extendedNextAddress when selectorforINT = '1' and selectorforCALL = '0' else
    Rsrc1Val when selectorforCALL = '1';

    f0 : SP_FULL port map (clk, Push, Pop, rst, sp_address);
END Architecture;