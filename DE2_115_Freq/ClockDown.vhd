library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;

entity ClockDown is 
	port(sys_clk : out STD_LOGIC;
	     clk : in STD_LOGIC);
end ClockDown;

--**************************************************************************--
--This brings the BAUD RATE to 115200
architecture CD_Arch of ClockDown is
begin
	PROCESS (clk) 
		variable count : integer := 0;
	BEGIN
		if(rising_edge(clk)) then
			if(count<13) then
				sys_clk<='0';
				count:=count+1;
			else
				sys_clk<='1';
				count:=count+1;
			end if;
			if(count>26) then
				count:=0;
			end if;
		end if;
	end process;
	--do more stuff
	
end CD_Arch;
