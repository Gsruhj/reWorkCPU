library verilog;
use verilog.vl_types.all;
entity bubble is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MEMR_ID         : in     vl_logic;
        RT_ID           : in     vl_logic_vector(4 downto 0);
        RS_IF           : in     vl_logic_vector(4 downto 0);
        RT_IF           : in     vl_logic_vector(4 downto 0);
        STALL           : out    vl_logic
    );
end bubble;
