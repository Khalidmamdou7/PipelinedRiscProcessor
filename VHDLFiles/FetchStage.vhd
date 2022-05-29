Library ieee;
Use ieee.std_logic_1164.all;

Entity FetchStage IS
    PORT (
        clk: IN std_logic;
        NextInstAdd: OUT std_logic_vector (31 DOWNTO 0);
        Inst: OUT std_logic_vector (31 DOWNTO 0)
    );
END FetchStage;

ARCHITECTURE arch_FetchStage OF FetchStage IS
    COMPONENT adder IS
        PORT(
            Op1: IN std_logic_vector (31 DOWNTO 0);
            Op2: IN std_logic_vector (31 downto 0);
            result: OUT std_logic_vector (31 downto 0)
            );
    END COMPONENT;
    COMPONENT PC IS
        PORT(
	    clk : IN std_logic;
            input: IN std_logic_vector (31 DOWNTO 0);
            output: OUT std_logic_vector (31 downto 0)
            );
    END COMPONENT;
    COMPONENT Memory IS
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
    END COMPONENT;
    

	SIGNAL pc_In, pc_Out, mem_Out: std_logic_vector(31 downto 0);
    SIGNAL dump: std_logic_vector(31 downto 0);
    

   

    BEGIN

        pcAdder: adder PORT MAP (X"00000001", pc_Out, pc_In);
        myPC: PC PORT MAP (clk, pc_In,  pc_Out);
        myMEM: Memory PORT MAP (clk, '0', '0', '0', '0', X"00000", pc_Out(19 downto 0),  X"00000",  X"00000000",   X"00000000", dump, mem_Out);
        NextInstAdd <= pc_In;
        Inst <= mem_out;
        

END arch_FetchStage;
