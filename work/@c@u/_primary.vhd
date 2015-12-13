library verilog;
use verilog.vl_types.all;
entity CU is
    port(
        Opcode          : in     vl_logic_vector(5 downto 0);
        Funct           : in     vl_logic_vector(5 downto 0);
        MemtoReg        : out    vl_logic;
        MemWrite        : out    vl_logic;
        Branch_beq      : out    vl_logic;
        Branch_bne      : out    vl_logic;
        ALUSrc          : out    vl_logic;
        RegDst          : out    vl_logic;
        RegWrite        : out    vl_logic;
        Jump            : out    vl_logic;
        BranchD         : out    vl_logic;
        ALUCtrl         : out    vl_logic_vector(3 downto 0)
    );
end CU;
