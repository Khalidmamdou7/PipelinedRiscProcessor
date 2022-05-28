Library ieee;
Use ieee.std_logic_1164.all;

Entity Processor IS
    PORT (
        clk: IN std_logic;
        NextInstAdd: OUT std_logic_vector (31 DOWNTO 0);
        Inst: OUT std_logic_vector (31 DOWNTO 0)
    );
END Processor;

ARCHITECTURE arch_Processor OF Processor IS
    
    COMPONENT FetchStage IS
        PORT (
            clk: IN std_logic;
            NextInstAdd: OUT std_logic_vector (31 DOWNTO 0);
            Inst: OUT std_logic_vector (31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT pipelineBuffer IS 
        PORT (  CLK: IN std_logic;
                input: IN std_logic_vector (63 DOWNTO 0);
                output: OUT std_logic_vector (63 DOWNTO 0)
                );
    END COMPONENT;
    

   
	SIGNAL s_NextInstAdd, s_Inst: std_logic_vector(31 downto 0);
    SIGNAL buffer_in, buffer_out: std_logic_vector (63 downto 0);
    SIGNAL state: std_logic := '0';
   

    BEGIN

        
        myFetchStage: FetchStage PORT MAP (clk, s_NextInstAdd, s_Inst);
        buffer_in <=  s_Inst & s_NextInstAdd;
        IFIDbuffer: pipelineBuffer GENERIC MAP (64) PORT MAP (clk, buffer_in, buffer_out);
        
        Inst <= buffer_out(63 downto 32);
        NextInstAdd <= buffer_out(31 downto 0);

END arch_Processor;
