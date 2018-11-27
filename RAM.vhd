
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
	generic (
		DATA_W, ADDR_W, SIZE : Integer
	);
	port (
		ADDR : in unsigned(ADDR_W-1 downto 0);
		DATA: inout std_logic_vector(DATA_W-1 downto 0);
		W: std_logic -- Act on positive front
	);
end RAM;

architecture RAM of RAM is
	subtype MY_DATA is std_logic_vector(DATA_W-1 downto 0);
	type MY_MEM is array (SIZE-1 downto 0) of MY_DATA;
	signal MEM : MY_MEM := (others => "0");
begin
	DATA <= MEM(to_integer(ADDR)) when W = '0';
	WriteProc: process (W)
	begin
		if (W = '1' and W'event and to_integer(ADDR) < SIZE) then
			MEM(to_integer(ADDR)) <= DATA;
		end if;
	end process;
end RAM;
