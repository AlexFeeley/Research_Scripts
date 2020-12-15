library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count_12bit is
	port
	(
		clk		: in std_logic;
		reset	: in std_logic; --active low
		enable 	: in std_logic; --active high
		q		: out integer range 0 to 4095
	);
end entity;

architecture rtl of count_12bit is
begin
	process (clk)
		variable   cnt	: integer range 0 to 4095;
	begin
		if (rising_edge(clk)) then
			if reset = '0' then
				-- Reset the counter to 0
				cnt := 0;
			elsif enable = '1' then
				-- Increment the counter if counting is enabled
				cnt := cnt + 1;
			end if;
		end if;
		
		-- Output the current count
		q <= cnt;
	end process;

end rtl;
