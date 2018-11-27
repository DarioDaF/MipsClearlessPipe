
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter is
	generic (
		DATA_W : Integer
	);
	port (
		RDATA : out unsigned(DATA_W-1 downto 0);
		WDATA : in unsigned(DATA_W-1 downto 0);
		W : in std_logic;
		CLK: in std_logic -- Act on positive front
	);
end Counter;

architecture Counter of Counter is
	subtype MY_DATA is unsigned(DATA_W-1 downto 0);
	signal MEM : MY_DATA;
begin
	RDATA <= MEM;
	WriteProc: process (CLK)
	begin
		if (CLK = '1' and CLK'event) then
			if (W = '1') then
				MEM <= WDATA;
			else
				MEM <= MEM + 1;
			end if;
		end if;
	end process;
end Counter;
