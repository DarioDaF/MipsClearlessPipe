
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg is
	generic (
		DATA_W : Integer
	);
	port (
		RDATA : out std_logic_vector(DATA_W-1 downto 0);
		WDATA : in std_logic_vector(DATA_W-1 downto 0);
		W : in std_logic;
		CLK: in std_logic -- Act on positive front
	);
end Reg;

architecture Reg of Reg is
	subtype MY_DATA is std_logic_vector(DATA_W-1 downto 0);
	signal MEM : MY_DATA;
begin
	RDATA <= MEM;
	WriteProc: process (CLK)
	begin
		if (W = '1' and CLK = '1' and CLK'event) then
			MEM <= WDATA;
		end if;
	end process;
end Reg;
