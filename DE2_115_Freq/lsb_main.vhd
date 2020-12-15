library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity lsb_main is
	generic
	(
	constant NUM_CIRCUITS : integer range 0 to 31 := 29;
	constant NUM_LATCHES : integer range 0 to 1023 := 12;
	constant tag_length : integer range 0 to 1023 := 24
	);

	port
	(
		-- Input ports
		reset	: in  std_logic; --reset all vhdl counters
		sys_clk : in std_logic; --fpga_oscillator clk input
		serial_in : in std_logic;
		--counter_in	: in  std_logic_vector((NUM_CIRCUITS - 1) downto 0); --data lsb from test chip will connect here
		counter_in0	: std_logic;
		counter_in1	: std_logic;
		counter_in2	: std_logic;
		counter_in3	: std_logic;
		counter_in4	: std_logic;
		counter_in5	: std_logic;
		counter_in6	: std_logic;
		counter_in7	: std_logic;
		counter_in8	: std_logic;
		counter_in9	: std_logic;
		counter_in10	: std_logic;
		counter_in11	: std_logic;
		counter_in12	: std_logic;
		counter_in13	: std_logic;
		counter_in14	: std_logic;
		counter_in15	: std_logic;
		counter_in16	: std_logic;
		counter_in17	: std_logic;
		counter_in18	: std_logic;
		counter_in19	: std_logic;
		counter_in20	: std_logic;
		
		counter_in21	: std_logic;
		counter_in22	: std_logic;
		counter_in23	: std_logic;
		counter_in24	: std_logic;
		counter_in25	: std_logic;
		
		counter_in26	: std_logic;
		counter_in27	: std_logic;
		counter_in28	: std_logic;
		
		-- Output ports
		serial_out : out std_logic
	);
end lsb_main;


architecture behave of lsb_main is

--	type int_array is array((NUM_CIRCUITS - 1) downto 0) of std_logic_vector((NUM_LATCHES - 1) downto 0);
--	signal cnt_wire : int_array;
	signal cnt_wire0 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire1 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire2 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire3 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire4 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire5 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire6 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire7 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire8 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire9 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire10 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire11 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire12 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire13 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire14 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire15 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire16 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire17 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire18 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire19 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	signal cnt_wire20 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	
	signal cnt_wire21 : std_logic_vector((NUM_LATCHES - 1) downto 0);
    signal cnt_wire22 : std_logic_vector((NUM_LATCHES - 1) downto 0);
 	signal cnt_wire23 : std_logic_vector((NUM_LATCHES - 1) downto 0);
    signal cnt_wire24 : std_logic_vector((NUM_LATCHES - 1) downto 0);
    signal cnt_wire25 : std_logic_vector((NUM_LATCHES - 1) downto 0);
    
    signal cnt_wire26 : std_logic_vector((NUM_LATCHES - 1) downto 0);
    signal cnt_wire27 : std_logic_vector((NUM_LATCHES - 1) downto 0);
	 signal cnt_wire28 : std_logic_vector((NUM_LATCHES - 1) downto 0);



	signal reset_wire, reset_main : std_logic;
	signal XmitData_done, XmitData_en, u_xmit_en, u_xmit_done : std_logic;
	signal slow_clk : std_logic;
	signal ctrl_data : std_logic_vector((2*NUM_LATCHES + (tag_length -1)) downto 0);
	signal ascii_tx, ascii_rx : std_logic_vector(7 downto 0);
	signal global_reset, rstset : std_logic;
	signal u_rec_ready : std_logic;
	
	component lsb_counter
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
			
	
			counter_out1 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			-- Output ports; --array of 12 bit counter outputs
			counter_out2 : out std_logic_vector((NUM_LATCHES - 1) downto 0); --counters count up to 4095
			counter_out3 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out4 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out5 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out6 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out7 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out8 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out9 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out10 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out11 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out12 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out13 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out14 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out15 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out16 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out17 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out18 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out19 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out20 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out21 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
	
			counter_out22 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out23 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out24 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out25 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out26 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			
			counter_out27 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out28 : out std_logic_vector((NUM_LATCHES - 1) downto 0);
			counter_out29 : out std_logic_vector((NUM_LATCHES - 1) downto 0)

		);
	end component;

	component main_controller
		generic (
			constant NUM_SETMEAS : integer range 0 to 31 := 29;
			constant NUM_LATCHES : integer range 0 to 1023 := 12;
			constant tag_length : integer range 0 to 1023 := 24
		);
		
		port (
		
			sys_clk				:	in std_logic; --keep process sequential with 50MHz clock
			--dc_inputs		:	in std_logic_vector(7 downto 0); -- this identifies which circuit is active, and in what logic state
		
			--Ports for interfacing with XmitData (middle-man between controller and UART)
			send_data, test_out		:	out std_logic;  --send_data begins transmission
			data_block				:	out std_logic_vector((2*NUM_LATCHES + (tag_length -1)) downto 0); --data from SET measurement module
			tx_done					:	in std_logic; --handshake from XmitData
			reset					:	in std_logic;
		
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

			

--			set_hex21		: 	in std_logic_vector((NUM_LATCHES - 1) downto 0);
			set_clear		: 	out std_logic --each of these bits is tied to a single SET measurment module
			
		);
	
	end component;

component XmitData
--This is the bridge between the main controller and the UART transmission module
--It receives a big parallel load of data and transmit byte-by-byte, adding carriage return and new line at the end
   port(inputs : in STD_LOGIC_VECTOR((2*NUM_LATCHES + (tag_length - 1)) downto 0);  --Lots of data.
        outputs : out STD_LOGIC_VECTOR(7 DOWNTO 0);  --Data to Transmitter
        write_done : out std_logic; --tells when write has finished
        reset : in std_logic; --reset on high
        write_start : in std_logic; --on '1', start sending
        --XMIT STUFF
        xmit_go : out std_logic;
        xmit_done : in std_logic;
        clk : in STD_LOGIC);
end component;

component ClockDown
--This steps down the clock to 1.923MHz, for UART modules
   port(sys_clk : out STD_LOGIC;
        clk : in STD_LOGIC);
end component;

component u_xmit
--This is the uart transmitting module
   port(
	   sys_clk        : in std_logic;
	   sys_rst_l    : in std_logic;
	   uart_xmitH    : out std_logic;
	   xmitH        : in std_logic;
	   xmit_dataH    : in std_logic_vector(7 downto 0);
	   xmit_doneH    : out std_logic
   );
end component;

component u_rec
--This is the uart receiving module
   port(
	   sys_rst_l     : in std_logic;
	   sys_clk        : in std_logic;
	   uart_dataH    : in std_logic;
	   rec_dataH    : out std_logic_vector(7 downto 0);
	   rec_readyH    : out std_logic
   );
end component;



begin

global_reset <= not reset;

lsb_counter1 : lsb_counter 
	port map 
	(
		reset => reset_wire,
		sys_clk => sys_clk,
		counter_in(0) => counter_in0,
		counter_in(1) => counter_in1,
		counter_in(2) => counter_in2,
		counter_in(3) => counter_in3,
		counter_in(4) => counter_in4,
		counter_in(5) => counter_in5,
		counter_in(6) => counter_in6,
		counter_in(7) => counter_in7,
		counter_in(8) => counter_in8,
		counter_in(9) => counter_in9,
		counter_in(10) => counter_in10,
		counter_in(11) => counter_in11,
		counter_in(12) => counter_in12,
		counter_in(13) => counter_in13,
		counter_in(14) => counter_in14,
		counter_in(15) => counter_in15,
		counter_in(16) => counter_in16,
		counter_in(17) => counter_in17,
		counter_in(18) => counter_in18,
		counter_in(19) => counter_in19,
		counter_in(20) => counter_in20,
		
		counter_in(21) => counter_in21,
		counter_in(22) => counter_in22,
		counter_in(23) => counter_in23,
		counter_in(24) => counter_in24,
		counter_in(25) => counter_in25,
		
		counter_in(26) => counter_in26,
		counter_in(27) => counter_in27,
		counter_in(28) => counter_in28,

		
		counter_out1 => cnt_wire0,
		counter_out2 => cnt_wire1,
		counter_out3 => cnt_wire2,
		counter_out4 => cnt_wire3,
		counter_out5 => cnt_wire4,
		counter_out6 => cnt_wire5,
		counter_out7 => cnt_wire6,
		counter_out8 => cnt_wire7,
		counter_out9 => cnt_wire8,
		counter_out10 => cnt_wire9,
		counter_out11 => cnt_wire10,
		counter_out12 => cnt_wire11,
		counter_out13 => cnt_wire12,
		counter_out14 => cnt_wire13,
		counter_out15 => cnt_wire14,
		counter_out16 => cnt_wire15,
		counter_out17 => cnt_wire16,
		counter_out18 => cnt_wire17,
		counter_out19 => cnt_wire18,
		counter_out20 => cnt_wire19,
		counter_out21 => cnt_wire20,
		
		counter_out22 => cnt_wire21,
		counter_out23 => cnt_wire22,
		counter_out24 => cnt_wire23,
		counter_out25 => cnt_wire24,
		counter_out26 => cnt_wire25,
		
		counter_out27 => cnt_wire26,
		counter_out28 => cnt_wire27,
		counter_out29 => cnt_wire28

	);

main_controller1 : main_controller
	port map
	(
		sys_clk => sys_clk,
		data_block => ctrl_data,
		send_data => XmitData_en,
		tx_done => XmitData_done,
		set_clear => reset_main,
		reset => reset,
		set_hex0 => cnt_wire0,
		--set_hex0 => "000000000001",
		set_hex1 => cnt_wire1,
		--set_hex1 => "000000000010",
		set_hex2 => cnt_wire2,
		--set_hex2 => "000000000011",
		set_hex3 => cnt_wire3,
		--set_hex3 => "000000000100",
		set_hex4 => cnt_wire4,
		--set_hex4 => "000000000101",
		set_hex5 => cnt_wire5,
		--set_hex5 => "000000000110",
		set_hex6 => cnt_wire6,
		--set_hex6 => "000000000111",
		set_hex7 => cnt_wire7,
		--set_hex7 => "000000001000",
		set_hex8 => cnt_wire8,
		--set_hex8 => "000000001001",
		set_hex9 => cnt_wire9,
		--set_hex9 => "000000001010",
		set_hex10 => cnt_wire10,
		--set_hex10 => "000000001011",
		set_hex11 => cnt_wire11,
		--set_hex11 => "000000001100",
		set_hex12 => cnt_wire12,
		--set_hex12 => "000000001101",
		set_hex13 => cnt_wire13,
		--set_hex13 => "000000001110",
		set_hex14 => cnt_wire14,
		--set_hex14 => "000000001111",
		set_hex15 => cnt_wire15,
		--set_hex15 => "000000010000",
		set_hex16 => cnt_wire16,
		--set_hex16 => "000000010001",
		set_hex17 => cnt_wire17,
		--set_hex17 => "000000010010",
		set_hex18 => cnt_wire18,
		--set_hex18 => "000000010011",
		set_hex19 => cnt_wire19,
		--set_hex19 => "000000010100",
		set_hex20 => cnt_wire20,
		--set_hex20 => "000000010101"  
		
		set_hex21 => cnt_wire21,
		--set_hex20 => "000000010110"--22 in bin
		set_hex22 => cnt_wire22,
		--set_hex20 => "000000010111"--23 in bin
		set_hex23 => cnt_wire23,
		--set_hex20 => "000000011000"--24 in bin
		set_hex24 => cnt_wire24,
		--set_hex20 => "000000011001"--25 in bin
		set_hex25 => cnt_wire25,
		--set_hex20 => "000000011010"--26 in bin
		
		set_hex26 => cnt_wire26,
		--set_hex20 => "000000011011"--27 in bin
		
		set_hex27 => cnt_wire27,
		--set_hex20 => "000000011100"--28 in bin
		
		set_hex28 => cnt_wire28

	);

   uxd: XmitData port map (
       inputs => ctrl_data,
       outputs => ascii_tx,
       write_done => XmitData_done,
       reset => global_reset,
       write_start => XmitData_en,
       xmit_go => u_xmit_en,
       xmit_done => u_xmit_done,
       clk => slow_clk );
   
   uutx: u_xmit port map (
       sys_clk => slow_clk,
       sys_rst_l => not global_reset,
       uart_xmitH => serial_out,
       xmitH => u_xmit_en,
       xmit_dataH => ascii_tx,
       xmit_doneH => u_xmit_done);
       
   uurx: u_rec port map (
       sys_rst_l => not global_reset,    
       sys_clk    => slow_clk,    
       uart_dataH => serial_in,    
       rec_dataH => ascii_rx,    
       rec_readyH => u_rec_ready);    
   
   uslow: ClockDown port map (
       sys_clk => slow_clk,
       clk => sys_clk);

	
	reset_wire <= reset_main and reset;
	
end behave;
