library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use ieee.std_logic_unsigned.all;

entity input_control is 

	port(	dip			:	in std_logic_vector(7 downto 0);
			byte_in		:	in std_logic_vector(7 downto 0);
			clk			:	in std_logic;
			data_ready	:	in std_logic;
			ctrl_byte	:	out std_logic_vector(7 downto 0);
			trigger		:	out std_logic_vector(8 downto 0)
	);
			
end input_control;

--**************************************************************************--
architecture CD_Arch of input_control is

	type state_type is (idle, reading, clearing);
	signal state : state_type := idle;
	signal ascii_in : std_logic_vector(7 downto 0);
	signal ready_prev : std_logic := '0';
	signal ctrl : std_logic_vector(7 downto 0) := "00000000";
	
begin

	ctrl_byte <= ctrl;

	process(clk, byte_in, data_ready)
		variable count : integer range 0 to 100000000 := 0;
	begin
		
		if (clk'event and clk = '1') then
	
			case state is
			when idle =>
				if (data_ready = '1' and ready_prev = '0') then
					ascii_in <= byte_in;
					ready_prev <= '1';
					state <= reading;
					count := 0;
					if ((byte_in > "00101111" and byte_in < "00111010") or byte_in = "01110010" or byte_in = "01110011") then
						ctrl <= byte_in;
					--else
					--	ctrl <= ctrl;
					end if;					
				elsif (data_ready = '0' and ready_prev = '1') then
					ready_prev <= '0';
					state <= idle;
					--ctrl <= ctrl;
				else
					state <= idle;
					--ctrl <= ctrl;
				end if;

			when reading =>
			
				ctrl <= ctrl;
			
				if (count < 100) then
					count := count + 1;
					state <= reading;
				else
					ascii_in <= "00000000";
					count := 0;
					state <= clearing;
				end if;

			when clearing =>
			
				ctrl <= ctrl;
				state <= idle;
			
			end case;
			
		end if;

	end process;


	process(state, ascii_in)
	begin
	
		case state is 
		when idle =>
			trigger <= "000000000";
		when reading =>
			trigger(0) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (not ascii_in(3)) and (not ascii_in(2)) and (not ascii_in(1)) and (ascii_in(0));
			trigger(1) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (not ascii_in(3)) and (not ascii_in(2)) and (ascii_in(1)) and (not ascii_in(0));
			trigger(2) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (not ascii_in(3)) and (not ascii_in(2)) and (ascii_in(1)) and (ascii_in(0));
			trigger(3) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (not ascii_in(3)) and (ascii_in(2)) and (not ascii_in(1)) and (not ascii_in(0));
			trigger(4) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (not ascii_in(3)) and (ascii_in(2)) and (not ascii_in(1)) and (ascii_in(0));
			trigger(5) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (not ascii_in(3)) and (ascii_in(2)) and (ascii_in(1)) and (not ascii_in(0));
			trigger(6) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (not ascii_in(3)) and (ascii_in(2)) and (ascii_in(1)) and (ascii_in(0));
			trigger(7) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (ascii_in(3)) and (not ascii_in(2)) and (not ascii_in(1)) and (not ascii_in(0));			
			trigger(8) <= (not ascii_in(7)) and (ascii_in(6)) and (ascii_in(5)) and (not ascii_in(4)) and (ascii_in(3)) and (not ascii_in(2)) and (not ascii_in(1)) and (ascii_in(0));			
		when clearing =>
			trigger <= "000000000";
		end case;

	end process;

	
end CD_Arch;
