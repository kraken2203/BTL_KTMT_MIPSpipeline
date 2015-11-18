library verilog;
use verilog.vl_types.all;
entity SignEx is
    port(
        X               : in     vl_logic_vector(15 downto 0);
        Y               : out    vl_logic_vector(31 downto 0)
    );
end SignEx;
