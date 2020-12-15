--Author: Nick Atkinson
--File: controller.vhd
--Entity: controller
--
--Description:  This entity controls the set_measurement entities.  It can be connected to multiple
--set_measurement entities.  The number of these entities is specified by NUM_SETMEAS.
--The only part of the code that must be changed is set_hex ports should be added for each additional
--set_measurement entity; the set_tag array must be increased to include ASCII tags for each additional
--entity.  
--Each set entity is polled; i.e. if the data_out is non-zero, then there is data to read.  
--The data is read into a queue, and an ascii tag is appended.  A separate process handles the 
--ASCII encoding and transmission.  It steps through and transmits each item in the queue, or 
--just waits for items to be written to the queue.


--Tag Reference: Changing the DC input conditions changes some of the SET measurement tags
--r	-	Ray's circuit in normal operation
--q	-	Ray's circuit in characterization mode
--m	-	Matt/Jon's min target
--p	-	Matt/Jon's point5 target
--f	-	Matt/Jon's 5 target
--s	-	Matt/Jon's std target
--t	-	Matt/Jon's strip target
--a	-	AND gates all with outputs of 0
--b	-	AND gates all with outputs of 1
--c	-	AND gate all with input of 0 (blocked)
--n	-	NAND gates (inverting)
--o	-	NAND gates all with inputs of 0 (blocked)
--x	-	XOR gates, inverting
--y	-	XOR gates, all with outputs of 1
--z	-	XOR gates, all with outputs of 0
--d	-	XNOR + INV gates, inverting
--e	-	XNOR + INV gates, all with outputs of 1
--g	-	XNOR + INV gates, all with outputs of 0
--i	-	Chain of isolated inverters
--j	-	Chain of inverters surrounded by dummy inverters with inputs of 0
--k	-	Chain of inverters surrounded by dummy inverters with inputs of 1


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;

entity main_controller is 

generic (
	constant NUM_SETMEAS : integer range 0 to 31 := 29;
	constant NUM_LATCHES : integer range 0 to 1023 := 12;
	constant tag_length : integer range 0 to 1023 := 24
);

port (

	sys_clk				:	in std_logic; --keep process sequential with 50MHz clock
	reset				:	in std_logic; --active low
	--dc_inputs		:	in std_logic_vector(7 downto 0); -- this identifies which circuit is active, and in what logic state

	--Ports for interfacing with XmitData (middle-man between controller and UART)
	send_data, test_out		:	out std_logic;  --send_data begins transmission
	data_block				:	out std_logic_vector((2*NUM_LATCHES + (tag_length -1)) downto 0); --data from SET measurement module
	tx_done					:	in std_logic; --handshake from XmitData

	--Ports for each SET measurement ckt controller
	--Must manually add these if necessary
	set_hex0		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex1		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex2		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex3		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex4		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex5        :   in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex6        :   in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex7        :   in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex8        :   in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex9		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex10		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex11		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex12		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex13		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex14		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex15		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex16		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex17		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex18		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex19		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex20		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	
	set_hex21		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex22		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex23		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex24		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex25		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	
	set_hex26		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex27		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_hex28		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);

--	set_hex21		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
	set_clear		: 	out std_logic --each of these bits is tied to a single SET measurment module
	
);
end main_controller;

architecture behavior of main_controller is

	type hex_array is array((NUM_SETMEAS - 1) downto 0) of std_logic_vector((NUM_LATCHES - 1) downto 0); --array of data for each set_measurement entity
	type data_array is array(63 downto 0) of std_logic_vector((NUM_LATCHES + (tag_length-1)) downto 0); --queue of data to send --2 bit tag
	type tag_array is array(0 to 28) of std_logic_vector((tag_length-1) downto 0); --array of ASCII code tags for each SET
	type ascii_lut is array(15 downto 0) of std_logic_vector(7 downto 0);	--table used to convert hex value to corresponding ASCII char
	type state_type is (ready, encoding, transfer, xmitting, waiting);	--states for xmit_SET process
	signal set_hex_sig : hex_array; --this is the indexable version of the SET hex
	constant delay_val : integer := 0500000000; --delay time contrls been data reads
	signal delay_time : integer range 0 to delay_val;
	signal delay_trig : std_logic;
--	constant time_val : integer := 4095;
--	signal time_time : std_logic_vector((NUM_LATCHES - 1) downto 0); -- time stored as number of delay counts
	
	constant set_tag : tag_array := ("001100000011000000101101", "001100000011000100101101", "001100000011001000101101", "001100000011001100101101", 
		"001100000011010000101101", "001100000011010100101101", --changed first val to FF
		"001100000011011000101101", "001100000011011100101101", "001100000011100000101101", "001100000011100100101101", 
		"001100010011000000101101", "001100010011000100101101", 
		"001100010011001000101101", "001100010011001100101101", "001100010011010000101101", 
		"001100010011010100101101", "001100010011011000101101", 
		"001100010011011100101101", "001100010011100000101101", "001100010011100100101101", 
		"001100100011000000101101", "001100100011000100101101", 
		"001100100011001000101101", "001100100011001100101101","001100100011010000101101",
		"001100100011010100101101", "001100100011011000101101",
		"001100100011011100101101", "001100100011100000101101");
		
		--, "001100100011100100101101"
		--Each entry is an ASCII tag for a measurement ckt
		
	constant hex_to_ascii : ascii_lut := ("01000110", "01000101", "01000100", "01000011", "01000010",
		"01000001", "00111001", "00111000", "00110111", "00110110", "00110101", "00110100", "00110011",
		"00110010", "00110001", "00110000" );	--each entry is ASCII char, corresponds to index value
	
	signal data_buf : std_logic_vector((NUM_LATCHES + (tag_length-1)) downto 0); --most-sig byte contains ascii encoding of tag, 10 lower bytes are raw data
	signal encode_buf : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal encoded : std_logic_vector((2*NUM_LATCHES + (tag_length-1)) downto 0); --ASCII-encoded data w/ tag
	signal queue : data_array;  --this queue is used if more data is available than can be xmitted
	--signal queue : std_logic_vector((NUM_LATCHES + 7) downto 0);
	signal top, bottom : integer range 0 to 63 := 63;  --indices of queue
--		--top = location of next item to xmit
--		--bottom = location to place next item in queue
--		--if top = bottom, then nothing in queue
	signal state : state_type := ready;
--		--state = ready --> ready to accept data to xmit
--		--state = xmitting --> just received data, currently xmitting
	signal test : std_logic := '0';
	signal data_ready, data_sent : std_logic := '0';
	signal set_index : integer range 0 to 2*NUM_SETMEAS := 0;	--indexes for SET entities	 
	signal i_minus_3 : integer range 0 to 2*NUM_SETMEAS := 1;
	signal reading : integer range 0 to 127 := 0; --sort of a counter to ensure data is read from SET measurment module correctly

begin
	
	--this simply assigns the input ports to indexable signals
	set_hex_sig(0) <= set_hex0;
	set_hex_sig(1) <= set_hex1;
	set_hex_sig(2) <= set_hex2;
	set_hex_sig(3) <= set_hex3;
	set_hex_sig(4) <= set_hex4;
	set_hex_sig(5) <= set_hex5;
	set_hex_sig(6) <= set_hex6;
	set_hex_sig(7) <= set_hex7;
	set_hex_sig(8) <= set_hex8;
	set_hex_sig(9) <= set_hex9;
	set_hex_sig(10) <= set_hex10;
	set_hex_sig(11) <= set_hex11;
	set_hex_sig(12) <= set_hex12;
	set_hex_sig(13) <= set_hex13;
	set_hex_sig(14) <= set_hex14;
	set_hex_sig(15) <= set_hex15;
	set_hex_sig(16) <= set_hex16;
	set_hex_sig(17) <= set_hex17;
	set_hex_sig(18) <= set_hex18;
	set_hex_sig(19) <= set_hex19;
	set_hex_sig(20) <= set_hex20;
--	set_hex_sig(21) <= set_hex21;
	
	set_hex_sig(21) <= set_hex21;
	set_hex_sig(22) <= set_hex22;
	set_hex_sig(23) <= set_hex23;
	set_hex_sig(24) <= set_hex24;
	set_hex_sig(25) <= set_hex25;
	
	set_hex_sig(26) <= set_hex26;
	set_hex_sig(27) <= set_hex27;
   set_hex_sig(28) <= set_hex28;
	
	test_out <= test;
	

	poll_SET: --synchronously checks all SET entities for SET pulsewidth data
	process(sys_clk, delay_trig) is 
			
	begin 
		if(sys_clk'event and sys_clk = '1') then	--each clock cycle checks a single SET entity
			if (reset = '0') then
				set_index <= 0; --point to first circui to poll
				bottom <= 63; --point to bottom of stack, will lose data present in the stack
				--top <= 63;
				reading <= 0; --idle state, waiting to poll
				set_clear <= '1'; --turn off reset signal, active low to other circuits
			--if (set_hex_sig(set_index) /= "00000000000000000000000000000000000000000000000000000000000000000000000000000000" or reading > 0) then 
			--always grab counter value
			else
				if (delay_trig = '1' or reading > 0) then --delay time between poll has passed or currently polling circuits
				--pulsewidth data is available
				--read raw data into buffer, append tag to top of vector
					if (reading = 0) then --set set_index to 0 and move to polling state on next cycle
						set_index <= 0;	
						reading <= 1;						
					elsif (reading = 1 and (set_index >= 0 and set_index <= 28)) then --poll next circuit and place in buffer	
						--if (set_index = 0 or (set_index > 2 and set_index < 7) ) then
						queue(bottom) <= set_tag(set_index) & set_hex_sig(set_index);	--read it in, may require 2 clock cycles					
						if (bottom = 0) then		--move bottom down (wraps around), queue operation
							bottom <= 63;			--changing bottom actually signals to other process that data is available for xmission
						else
							bottom <= bottom - 1;
						end if;	
						set_index <= set_index + 1;
						
	--					if(set_index > 20) then --reset set_index and move on to clear counters	
	--						reading <= 2;
	--						set_index <= 0;
	--					end if;
					elsif (reading = 1 and (set_index < 0 or set_index > 28)) then --set_index out of range, go to reset state
						reading <= 2;
						set_index <= 0;
					elsif (reading = 2) then --reset counters after reading all
						reading <= 3; --reset counters
						set_clear <= '0';	--tell SET entity to clear out buffer, this stays high for 3 clock cycles
					elsif (reading >= 6) then --wait a few cyles before deasserting reset
						reading <= 0;
						set_clear <= '1';
						--update the set_index, i.e. which SET entity is polled		
	--					if set_index = (NUM_SETMEAS - 1) then
	--						set_index <= 0;
	--					else
	--						set_index <= set_index + 1;
	--					end if;
					else
						reading <= reading + 1;
					end if; --if reading = 0
				end if; --if delay_trig =1 and reading >0
			end if; --if reset = 0
		end if; --rising edge sys_clk
				
	end process; 

	
	xmit_SET: --synchronously checks all SET entities for SET pulsewidth data
	process(sys_clk) is 
		variable count : integer range 0 to 1000000000 := 0; --used to slow down some ops for XmitData
		variable send_mode : std_logic := '0';   --ensures handshaking between controller and XmitData
		variable ascii_step, data_step : integer range -15 to 255 := 0; --used for ASCII translation
		variable int_index : integer range 0 to 1023; --used for ASCII translation
	begin 
		if(sys_clk'event and sys_clk = '1') then	--each clock cycle checks a single SET entity
			if (reset = '0') then
				state <= ready;
				count := 0;
				top <= 63;
			else
				case state is
				when ready => 
				
					if ( top /= bottom ) then
					--Data is present in queue when top and bottom are at different positions
					
							data_buf <= queue(top); --read off top of queue
							count := 0;
							state <= encoding;
						
					end if;
				
				when encoding =>
				--	if (count < 1) then
						--data_buf is encoded by referencing array of ASCII values
						encoded((2*NUM_LATCHES + (tag_length-1)) downto (2*NUM_LATCHES)) <= data_buf((NUM_LATCHES + (tag_length-1)) downto NUM_LATCHES); --put ascii tag into encoded since already in ascii
						--encoded(39 downto 24) <= data_buf(27 downto 12)
						ascii_step := (2*NUM_LATCHES - 1);
						--ascii_step = 23
						data_step := (NUM_LATCHES - 1);
						--data_step = 11
						while (data_step > 0) loop
							int_index := to_integer(unsigned(data_buf(data_step downto (data_step - 3))));
							--1st loop int_index <= data_buf(11 downto 8)
							encoded(ascii_step  downto (ascii_step - 7)) <= hex_to_ascii(int_index);
							--1st loop encoded(23 downto 16) <= hex_to_ascii
							ascii_step := ascii_step - 8;
							--1st loop 15
							data_step := data_step - 4;	
							--1st loop 7				
						end loop;
					--	count := count + 1;
					--else
						test <= not test;		--used for debugging, nothing more
						state <= transfer;	
				--		count := 0;
				--	end if;
				
				when transfer =>
				--	if (count < 1) then
						--now the encoded value is actually transferred to module output (sent to XmitData)
						data_block <= encoded;
						
					--	count := count + 1;
					--else
						send_mode := '1';
						send_data <= '1';
						state <= xmitting;	
					--end if;			
					
				when xmitting =>
					--wait until tx_done goes high from XmitData (must go low first during xmission)
					if (tx_done = '0' and send_mode = '1') then
						send_mode := '0';
					elsif (tx_done = '1' and send_mode = '0') then
						send_data <= '0';
						count := 0;
						
						if (top = 0) then
							top <= 63;
						else
							top <= top - 1;
						end if;
						
						state <= waiting;
					end if;
							
						
				when waiting =>
					--this waits for 100 clock cycles, to make sure that the XmitData module is ready (running at slower clock)
					if (count = 100) then
						state <= ready;
						count := 0;
					else
						count := count + 1;
					end if;
				
				end case;
			end if; -- if reset =0
		end if; -- if rising edge sys_clk
	end process; 
	
	--delay_timer count
	process(sys_clk)
	
	begin
		if(rising_edge(sys_clk)) then
			if(reset = '0') then
				delay_time <= 0;
				delay_trig <= '0';
			else
				if(delay_time = delay_val) then
					delay_time <= 0;
					delay_trig <= '1';
				elsif(delay_time < 5) then
					delay_trig <= '0';
					delay_time <= delay_time + 1;
				else
					delay_time <= delay_time + 1;
				end if; --if delay_time = delay_val
			end if; --if reset=0
		end if; --if rising edge sys_clk
end process;

--timer: --keeps track of time, increments each hour
--process(delay_trig, sys_clk)
--	variable mins : integer range 0 to 59 := 0;
--	begin
--	if(rising_edge(sys_clk)) then
--		if(reset = '0') then
--			mins := 0;
--			time_time <= "000000000000";
--		end if; --if reset
--	else
--		if(rising_edge(delay_trig) and mins < 59) then
--			mins := mins + 1;
--		if(rising_edge(delay_trig
--		else
--			mins := mins + 1;
--		end if; --if rising edge delay trig
--	end if; --rising edge sys clk
--end process;
			
	
end behavior;