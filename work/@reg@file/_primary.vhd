library verilog;
use verilog.vl_types.all;
entity RegFile is
    port(
        RA1             : in     vl_logic_vector(4 downto 0);
        RA2             : in     vl_logic_vector(4 downto 0);
        WA              : in     vl_logic_vector(4 downto 0);
        WE              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        WD              : in     vl_logic;
        RD1             : out    vl_logic_vector(31 downto 0);
        RD2             : out    vl_logic_vector(31 downto 0)
    );
end RegFile;
