library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;

entity XmitData is 

generic (
	constant NUM_LATCHES : integer range 0 to 1023 := 12; --how many data bits you want to transfer
	--constant NUM_BYTES : integer range 0 to 1023 := 6;  --number of bytes to xmit including tag length
	constant tag_length : integer range 0 to 1023 := 24 --number of bits of tag
);

	port(inputs : in STD_LOGIC_VECTOR((2*NUM_LATCHES + (tag_length - 1)) downto 0);  --Lots of data.
	     outputs : out STD_LOGIC_VECTOR(7 DOWNTO 0);  --Data to Transmitter
	     --write_ok : in STD_LOGIC;
	     write_done : out std_logic; --tells when write has finished
	     reset : in std_logic; --reset on high
	     write_start : in std_logic; --on '1', start sending
	     --XMIT STUFF
	     xmit_go : out std_logic;
	     xmit_done : in std_logic;
	     clk : in STD_LOGIC);
end XmitData;

--**************************************************************************--

architecture XD_Arch of XmitData is
 signal MODE : STD_LOGIC;
 signal OLDC : STD_LOGIC; --previous status (looking for edge)
 signal outval : STD_LOGIC_VECTOR(7 downto 0);
 signal Write_mode : STD_LOGIC := '0'; --do we write? (1 is yes, 0 is no)
 signal write_start_prev : std_logic; --temporary to hold previous write-start value (look for edge)
 signal spchar : std_logic; --special character to send? (1 yes, 0 no)
 signal tempin : std_logic_vector((2*NUM_LATCHES + (tag_length - 1)) downto 0);
 constant NUM_BYTES : integer range 0 to 1023 := (2*NUM_LATCHES + tag_length)/8;
 
begin
	
	outputs<=outval;	--outval sent to UART
	write_done <= not write_mode;
	
	PROCESS (clk) 
		variable loc : integer := 0;
		
	BEGIN  --If a change seen in 
		if(rising_edge(clk) and reset='1') then
			--do something resetty
			Write_start_prev<='0';
			loc := 0;
			tempin <= "000000000000000000000000000000000000000000000000";
			--write_done<='1'; --tell circuit that we're good to go
		elsif(rising_edge(clk) and write_start='1' and write_start_prev='0' and write_mode='0') then
			write_start_prev<='1'; --clear edge
			write_mode<='1'; --begin writing
			loc := 0;	--start from beginning
			--write_done<='0'; --Currently transmitting
			tempin<=inputs;
			--tempin <= "011000110100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010101000101010001010100010100110111001101110011011100110111";
		elsif(rising_edge(clk) and write_mode='1') then
			if(write_start_prev='1' and write_start='0') then
				write_start_prev<='0';
			end if;
			if(xmit_done='0' and OLDC='1') then
				OLDC<='0';
				xmit_go<='0';
				--SET OUTVAL TO BYTE TO SEND
				if(loc < NUM_BYTES) then
					outval <= tempin((2*NUM_LATCHES + (tag_length - 1)) downto (2*NUM_LATCHES + (tag_length - 8)));	--send the next byte off the top
					tempin((2*NUM_LATCHES + (tag_length - 1)) downto 8) <= tempin(((2*NUM_LATCHES + (tag_length - 8)) - 1) downto 0);	--shift the whole thing by 1 byte
				elsif (loc = NUM_BYTES) then	--all bytes in tempin have been xmitted
					outval<="00001010";
				else
					outval<="00001101"; --send newline
					write_mode<='0'; --stop writing
					--write_done<='1'; --Ok to transmit (Not sending atm)
				end if;
				loc := loc+1; --increment counter

				--DONE WITH SEND
			elsif (xmit_done='1' and OLDC='0') then 
				OLDC<='1';
				xmit_go<='1';
			end if;
		elsif(rising_edge(clk)) then
			if(write_start_prev='1' and write_start='0') then
				write_start_prev<='0';
			end if;
		end if;
	end process;
	--do more stuff	
end XD_Arch;
