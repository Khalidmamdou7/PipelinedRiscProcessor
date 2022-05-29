LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Memory IS
PORT(
	clk : IN std_logic;
	MemWrite  : IN std_logic;
	MemRead  : IN std_logic;
	Push  : IN std_logic;
	Pop  : IN std_logic;
	address : IN  std_logic_vector(19 DOWNTO 0);
	PCAddress : IN std_logic_vector(19 DOWNTO 0);
	SPAddress : IN std_logic_vector(19 DOWNTO 0);
	WriteData  : IN  std_logic_vector(31 DOWNTO 0);
	WritePCData  : IN  std_logic_vector(31 DOWNTO 0);
	ReadData : OUT std_logic_vector(31 DOWNTO 0);
	ReadPCData : OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE myMemory OF Memory IS

	TYPE mem_type IS ARRAY(0 TO 1048575) OF std_logic_vector(31 DOWNTO 0);
	SIGNAL Memory : mem_type ;
	
	BEGIN
	PROCESS(clk) IS
		BEGIN
			IF rising_edge(clk) THEN
				IF MemWrite = '1' THEN
					Memory(to_integer(unsigned(address))) <= WriteData;
				elsif push = '1' then
					Memory(to_integer(unsigned(SPAddress))) <= WriteData;
				END IF;
			END IF;

			IF falling_edge(clk) THEN
			ReadPCData <= Memory(to_integer(unsigned(PCaddress)));
				IF MemRead = '1' THEN
					ReadData <= Memory(to_integer(unsigned(address)));
				elsif Pop = '1' then
					ReadData <= Memory(to_integer(unsigned(SPaddress)));
				END IF;
			END IF;
	END PROCESS;
END Architecture;