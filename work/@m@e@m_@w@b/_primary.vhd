library verilog;
use verilog.vl_types.all;
entity MEM_WB is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MEM_WB_WR       : in     vl_logic;
        ALU_C_IN        : in     vl_logic_vector(31 downto 0);
        ALU_C_OUT       : out    vl_logic_vector(31 downto 0);
        DM_DATA_IN      : in     vl_logic_vector(31 downto 0);
        DM_DATA_OUT     : out    vl_logic_vector(31 downto 0);
        reg_rd_in       : in     vl_logic_vector(4 downto 0);
        INSTR_iN        : in     vl_logic_vector(31 downto 0);
        INSTR_OUT       : out    vl_logic;
        reg_rd_out      : out    vl_logic_vector(4 downto 0);
        REGW_IN         : in     vl_logic;
        REGW_OUT        : out    vl_logic;
        MEM2R_IN        : in     vl_logic;
        MEM2R_OUT       : out    vl_logic
    );
end MEM_WB;
