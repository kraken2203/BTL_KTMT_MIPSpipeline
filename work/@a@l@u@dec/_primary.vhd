library verilog;
use verilog.vl_types.all;
entity ALUDec is
    port(
        Funct           : in     vl_logic_vector(5 downto 0);
        ALUOp           : in     vl_logic_vector(2 downto 0);
        ALUSelectShilfD : out    vl_logic;
        ALUCtrl         : out    vl_logic_vector(3 downto 0)
    );
end ALUDec;
