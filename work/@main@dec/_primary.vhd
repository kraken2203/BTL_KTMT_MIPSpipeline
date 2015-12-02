library verilog;
use verilog.vl_types.all;
entity MainDec is
    port(
        Op              : in     vl_logic_vector(5 downto 0);
        MemtoReg        : out    vl_logic;
        MemWrite        : out    vl_logic;
        Branch          : out    vl_logic;
        ALUSrc          : out    vl_logic;
        RegDst          : out    vl_logic;
        RegWrite        : out    vl_logic;
        ALUOp           : out    vl_logic_vector(1 downto 0)
    );
end MainDec;
