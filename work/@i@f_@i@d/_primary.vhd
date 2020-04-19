library verilog;
use verilog.vl_types.all;
entity IF_ID is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IF_ID_WR        : in     vl_logic;
        PC_PLUS4_IN     : in     vl_logic_vector(31 downto 0);
        PC_PLUS4_OUT    : out    vl_logic_vector(31 downto 0);
        INSTR_IN        : in     vl_logic_vector(31 downto 0);
        INSTR_OUT       : out    vl_logic_vector(31 downto 0);
        Flush           : in     vl_logic
    );
end IF_ID;
