
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--
-- True ISA
--
-- 0x20 ADD
-- 0x24 AND
-- 0x25 OR
-- 0x00 COPYB (SLL)
-- 0x2A SLT (LESS)
-- 0x02 SRL
-- 0x26 XOR
--

--
-- This ISA
--
-- 0 COPYB
-- 1 AND
-- 2 OR
-- 3 XOR
-- 4 LT
-- 5 NOTB
-- 6 NEG
--
-- While SHIFT is the shift amount
-- (in 2 complement) applied to B
-- before operation
--

entity ALU is
	generic (
		N : Integer
	);
	port (
		A, B : in signed(N-1 downto 0);
		S : out signed(N-1 downto 0);
		SHIFT : in signed(5 downto 0);
		OP : in std_logic_vector(2 downto 0)
	);
end ALU;

architecture ALU of ALU is
  signal T : signed(N-1 downto 0);
begin
	T <= shift_left(B, to_integer(SHIFT)) when SHIFT >= 0 else shift_right(B, to_integer(-SHIFT));
	with OP select
		S <=
			T	when "000",
			A and T	when "001",
			A or T	when "010",
			A xor T	when "011",
			A - T	when "100",
			not T	when "101",
			-T	when "110",
			T	when others;
end ALU;
