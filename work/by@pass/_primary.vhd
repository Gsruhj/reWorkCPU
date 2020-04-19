library verilog;
use verilog.vl_types.all;
entity byPass is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        RD_EX           : in     vl_logic_vector(4 downto 0);
        RS_ID           : in     vl_logic_vector(4 downto 0);
        RT_ID           : in     vl_logic_vector(4 downto 0);
        RD_MEM          : in     vl_logic_vector(4 downto 0);
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0);
        Alusrc          : in     vl_logic;
        rt              : in     vl_logic_vector(4 downto 0);
        instr_if        : in     vl_logic_vector(31 downto 0);
        ForwardC        : out    vl_logic
    );
end byPass;
