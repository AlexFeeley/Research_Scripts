library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;

entity ClockDownFPGA_out_clock is 
	port(sys_clk : out STD_LOGIC;
	     clk : in STD_LOGIC);
end ClockDownFPGA_out_clock;

--**************************************************************************--
--This brings the BAUD RATE to 115200
architecture CD_Arch of ClockDownFPGA_out_clock is
begin
	PROCESS (clk) 
		variable count : integer := 0;
	BEGIN
		if(rising_edge(clk)) then
			if(count<10) then --10
				sys_clk<='0';
				count:=count+1;
			else
				sys_clk<='1';
				count:=count+1;--must be commented for 25 MHz
				--count:=0;
			end if;
			if(count>19) then --20
				count:=0;
			end if;
		end if;
	end process;
	--do more stuff
	
end CD_Arch;
