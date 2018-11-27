
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity Regs is
	generic (
		DATA_W : Integer;
		REGS_BITS : Integer;
		ZERO_REG : Integer := 0
	);
	port (
		RADDR1 : in unsigned(REGS_BITS-1 downto 0);
		RADDR2 : in unsigned(REGS_BITS-1 downto 0);
		WADDR : in unsigned(REGS_BITS-1 downto 0);
		RDATA1 : out std_logic_vector(DATA_W-1 downto 0);
		RDATA2 : out std_logic_vector(DATA_W-1 downto 0);
		WDATA : in std_logic_vector(DATA_W-1 downto 0);
		W : in std_logic;
		CLK : in std_logic -- Act on positive front
	);
end Regs;

architecture Regs of Regs is
	subtype MY_DATA is std_logic_vector(DATA_W-1 downto 0);
	type MY_MEM is array (2**REGS_BITS downto ZERO_REG) of MY_DATA;
	signal REGS_OUT : MY_MEM;
	signal REGS_W : std_logic_vector(2**REGS_BITS downto 0);
begin
	RegsGenerate: for I in ZERO_REG to 2**REGS_BITS generate
		REGX: entity Reg generic map (DATA_W => DATA_W) port map (
			RDATA => REGS_OUT(I),
			WDATA => WDATA,
			W => REGS_W(I),
			CLK => CLK
		);
	end generate;

	RDATA1 <= REGS_OUT(to_integer(RADDR1));
	RDATA2 <= REGS_OUT(to_integer(RADDR2));
	WriteDecored: entity Decoder generic map (SIZE => REGS_BITS) port map(
		ADDR => WADDR,
		RESULT => REGS_W,
		EN => W
	);
	
	ZeroGenerate: for I in 0 to ZERO_REG-1 generate
		REGS_OUT(I) <= (others => '0');
	end generate;
end Regs;
