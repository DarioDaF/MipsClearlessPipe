
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is
	generic (
		N : Integer := 2
	);
	port (
		A, B : in signed(N-1 downto 0);
		S : out signed(N-1 downto 0);
		DOSUB : in std_logic;
		OFW : out std_logic
	);
end Adder;

architecture Adder of Adder is
  signal TMP : signed(N downto 0);
begin
	TMP <=
		(A(N-1) & A) + (B(N-1) & B) when DOSUB = '0' else
		(A(N-1) & A) - (B(N-1) & B);
	S <= TMP(N-1 downto 0);
	OFW <= TMP(N) xor TMP(N-1);
end Adder;
