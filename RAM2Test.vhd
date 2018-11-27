
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

entity RAM2Test is
	constant DATA_W : Integer := 8;
	constant ADDR_W : Integer := 8;
	constant MEM_SIZE : Integer := 2**(ADDR_W - 2);
end RAM2Test;

architecture RAM2Test of RAM2Test is
	subtype MY_DATA is std_logic_vector(DATA_W-1 downto 0);
   signal RADDR, WADDR : unsigned(ADDR_W-1 downto 0);
	signal RDATA : MY_DATA;
	signal WDATA : MY_DATA;
	signal CLK: std_logic;
begin
   UUT: entity RAM2
		generic map (DATA_W => DATA_W, ADDR_W => ADDR_W, SIZE => MEM_SIZE)
		port map (RADDR => RADDR, WADDR => WADDR, RDATA => RDATA, WDATA => WDATA, CLK => CLK);

   process
   begin
		CLK <= '0';
      wait for 100 ns;	
		
		WADDR <= "00000000";
		WDATA <= "10101010";
		wait for 50 ns;
		CLK <= '1';
		wait for 50 ns;
		CLK <= '0';
		
		WADDR <= "00000001";
		WDATA <= "01010101";
		RADDR <= "00000000";
		wait for 50 ns;
		CLK <= '1';
		wait for 50 ns;
		CLK <= '0';
		assert (RDATA = "10101010") report "Addr 0 reading failed" severity error;
		
		WADDR <= "11111111"; -- Out of bounds write
		RADDR <= "00000001";
		wait for 50 ns;
		CLK <= '1';
		wait for 50 ns;
		CLK <= '0';
		assert (RDATA = "01010101") report "Addr 1 reading failed" severity error;
		
      wait;
   end process;

end RAM2Test;
