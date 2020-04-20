library verilog;
use verilog.vl_types.all;
entity Ctrl is
    port(
        RegDst          : out    vl_logic;
        Branch          : out    vl_logic_vector(1 downto 0);
        MemR            : out    vl_logic;
        Mem2R           : out    vl_logic;
        MemW            : out    vl_logic;
        RegW            : out    vl_logic;
        Alusrc          : out    vl_logic;
        EXTOp           : out    vl_logic_vector(1 downto 0);
        Aluctrl         : out    vl_logic_vector(4 downto 0);
        OpCode          : in     vl_logic_vector(31 downto 26);
        Funct           : in     vl_logic_vector(5 downto 0)
    );
end Ctrl;
