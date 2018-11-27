
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM2 is
	generic (
		DATA_W, ADDR_W, SIZE : Integer
	);
	port (
		RADDR, WADDR : in unsigned(ADDR_W-1 downto 0);
		RDATA : out std_logic_vector(DATA_W-1 downto 0);
		WDATA : in std_logic_vector(DATA_W-1 downto 0);
		CLK: in std_logic -- Act on positive front
	);
end RAM2;

architecture RAM2 of RAM2 is
	subtype MY_DATA is std_logic_vector(DATA_W-1 downto 0);
	type MY_MEM is array (SIZE-1 downto 0) of MY_DATA;
	signal MEM : MY_MEM := (others => (others => '0'));
begin
	RDATA <= MEM(to_integer(RADDR)) when (to_integer(RADDR) < SIZE) else (others => '1');
	WriteProc: process (CLK)
	begin
		if (CLK = '1' and CLK'event and to_integer(WADDR) < SIZE) then
			MEM(to_integer(WADDR)) <= WDATA;
		end if;
	end process;
end RAM2;
