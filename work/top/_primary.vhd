library verilog;
use verilog.vl_types.all;
entity top is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        dataaddr        : out    vl_logic_vector(31 downto 0);
        writedata       : out    vl_logic_vector(31 downto 0);
        memwrite        : out    vl_logic;
        pc              : out    vl_logic_vector(31 downto 0);
        readdata        : out    vl_logic_vector(31 downto 0);
        instr           : out    vl_logic_vector(31 downto 0)
    );
end top;
