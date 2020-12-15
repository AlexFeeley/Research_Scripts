library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lsb_counter is
	generic
	(
	constant NUM_CIRCUITS : integer range 0 to 31 := 29;
	constant NUM_LATCHES : integer range 0 to 1023 := 12
	);

	port
	(
		-- Input ports
		reset	: in  std_logic; --reset all vhdl counters
		sys_clk : in std_logic; --fpga_oscillator clk input
		counter_in	: in  std_logic_vector((NUM_CIRCUITS - 1) downto 0); --data lsb from test chip will connect here
		

		-- Output ports
		counter_out1 : out std_logic_vector(11 downto 0); --array of 11 downto 0 bit counter outputs
		counter_out2 : out std_logic_vector(11 downto 0); --counters count up to 4095
		counter_out3 : out std_logic_vector(11 downto 0);
		counter_out4 : out std_logic_vector(11 downto 0);
		counter_out5 : out std_logic_vector(11 downto 0);
		counter_out6 : out std_logic_vector(11 downto 0);
		counter_out7 : out std_logic_vector(11 downto 0);
		counter_out8 : out std_logic_vector(11 downto 0);
		counter_out9 : out std_logic_vector(11 downto 0);
		counter_out10 : out std_logic_vector(11 downto 0);
		counter_out11 : out std_logic_vector(11 downto 0);
		counter_out12 : out std_logic_vector(11 downto 0);
		counter_out13 : out std_logic_vector(11 downto 0);
		counter_out14 : out std_logic_vector(11 downto 0);
		counter_out15 : out std_logic_vector(11 downto 0);
		counter_out16 : out std_logic_vector(11 downto 0);
		counter_out17 : out std_logic_vector(11 downto 0);
		counter_out18 : out std_logic_vector(11 downto 0);
		counter_out19 : out std_logic_vector(11 downto 0);
		counter_out20 : out std_logic_vector(11 downto 0);
		counter_out21 : out std_logic_vector(11 downto 0);
		
		counter_out22 : out std_logic_vector(11 downto 0);
		counter_out23 : out std_logic_vector(11 downto 0);
		counter_out24 : out std_logic_vector(11 downto 0);
		counter_out25 : out std_logic_vector(11 downto 0);
		counter_out26 : out std_logic_vector(11 downto 0);
		
		counter_out27 : out std_logic_vector(11 downto 0);
		counter_out28 : out std_logic_vector(11 downto 0);
		counter_out29 : out std_logic_vector(11 downto 0)

		
	);
end lsb_counter;


architecture behave of lsb_counter is

	signal trigger	: std_logic_vector((NUM_CIRCUITS - 1) downto 0); -- input to counter module to trigger count

	component count_12bit
		port
		(
			clk		: in std_logic;
			reset	: in std_logic; --active high
			enable 	: in std_logic; --active high
			q		: out std_logic_vector(11 downto 0)
		);
	end component;

begin

	count1 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(0),
			q => counter_out1
		);
	
	count2 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(1),
			q => counter_out2
		);
		
	count3 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(2),
			q => counter_out3
		);
		
	count4 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(3),
			q => counter_out4
		);
		
	count5 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(4),
			q => counter_out5
		);
		
	count6 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(5),
			q => counter_out6
		);
		
	count7 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(6),
			q => counter_out7
		);
		
	count8 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(7),
			q => counter_out8
		);
		
	count9 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(8),
			q => counter_out9
		);
		
	count10 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(9),
			q => counter_out10
		);
		
	count11 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(10),
			q => counter_out11
		);
		
	count12 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(11),
			q => counter_out12
		);	
		
	count13 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(12),
			q => counter_out13
		);
		
	count14 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(13),
			q => counter_out14
		);
		
	count15 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(14),
			q => counter_out15
		);
		
	count16 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(15),
			q => counter_out16
		);
		
	count17 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable =>  trigger(16),
			q => counter_out17
		);
		
	count18 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(17),
			q => counter_out18
		);
		
	count19 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(18),
			q => counter_out19
		);
		
	count20 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(19),
			q => counter_out20
		);
		
	count21 : count_12bit 
		port map 
		(
			clk => sys_clk,
			reset => reset,
			enable => trigger(20),
			q => counter_out21
		);
		
	count22 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(21),
		q => counter_out22
	);
	
	count23 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(22),
		q => counter_out23
	);
	
	count24 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(23),
		q => counter_out24
	);
	
	count25 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(24),
		q => counter_out25
	);

	count26 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(25),
		q => counter_out26
	);
	
	count27 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(26),
		q => counter_out27
	);
	
	count28 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(27),
		q => counter_out28
	);
	
	count29 : count_12bit 
	port map 
	(
		clk => sys_clk,
		reset => reset,
		enable => trigger(28),
		q => counter_out29
	);
	
	counter1:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(0);
					trigger(0) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(0)) then
					lsb_prev := counter_in(0);
					trigger(0) <= '1';
					count := 2; 
				elsif(trigger(0) = '1') then
					lsb_prev := counter_in(0);
					trigger(0) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process; 
		
	
	counter2:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(1);
					trigger(1) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(1)) then
					lsb_prev := counter_in(1);
					trigger(1) <= '1';
					count := 2; 
				elsif(trigger(1) = '1') then
					lsb_prev := counter_in(1);
					trigger(1) <= '0';
				else
					count := count - 1; --decrement counter
				end if;
			end if;
		end process;
	
	counter3:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(2);
					trigger(2) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(2)) then
					lsb_prev := counter_in(2);
					trigger(2) <= '1';
					count := 2; 
				elsif(trigger(2) = '1') then
					lsb_prev := counter_in(2);
					trigger(2) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter4:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(3);
					trigger(3) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(3)) then
					lsb_prev := counter_in(3);
					trigger(3) <= '1';
					count := 2; 
				elsif(trigger(3) = '1') then
					lsb_prev := counter_in(3);
					trigger(3) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter5:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(4);
					trigger(4) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(4)) then
					lsb_prev := counter_in(4);
					trigger(4) <= '1';
					count := 2; 
				elsif(trigger(4) = '1') then
					lsb_prev := counter_in(4);
					trigger(4) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter6:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(5);
					trigger(5) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(5)) then
					lsb_prev := counter_in(5);
					trigger(5) <= '1';
					count := 2; 
				elsif(trigger(5) = '1') then
					lsb_prev := counter_in(5);
					trigger(5) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter7:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(6);
					trigger(6) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(6)) then
					lsb_prev := counter_in(6);
					trigger(6) <= '1';
					count := 2; 
				elsif(trigger(6) = '1') then
					lsb_prev := counter_in(6);
					trigger(6) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter8:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(7);
					trigger(7) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(7)) then
					lsb_prev := counter_in(7);
					trigger(7) <= '1';
					count := 2; 
				elsif(trigger(7) = '1') then
					lsb_prev := counter_in(7);
					trigger(7) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter9:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(8);
					trigger(8) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(8)) then
					lsb_prev := counter_in(8);
					trigger(8) <= '1';
					count := 2; 
				elsif(trigger(8) = '1') then
					lsb_prev := counter_in(8);
					trigger(8) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter10:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(9);
					trigger(9) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(9)) then
					lsb_prev := counter_in(9);
					trigger(9) <= '1';
					count := 2; 
				elsif(trigger(9) = '1') then
					lsb_prev := counter_in(9);
					trigger(9) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter11:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(10);
					trigger(10) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(10)) then
					lsb_prev := counter_in(10);
					trigger(10) <= '1';
					count := 2; 
				elsif(trigger(10) = '1') then
					lsb_prev := counter_in(10);
					trigger(10) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter12:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(11);
					trigger(11) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(11)) then
					lsb_prev := counter_in(11);
					trigger(11) <= '1';
					count := 2; 
				elsif(trigger(11) = '1') then
					lsb_prev := counter_in(11);
					trigger(11) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter13:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(12);
					trigger(12) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(12)) then
					lsb_prev := counter_in(12);
					trigger(12) <= '1';
					count := 2; 
				elsif(trigger(12) = '1') then
					lsb_prev := counter_in(12);
					trigger(12) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter14:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(13);
					trigger(13) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(13)) then
					lsb_prev := counter_in(13);
					trigger(13) <= '1';
					count := 2; 
				elsif(trigger(13) = '1') then
					lsb_prev := counter_in(13);
					trigger(13) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter15:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(14);
					trigger(14) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(14)) then
					lsb_prev := counter_in(14);
					trigger(14) <= '1';
					count := 2; 
				elsif(trigger(14) = '1') then
					lsb_prev := counter_in(14);
					trigger(14) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter16:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(15);
					trigger(15) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(15)) then
					lsb_prev := counter_in(15);
					trigger(15) <= '1';
					count := 2; 
				elsif(trigger(15) = '1') then
					lsb_prev := counter_in(15);
					trigger(15) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter17:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(16);
					trigger(16) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(16)) then
					lsb_prev := counter_in(16);
					trigger(16) <= '1';
					count := 2; 
				elsif(trigger(16) = '1') then
					lsb_prev := counter_in(16);
					trigger(16) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter18:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(17);
					trigger(17) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(17)) then
					lsb_prev := counter_in(17);
					trigger(17) <= '1';
					count := 2; 
				elsif(trigger(17) = '1') then
					lsb_prev := counter_in(17);
					trigger(17) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter19:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(18);
					trigger(18) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(18)) then
					lsb_prev := counter_in(18);
					trigger(18) <= '1';
					count := 2; 
				elsif(trigger(18) = '1') then
					lsb_prev := counter_in(18);
					trigger(18) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter20:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(19);
					trigger(19) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(19)) then
					lsb_prev := counter_in(19);
					trigger(19) <= '1';
					count := 2; 
				elsif(trigger(19) = '1') then
					lsb_prev := counter_in(19);
					trigger(19) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
	counter21:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(20);
					trigger(20) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(20)) then
					lsb_prev := counter_in(20);
					trigger(20) <= '1';
					count := 2; 
				elsif(trigger(20) = '1') then
					lsb_prev := counter_in(20);
					trigger(20) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
	
	counter22:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(21);
					trigger(21) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(21)) then
					lsb_prev := counter_in(21);
					trigger(21) <= '1';
					count := 2; 
				elsif(trigger(21) = '1') then
					lsb_prev := counter_in(21);
					trigger(21) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;

	counter23:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(22);
					trigger(22) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(22)) then
					lsb_prev := counter_in(22);
					trigger(22) <= '1';
					count := 2; 
				elsif(trigger(22) = '1') then
					lsb_prev := counter_in(22);
					trigger(22) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;

	counter24:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(23);
					trigger(23) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(23)) then
					lsb_prev := counter_in(23);
					trigger(23) <= '1';
					count := 2; 
				elsif(trigger(23) = '1') then
					lsb_prev := counter_in(23);
					trigger(23) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;

	counter25:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(24);
					trigger(24) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(24)) then
					lsb_prev := counter_in(24);
					trigger(24) <= '1';
					count := 2; 
				elsif(trigger(24) = '1') then
					lsb_prev := counter_in(24);
					trigger(24) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;

	counter26:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(25);
					trigger(25) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(25)) then
					lsb_prev := counter_in(25);
					trigger(25) <= '1';
					count := 2; 
				elsif(trigger(25) = '1') then
					lsb_prev := counter_in(25);
					trigger(25) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;

counter27:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(26);
					trigger(26) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(26)) then
					lsb_prev := counter_in(26);
					trigger(26) <= '1';
					count := 2; 
				elsif(trigger(26) = '1') then
					lsb_prev := counter_in(26);
					trigger(26) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;


counter28:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(27);
					trigger(27) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(27)) then
					lsb_prev := counter_in(27);
					trigger(27) <= '1';
					count := 2; 
				elsif(trigger(27) = '1') then
					lsb_prev := counter_in(27);
					trigger(27) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;
		
counter29:
		process(sys_clk, reset) is 
			 variable count : integer range 0 to 2; --count to make sure signal settles; 1 = 20ns
			 variable lsb_prev : std_logic;
		begin 
			if (rising_edge(sys_clk)) then
				if(reset = '0') then
					lsb_prev := counter_in(28);
					trigger(28) <= '0';
					count := 0;
				elsif(count = 0 and lsb_prev /= counter_in(28)) then
					lsb_prev := counter_in(28);
					trigger(28) <= '1';
					count := 2; 
				elsif(trigger(28) = '1') then
					lsb_prev := counter_in(28);
					trigger(28) <= '0';
				else
					if(count > 0) then
						count := count - 1; --decrement counter
					end if;
				end if;
			end if;
		end process;



end behave;

