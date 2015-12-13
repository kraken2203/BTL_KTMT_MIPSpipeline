library verilog;
use verilog.vl_types.all;
entity HazardUnit is
    port(
        ForwardBE       : out    vl_logic_vector(1 downto 0);
        ForwardAE       : out    vl_logic_vector(1 downto 0);
        RegWriteM       : in     vl_logic;
        RegWriteW       : in     vl_logic;
        WriteRegM       : in     vl_logic_vector(4 downto 0);
        WriteRegW       : in     vl_logic_vector(4 downto 0);
        RsE             : in     vl_logic_vector(4 downto 0);
        RtE             : in     vl_logic_vector(4 downto 0);
        StallF          : out    vl_logic;
        StallD          : out    vl_logic;
        FlushE          : out    vl_logic;
        RsD             : in     vl_logic_vector(4 downto 0);
        RtD             : in     vl_logic_vector(4 downto 0);
        MemtoRegE       : in     vl_logic;
        ForwardAD       : out    vl_logic;
        ForwardBD       : out    vl_logic;
        BranchD         : in     vl_logic;
        RegWriteE       : in     vl_logic;
        WriteRegE       : in     vl_logic_vector(4 downto 0);
        MemtoRegM       : in     vl_logic;
        JumpD           : in     vl_logic
    );
end HazardUnit;
