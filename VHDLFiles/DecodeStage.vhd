Library ieee;
Use ieee.std_logic_1164.all;

Entity DecodeStage IS
    PORT (
        clk: IN std_logic;
        rst: IN std_logic;
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
END DecodeStage;

ARCHITECTURE arch_DecodeStage OF DecodeStage IS
    COMPONENT regfile is 
        generic (n : integer := 32);
        port(
            Clk,Rst : in std_logic;
            readreg1 : in std_logic_vector(2 downto 0);
            readreg2 : in std_logic_vector(2 downto 0);

            wrtreg : in std_logic_vector(2 downto 0);
            wrtdata : in std_logic_vector(31 downto 0);

            regwrite : in std_logic;
            IORead : in std_logic;

            ReadData1: out std_logic_vector (31 downto 0);
            ReadData2: out std_logic_vector (31 downto 0)
        );
    end COMPONENT;
    COMPONENT CONTROL IS
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
            PCsrc2 : out std_logic;

            MemIndex : out std_logic_vector(1 DOWNTO 0);
            UseMemIndex : out std_logic;

            MemtoReg : out std_logic;

            selectorforCALL : out std_logic;
            selectorforINT : out std_logic
        );
    END COMPONENT;
    COMPONENT SignExt is 
        port(

        bit16 : in std_logic_vector(15 downto 0);


        bitext: out std_logic_vector (31 downto 0)
        );
    end COMPONENT;
    
    


    
    SIGNAL IOR, IOW: std_logic;
   

    BEGIN

        myRegFile: regfile PORT MAP (CLK, rst => rst, readreg1 => Inst(10 DOWNTO 8),
                                            readreg2 => Inst(13 DOWNTO 11), 
                                            wrtreg => MEMWB_rDst, wrtdata => MEMWB_writeData,
                                            regwrite => MEMWB_regW, IORead => IOR, ReadData1 => ReadD1, ReadData2 => ReadD2);
        IFID_rSrc1 <= Inst(10 DOWNTO 8);
        IFID_rSrc2 <= Inst(13 DOWNTO 11);
        IFID_rDst <= Inst(7 DOWNTO 5);
        myCU: CONTROL PORT MAP (OpCode => Inst(4 DOWNTO 0), RegWrite => RegWrite, IOread => IOR, IOwrite => IOW,
                                    isBranch => isBranch, branchSrc => branchSrc,
                                    ALUoperation => ALUop, ALUsrc => ALUsrc,
                                    Push => push, Pop=> pop, MemRead => MemR, MemWrite => MemW,
                                    RTI => RTI, Ret => Ret, PCsrc2 => PCsrc2, MemIndex => MEMIndex,
                                     UseMemIndex => UseMemIndex, MemtoReg => MemToReg,
                                      selectorforCALL => selectorforCALL, selectorforINT => selectorforINT);
        mySignExt: SignExt PORT MAP (bit16 => Inst(29 DOWNTO 14), bitext => offset);
        
        

END arch_DecodeStage;

