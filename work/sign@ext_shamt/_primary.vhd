library verilog;
use verilog.vl_types.all;
entity signExt_shamt is
    port(
        shamt           : in     vl_logic_vector(4 downto 0);
        shamt_out       : out    vl_logic_vector(31 downto 0)
    );
end signExt_shamt;
