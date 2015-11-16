library verilog;
use verilog.vl_types.all;
entity MUX4_1 is
    generic(
        N               : integer := 32
    );
    port(
        M0              : in     vl_logic_vector;
        M1              : in     vl_logic_vector;
        M2              : in     vl_logic_vector;
        M3              : in     vl_logic_vector;
        S               : in     vl_logic_vector(1 downto 0);
        Y               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end MUX4_1;
