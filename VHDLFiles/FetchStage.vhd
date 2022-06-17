Library ieee;
Use ieee.std_logic_1164.all;

Entity FetchStage IS
    PORT (
        clk: IN std_logic;
        PCsrc1, PCsrc2: IN std_logic;
        Mem_ReadData: IN std_logic_vector(31 downto 0);
        BranchAddressResult: IN std_logic_vector(19 downto 0);
        NextInstAdd: OUT std_logic_vector (19 DOWNTO 0);
        InstAdd: OUT std_logic_vector (19 DOWNTO 0)
    );
END FetchStage;

ARCHITECTURE arch_FetchStage OF FetchStage IS
    COMPONENT adder IS
        PORT(
            Op1: IN std_logic_vector (19 DOWNTO 0);
            Op2: IN std_logic_vector (19 downto 0);
            result: OUT std_logic_vector (19 downto 0)
            );
    END COMPONENT;
    COMPONENT PC IS
        PORT(
	    clk : IN std_logic;
            input: IN std_logic_vector (19 DOWNTO 0);
            output: OUT std_logic_vector (19 downto 0)
            );
    END COMPONENT;
    
    

	SIGNAL pc_In, pc_Out, adder_out: std_logic_vector(19 downto 0);
    

   

    BEGIN

        pcAdder: adder PORT MAP (X"00001", pc_Out, adder_out);
        myPC: PC PORT MAP (clk, pc_In,  pc_Out);
        NextInstAdd <= pc_In;
        InstAdd <= pc_Out(19 downto 0);
        pc_In <= Mem_ReadData when (PCsrc2 = '1') else
            BranchAddressResult when (PCsrc1 ='1' and PCsrc2 = '0') else
            adder_out;

        

END arch_FetchStage;
