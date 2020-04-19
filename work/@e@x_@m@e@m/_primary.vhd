library verilog;
use verilog.vl_types.all;
entity EX_MEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        EX_MEM_WR       : in     vl_logic;
        NPC_IN          : in     vl_logic_vector(31 downto 0);
        NPC_OUT         : out    vl_logic_vector(31 downto 0);
        ALU_C_IN        : in     vl_logic_vector(31 downto 0);
        ALU_C_OUT       : out    vl_logic_vector(31 downto 0);
        ZERO_IN         : in     vl_logic;
        ZERO_OUT        : out    vl_logic;
        jump_in         : in     vl_logic_vector(1 downto 0);
        jump_out        : out    vl_logic_vector(1 downto 0);
        RT_DATA_IN      : in     vl_logic_vector(31 downto 0);
        INSTR_iN        : in     vl_logic_vector(31 downto 0);
        INSTR_OUT       : out    vl_logic_vector(31 downto 0);
        RT_DATA_OUT     : out    vl_logic_vector(31 downto 0);
        reg_rd_in       : in     vl_logic_vector(4 downto 0);
        reg_rd_out      : out    vl_logic_vector(4 downto 0);
        Branch_IN       : in     vl_logic_vector(1 downto 0);
        Branch_OUT      : out    vl_logic_vector(1 downto 0);
        MEMR_IN         : in     vl_logic;
        MEMR_OUT        : out    vl_logic;
        MEMW_IN         : in     vl_logic;
        MEMW_OUT        : out    vl_logic;
        REGW_IN         : in     vl_logic;
        REGW_OUT        : out    vl_logic;
        MEM2R_IN        : in     vl_logic;
        MEM2R_OUT       : out    vl_logic;
        Flush           : in     vl_logic
    );
end EX_MEM;
