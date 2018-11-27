
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignExt is
	generic (
		N_IN, N_OUT : Integer
	);
	port (
		I : in signed(N_IN-1 downto 0);
		O : out signed(N_OUT-1 downto 0)
	);
end SignExt;

architecture SignExt of SignExt is
begin
	O(N_IN-1 downto 0) <= I;
	O(N_OUT-1 downto N_IN) <= (others => I(N_IN-1));
end SignExt;
