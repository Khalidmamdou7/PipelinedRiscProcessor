Library ieee;
Use ieee.std_logic_1164.all;

Entity FetchStage IS
    PORT (
        clk: IN std_logic;
        PCval: IN std_logic_vector (31 DOWNTO 0);
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
            input: IN std_logic_vector (31 DOWNTO 0);
            clk : IN std_logic;
            output: OUT std_logic_vector (31 downto 0)
            );
    END COMPONENT;
    

   
	SIGNAL pc_Out, pc_In, adder_Out: std_logic_vector(31 downto 0);
    SIGNAL state: std_logic := '0';
   

    BEGIN

        

        pcAdder: adder PORT MAP (X"00000004", pc_Out, adder_Out);
        myPC: PC PORT MAP (pc_In, clk, pc_Out);
        Inst <= pc_Out;
        NextInstAdd <= adder_Out;

        PROCESS(CLK, state) is
            begin
                IF (state = '0') THEN
                    pc_In <= PCval;
                    state <= '1';
                END IF;
                IF (rising_edge(clk)) THEN
                    pc_IN <= adder_Out;
                END IF;

        
        end PROCESS;

END arch_FetchStage;
