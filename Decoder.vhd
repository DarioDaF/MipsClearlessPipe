
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder is
	generic (
		SIZE : Integer
	);
	port (
		ADDR : in unsigned(SIZE-1 downto 0);
		RESULT : out std_logic_vector(SIZE**2 downto 0);
		EN : in std_logic
	);
end Decoder;

architecture Decoder of Decoder is
begin
	RESULT <= (to_integer(ADDR) => EN, others => '0');
end Decoder;
