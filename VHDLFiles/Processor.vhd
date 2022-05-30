Library ieee;
Use ieee.std_logic_1164.all;

Entity Processor IS
    PORT (
        clk, RST: IN std_logic;
        NextInstAdd: OUT std_logic_vector (31 DOWNTO 0);
        Inst: OUT std_logic_vector (31 DOWNTO 0)
    );
END Processor;

ARCHITECTURE arch_Processor OF Processor IS
    
    COMPONENT FetchStage IS
        PORT (
            clk: IN std_logic;
        PCsrc1, PCsrc2: IN std_logic;
        Mem_ReadData: IN std_logic_vector(31 downto 0);
        BranchAddressResult: IN std_logic_vector(19 downto 0);
        NextInstAdd: OUT std_logic_vector (31 DOWNTO 0);
        InstAdd: OUT std_logic_vector (31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT pipelineBuffer IS 
        Generic ( n : Integer:=64);

        PORT (  CLK: IN std_logic;
                input: IN std_logic_vector (N-1 DOWNTO 0);
                output: OUT std_logic_vector (N-1 DOWNTO 0)
                );
    END COMPONENT;
    COMPONENT DecodeStage IS
        PORT (
            clk: IN std_logic;
            Inst: IN std_logic_vector (31 DOWNTO 0);
            MEMWB_rDst, MEMWB_rSrc1: IN std_logic_vector (2 DOWNTO 0);
            MEMWB_writeData: IN std_logic_vector (31 DOWNTO 0);
            MEMWB_regW: IN std_logic;
            ReadD1, ReadD2, offset: OUT std_logic_vector (31 DOWNTO 0);
            IFID_rSrc1, IFID_rSrc2, IFID_rDst: OUT std_logic_vector (2 DOWNTO 0);
            ALUop: OUT std_logic_vector (2 DOWNTO 0);
            BranchSrc: OUT std_logic_vector (1 DOWNTO 0);
            isBranch, ALUsrc, MemToReg, RegWrite, Push, Pop, MemR, MemW, RTI, RET,  PCsrc2, UseMemIndex, selectorforCALL, selectorforINT: OUT std_logic;
            MemIndex: OUT std_logic_vector (1 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT EXEstage IS
        PORT(
            clk : IN std_logic;
            isBranch: IN std_logic;
            BranchSrc: IN std_logic_vector(1 downto 0);

            ALUsrc : IN std_logic;
            ALUOperation : IN std_logic_vector (2 DOWNTO 0);

            NextInstAddress : IN std_logic_vector (19 DOWNTO 0);
            ReadData1 : IN std_logic_vector (31 DOWNTO 0);
            ReadData2 : IN std_logic_vector (31 DOWNTO 0);
            SignExtend : IN std_logic_vector (31 DOWNTO 0);

            ALUresult : OUT std_logic_vector (31 DOWNTO 0);
            Flags : OUT std_logic_vector (2 DOWNTO 0);
            Rsrc1Val : OUT std_logic_vector (31 DOWNTO 0);
            BranchAddressResult : OUT std_logic_vector (19 DOWNTO 0);
            PCsrc1: OUT std_logic

        );
    END COMPONENT;
    
    COMPONENT MEMstage IS
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
    END COMPONENT;

    COMPONENT WBstage IS
        PORT(
            MemToReg: IN std_logic;
            ReadDfromMem, aluResult: IN std_logic_vector (31 downto 0);
            WBresult: OUT std_logic_vector (31 downto 0)
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
            ReadData : OUT std_logic_vector(31 DOWNTO 0);
            ReadPCData : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    

    SIGNAL s_InstAdd: std_logic_vector (31 downto 0);
	SIGNAL s_NextInstAdd, s_Inst, s_RD1, s_RD2, s_offset: std_logic_vector(31 downto 0);
    SIGNAL s_IFID_rSrc1, s_IFID_rSrc2, s_IFID_rDst, s_ALUop: std_logic_vector(2 DOWNTO 0);
    SIGNAL s_BranchSrc, s_MemIndex: std_logic_vector (1 DOWNTO 0);
    SIGNAL s_isBranch, s_ALUsrc, s_MemToReg, s_RegWrite, s_Push, s_Pop, s_MemR, s_MemW,
             s_RTI, s_RET, s_PCsrc1, s_PCsrc2, s_UseMemIndex, s_selectorforCALL, s_selectorforINT: std_logic;
    SIGNAL IFID_buffer_in, IFID_buffer_out: std_logic_vector (63 downto 0);
    SIGNAL IDEX_buffer_in, IDEX_buffer_out: std_logic_vector (157 downto 0);
    SIGNAL s_ALUresult, s_rSrc1Val: std_logic_vector (31 DOWNTO 0);
    Signal s_Flags: std_logic_vector(2 DOWNTO 0);
    SIGNAL s_BranchAddressResult: std_logic_vector (19 DOWNTO 0);
    SIGNAL EXMEM_buffer_in, EXMEM_buffer_out: std_logic_vector (118 DOWNTO 0);
    SIGNAL s_WBresult, s_RDFM, MEMWB_ALUResult, MEM_ALUResult: std_logic_vector(31 downto 0);
    SIGNAL s_sp_address, s_address: std_logic_vector(19 downto 0);
    SIGNAL MEM_writeData, MEM_readData: std_logic_vector(31 downto 0);
    SIGNAL MEMWB_buffer_in, MEMWB_buffer_OUT: std_logic_vector (71 DOWNTO 0);
    BEGIN

        
        myFetchStage: FetchStage PORT MAP (clk, s_PCsrc1, s_PCsrc2, MEM_readData, s_BranchAddressResult, s_NextInstAdd, s_InstAdd);
        myMem: Memory PORT MAP (clk , MemWrite => EXMEM_buffer_out(110), MemRead => EXMEM_buffer_out(109),
                                Push => EXMEM_buffer_out(107), Pop => EXMEM_buffer_out(108),
                                address => s_address, PCAddress => s_InstAdd(19 DOWNTO 0), SPAddress => s_sp_address,
                                WriteData => MEM_writeData, ReadData => MEM_readData, ReadPCData => s_Inst);
        IFID_buffer_in <=  s_Inst & s_NextInstAdd;
        IFIDbuffer: pipelineBuffer GENERIC MAP (64) PORT MAP (clk, IFID_buffer_in, IFID_buffer_out);
        Inst <= IFID_buffer_in(63 downto 32);
        NextInstAdd <= IFID_buffer_out(31 downto 0);

        myDecodeStage: DecodeStage PORT MAP (clk, IFID_buffer_out(63 downto 32),
                                             MEMWB_buffer_out(4 downto 2), MEMWB_buffer_out(7 downto 5), 
                                             s_WBresult,
                                             MEMWB_buffer_out(1),
                                             s_RD1, s_RD2, s_offset, 
                                             s_IFID_rSrc1, s_IFID_rSrc2,s_IFID_rDst,
                                             s_ALUop,  s_BranchSrc, s_isBranch, s_ALUsrc,
                                             s_MemToReg, s_RegWrite, s_Push, s_Pop, s_MemR, s_MemW,
                                             s_RTI, s_RET,  s_PCsrc2, s_UseMemIndex,
                                             s_selectorforCALL, s_selectorforINT, s_MemIndex);
        IDEX_buffer_in <= IFID_buffer_out (31 downto 0)                                           
                                    & s_RD1 & s_RD2 & s_offset &                                  
                                        s_IFID_rSrc1 & s_IFID_rSrc2 & s_IFID_rDst &               
                                        s_ALUop &  s_BranchSrc & s_isBranch & s_ALUsrc &            
                                        s_MemToReg & s_RegWrite & s_Push & s_Pop & s_MemR & s_MemW &
                                        s_RTI & s_RET &  s_PCsrc2 & s_UseMemIndex & 
                                        s_selectorforCALL & s_selectorforINT & s_MemIndex;
        IDEXbuffer: pipelineBuffer GENERIC MAP (158) PORT MAP (clk, IDEX_buffer_in, IDEX_buffer_out);
        myEXEstage: EXEstage PORT MAP (clk => CLK, isBranch => s_isBranch, BranchSrc => s_BranchSrc,  ALUsrc => IDEX_buffer_out(143), 
                    ALUOperation => IDEX_buffer_out(139 DOWNTO 137), NextInstAddress => IDEX_buffer_out(19 DOWNTO 0),
                    ReadData1 => IDEX_buffer_out(63 DOWNTO 32), ReadData2 => IDEX_buffer_out(95 DOWNTO 64),
                    SignExtend => IDEX_buffer_out(127 DOWNTO 96),  ALUresult => s_ALUresult,
                    Flags => s_Flags, Rsrc1Val => s_rSrc1Val,
                    BranchAddressResult => s_BranchAddressResult, PCsrc1 => s_PCsrc1);
        EXMEM_buffer_in <= IDEX_buffer_out (31 DOWNTO 0) &
                                s_ALUresult & s_Flags & s_rSrc1Val &
                                IDEX_buffer_out(130 DOWNTO 128) & IDEX_buffer_out(136 DOWNTO 134) &
                                 IDEX_buffer_out (157 DOWNTO 144);
        EXMEMbuffer: pipelineBuffer GENERIC MAP (119) PORT MAP (clk, EXMEM_buffer_in, EXMEM_buffer_out);
        myMEMstage: MEMstage Port MAP (clk, rst, Rsrc1Val => EXMEM_buffer_out(98 DOWNTO 67),
                                        ALUresult_in => EXMEM_buffer_out(63 DOWNTO 32), ALUflags => EXMEM_buffer_out(66 DOWNTO 64),
                                        NextInstAddress => EXMEM_buffer_out(19 DOWNTO 0), ALUresult_out => MEM_ALUResult,
                                        Push => EXMEM_buffer_out(107), Pop => EXMEM_buffer_out(108), UseMemIndex => ExMEM_Buffer_out(114),
                                        MemIndex => EXMEM_buffer_out(118 downto 117), selectorForCall => EXMEM_buffer_out(115),
                                        selectorForINT => EXMEM_buffer_out(116), sp_address => s_sp_address,
                                        address => s_address, writeData => MEM_writeData);


        MEMWB_buffer_in <= EXMEM_buffer_in(105) & EXMEM_buffer_out(106) &
                         EXMEM_buffer_out(104 downto 102) & EXMEM_buffer_out(101 downto 99) & MEM_readData & MEM_ALUResult;
        MEMWBbuffer: pipelineBuffer GENERIC MAP (72) PORT MAP (clk, MEMWB_buffer_in, MEMWB_buffer_out);
        myWBstage: WBstage PORT MAP(MEMWB_buffer_out(0), MEMWB_buffer_out(39 DOWNTO 8) , MEMWB_buffer_out(71 DOWNTO 40), s_WBresult);

        

END arch_Processor;
