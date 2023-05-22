
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity AdderTest is
	constant SIZE : Integer := 8;
end AdderTest;

architecture AdderTest of AdderTest is

component Adder is
	generic (
		N : Integer
	);
	port (
		A, B : in signed(N-1 downto 0);
		S : out signed(N-1 downto 0);
		DOSUB : in std_logic;
		OFW : out std_logic
	);
end component;

   signal A, B, S : signed(SIZE-1 downto 0);
   signal DOSUB, OFW : std_logic;

begin
   UUT: Adder
		generic map (N => SIZE)
		port map (A => A, B => B, S => S, DOSUB => DOSUB, OFW => OFW);

   process
   begin
      wait for 100 ns;	
		
		DOSUB <= '0';
		A <= "00101001";
		B <= "00000001";
		wait for 100 ns;
		assert (S = "00101010" and OFW = '0') report "Simple Sum" severity error;
		
		DOSUB <= '0';
		A <= "01000001";
		B <= "01111111";
		wait for 100 ns;
		assert (S = "11000000" and OFW = '1') report "Overflow Sum" severity error;
		
		DOSUB <= '1';
		A <= "11111111";
		B <= "00000001";
		wait for 100 ns;
		assert (S = "11111110" and OFW = '0') report "Simple Sub" severity error;
		
		DOSUB <= '1';
		A <= "10000000";
		B <= "00000001";
		wait for 100 ns;
		assert (S = "01111111" and OFW = '1') report "Overflow Sub" severity error;
		
      wait;
   end process;

end AdderTest;
