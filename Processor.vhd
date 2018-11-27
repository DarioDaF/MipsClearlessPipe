
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

-- Word length = 4 bytes
-- Address bus width = 4 bytes

entity Processor is
	port (
		RADDR, WADDR : out unsigned(31 downto 0);
		RINSTADDR : out unsigned(33 downto 0);
		RDATA, RINSTDATA : in std_logic_vector(31 downto 0);
		WDATA : out std_logic_vector(31 downto 0);
		CLK : in std_logic
	);
end Processor;

architecture Processor of Processor is
	-- IF
	signal PC, NEXT_PC, BRANCH_ADDR : unsigned(31 downto 0);
	signal DO_BRANCH : std_logic;
	-- ID
	signal ID_NEXT_PC : unsigned(31 downto 0);
	signal ID_INSTR : std_logic_vector(31 downto 0);
	signal OP : std_logic_vector(5 downto 0);
	signal RS, RT, RD : std_logic_vector(4 downto 0);
	signal IIMM : signed(15 downto 0);
	signal JIMM : signed(25 downto 0);
	signal RSHAMT : signed(5 downto 0);
	signal OPALU : std_logic_vector(2 downto 0);
begin

	PC_HW: process (CLK)
	begin
		if (CLK'event and CLK = '1') then
			if (DO_BRANCH = '1') then
				PC <= BRANCH_ADDR;
			else
				PC <= NEXT_PC;
			end if;
			NEXT_PC <= PC + 1;
		end if;
	end process;

	RINSTADDR(33 downto 2) <= PC;
	RINSTADDR(1 downto 0) <= (others => '0');

	-- IF/ID Pipe
	IF_ID: process (CLK)
	begin
		if (CLK'event and CLK = '1') then
			ID_NEXT_PC <= NEXT_PC;
			ID_INSTR <= RINSTDATA;
		end if;
	end process;

	-- Instruction decoder
	--   ALL
	OP <= ID_INSTR(31 downto 26);
	--   R and I
	RS <= ID_INSTR(25 downto 21);
	RT <= ID_INSTR(20 downto 16);
	OPALU <= ID_INSTR(2 downto 0) when OP = "000000" else ID_INSTR(28 downto 26);
	--   R
	RD <= ID_INSTR(15 downto 11);
	--   I
	IIMM <= signed(ID_INSTR(15 downto 0));
	--   J
	JIMM <= signed(ID_INSTR(25 downto 0));

end Processor;
