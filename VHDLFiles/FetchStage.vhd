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
    

	SIGNAL pc_In, pc_Out: std_logic_vector(31 downto 0);

   

    BEGIN

        pcAdder: adder PORT MAP (X"00000001", pc_Out, pc_In);
        myPC: PC PORT MAP (clk, pc_In,  pc_Out);
        Inst <= pc_Out;
        NextInstAdd <= pc_In;
        

END arch_FetchStage;
