library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        N               : integer := 32
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        F               : in     vl_logic_vector(3 downto 0);
        Y               : out    vl_logic_vector;
        ZF              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end ALU;
