--VERSION1 Oct 10 2013 10am
--Nihaar M.
--This one works for 21 FFs nicely
--Note : ext data = SW[0]

--VERSION 2 Oct 11 11.30 am
--Nihaar M

--dipsw = "1000" - ledb7to0, ledg7to0, ledr4to0 connected to data 1 to 21
--dipsw = "0100" - ledb7to0, ledg7to0, ledr4to0 connected to clk 1 to 21
--dipsw = "0010" - ledb7to0, ledg7to0, ledr4to0 connected to sr 1 to 21
--ledr 5 and 6 always connected to setqsrff and setdata, respectively

library IEEE;
use  IEEE.STD_LOGIC_1164.all;
--use  IEEE.STD_LOGIC_ARITH.all;
use  IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;
--USE IEEE.NUMERIC_BIT.ALL;

entity dut_test_code is

	port
	(
		-- Input ports
		dip_sw	: in  std_logic_vector(3 downto 1);
		button	: in  std_logic_vector(3 downto 0);
		--hex0	: in std_logic_vector(6 downto 0);
		hex0dp : out std_logic;

		-- Inout ports
		--<name>	: inout <type>;

		-- Output ports
		ledb	: out std_logic_vector(7 downto 0);
		ledr	: out std_logic_vector(7 downto 0);
		ledg	: out std_logic_vector(7 downto 0);
		fpga_clk_out : out std_logic;
		fpga_clk_out_1 : out std_logic;
		fpga_clk_out_2 : out std_logic;
		pll_sezro : out std_logic;
		
		pll_sezro_constant : in std_logic; -- Select0RO
		pll_seoro_constant: in std_logic; -- Select1RO
		
		pll_seoro : out std_logic;
		pll_sezDB : out std_logic;
		pll_sezDB_constant : in std_logic;
		pll_seoDB : out std_logic;
		pll_seoDB_constant: in std_logic;
		ext_data_to_dut : out std_logic;
		ext_data_constant : in std_logic;
		ext_data_to_dutpattern: out std_logic;
		ext_datapattern_constant: in std_logic;
		ext_data_select : in std_logic_vector(3 downto 0); --0000 = use ext_data pin for constant data,
		 --0010 = use 1010 pattern,
		 --0100 = use 1100 pattern
		 --1000 = 1k of zero, 1k of 1 pattern

		osc_50 : in std_logic;

		pll_en_in : in std_logic;
		pll_en_out: out std_logic;

		set_inv_in :in std_logic;
		set_inv_out :out std_logic;
		set_lbs_in :in std_logic;
		set_lbs_out :out std_logic;

		ccrest_v1_xor1_in :in std_logic;
		ccrest_v1_xor1_out :out std_logic;
		ccrest_v1_xor2_in :in std_logic;
		ccrest_v1_xor2_out :out std_logic;
		ccrest_v2_xor1_in :in std_logic;
		ccrest_v2_xor1_out :out std_logic;
		ccrest_v2_xor2_in :in std_logic;
		ccrest_v2_xor2_out :out std_logic;

		--ccrest_v2_in :in std_logic;
		--ccrest_v2_out :out std_logic;

		ccrest_lbs_in :in std_logic;
		ccrest_lbs_out :out std_logic;
		ccrest_clr_in : in std_logic;
		ccrest_clr_out :out std_logic;

				--PLL inputs
		pll_od2_in :in std_logic;
		pll_od1_in :in std_logic;
		pll_od0_in :in std_logic;
		pll_r4_in :in std_logic;
		pll_r3_in :in std_logic;
		pll_r2_in :in std_logic;
		pll_r1_in :in std_logic;
		pll_r0_in :in std_logic;
		pll_f7_in :in std_logic;
		pll_f6_in :in std_logic;
		pll_f5_in :in std_logic;
		pll_f4_in :in std_logic;
		pll_f3_in :in std_logic;
		pll_f2_in :in std_logic;
		pll_f1_in :in std_logic;
		pll_f0_in :in std_logic;


		ccrest_a0_in :in std_logic;
		ccrest_a1_in :in std_logic;
		ccrest_a2_in :in std_logic;
		ccrest_a3_in :in std_logic;

		--pll outputs__
		pll_od2_out :out std_logic;
		pll_od1_out :out std_logic;
		pll_od0_out :out std_logic;
		pll_r4_out :out std_logic;
		pll_r3_out :out std_logic;
		pll_r2_out :out std_logic;
		pll_r1_out :out std_logic;
		pll_r0_out :out std_logic;
		pll_f7_out :out std_logic;
		pll_f6_out :out std_logic;
		pll_f5_out :out std_logic;
		pll_f4_out :out std_logic;
		pll_f3_out :out std_logic;
		pll_f2_out :out std_logic;
		pll_f1_out :out std_logic;
		pll_f0_out :out std_logic;

		ccrest_a0_out :out std_logic;
		ccrest_a1_out :out std_logic;
		ccrest_a2_out :out std_logic;
		ccrest_a3_out :out std_logic;

		ccrest_b0_in :in std_logic;
		ccrest_b1_in :in std_logic;
		ccrest_b2_in :in std_logic;
		ccrest_b3_in :in std_logic;

		ccrest_b0_out :out std_logic;
		ccrest_b1_out :out std_logic;
		ccrest_b2_out :out std_logic;
		ccrest_b3_out :out std_logic;

		crest_lbs_in :in std_logic;
		crest_lbs_out :out std_logic;
		crest_clr_in : in std_logic;
		crest_clr_out :out std_logic;

		dut_addr0_in :in std_logic;
		dut_addr1_in :in std_logic; --constant for now
		dut_addr2_in :in std_logic;
		dut_addr3_in :in std_logic;
		dut_addr4_in :in std_logic;
		dut_addr5_in :in std_logic;

		dut_addr0_out :out std_logic;
		dut_addr1_out :out std_logic;
		dut_addr2_out :out std_logic;
		dut_addr3_out :out std_logic;
		dut_addr4_out :out std_logic;
		dut_addr5_out :out std_logic;

		--pll controls
		pll_fbs2_in :in std_logic;
		pll_fbs1_in :in std_logic;  --rs0 = rs1 = 1
		pll_fbs0_in :in std_logic;
		pll_os2_in :in std_logic;
		pll_os1_in :in std_logic;
		pll_os0_in :in std_logic;

		pll_fbs2_out :out std_logic;
		pll_fbs1_out :out std_logic;
		pll_fbs0_out :out std_logic;
		pll_os2_out :out std_logic;
		pll_os1_out :out std_logic;
		pll_os0_out :out std_logic;
		
data_out1	: in std_logic;
data_out2	: in std_logic;
data_out3	: in std_logic;
data_out4	: in std_logic;
data_out5	: in std_logic;
data_out6	: in std_logic;
data_out7	: in std_logic;
data_out8	: in std_logic;
data_out9	: in std_logic;
data_out10	: in std_logic;
data_out11	: in std_logic;
data_out12	: in std_logic;
data_out13	: in std_logic;
data_out14	: in std_logic;
data_out15	: in std_logic;
data_out16	: in std_logic;
data_out17	: in std_logic;
data_out18	: in std_logic;
data_out19	: in std_logic;
data_out20	: in std_logic;
data_out21	: in std_logic;

data_out22	: in std_logic;
data_out23	: in std_logic;
data_out24	: in std_logic;
data_out25	: in std_logic;
data_out26	: in std_logic;

data_out27	: in std_logic;
data_out28	: in std_logic;
data_out29	: in std_logic;

clk_out1	: in std_logic;
clk_out2	: in std_logic;
clk_out3	: in std_logic;
clk_out4	: in std_logic;
clk_out5	: in std_logic;
clk_out6	: in std_logic;
clk_out7	: in std_logic;
clk_out8	: in std_logic;
clk_out9	: in std_logic;
clk_out10	: in std_logic;
clk_out11	: in std_logic;
clk_out12	: in std_logic;
clk_out13	: in std_logic;
clk_out14	: in std_logic;
clk_out15	: in std_logic;
clk_out16	: in std_logic;
clk_out17	: in std_logic;
clk_out18	: in std_logic;
clk_out19	: in std_logic;
clk_out20	: in std_logic;
clk_out21	: in std_logic;

clk_out22	: in std_logic;
clk_out23	: in std_logic;
clk_out24	: in std_logic;
clk_out25	: in std_logic;
clk_out26	: in std_logic;

clk_out27	: in std_logic;
clk_out28	: in std_logic;

sr_out1	: in std_logic;
sr_out2	: in std_logic;
sr_out3	: in std_logic;
sr_out4	: in std_logic;
sr_out5	: in std_logic;
sr_out6	: in std_logic;
sr_out7	: in std_logic;
sr_out8	: in std_logic;
sr_out9	: in std_logic;
sr_out10	: in std_logic;
sr_out11	: in std_logic;
sr_out12	: in std_logic;
sr_out13	: in std_logic;
sr_out14	: in std_logic;
sr_out15	: in std_logic;
sr_out16	: in std_logic;
sr_out17	: in std_logic;
sr_out18	: in std_logic;
sr_out19	: in std_logic;
sr_out20	: in std_logic;
sr_out21	: in std_logic;



sr_out22	: in std_logic;
sr_out23	: in std_logic;
sr_out24	: in std_logic;
sr_out25	: in std_logic;
sr_out26	: in std_logic;

sr_out27	: in std_logic;
sr_out28	: in std_logic;

data_lsb_out1	: out std_logic; -- signals to lsb counter
data_lsb_out2	: out std_logic;
data_lsb_out3	: out std_logic;
data_lsb_out4	: out std_logic;
data_lsb_out5	: out std_logic;
data_lsb_out6	: out std_logic;
data_lsb_out7	: out std_logic;
data_lsb_out8	: out std_logic;
data_lsb_out9	: out std_logic;
data_lsb_out10	: out std_logic;
data_lsb_out11	: out std_logic;
data_lsb_out12	: out std_logic;
data_lsb_out13	: out std_logic;
data_lsb_out14	: out std_logic;
data_lsb_out15	: out std_logic;
data_lsb_out16	: out std_logic;
data_lsb_out17	: out std_logic;
data_lsb_out18	: out std_logic;
data_lsb_out19	: out std_logic;
data_lsb_out20	: out std_logic;
data_lsb_out21	: out std_logic;

data_lsb_out22	: out std_logic;
data_lsb_out23	: out std_logic;
data_lsb_out24	: out std_logic;
data_lsb_out25	: out std_logic;
data_lsb_out26	: out std_logic;

data_lsb_out27	: out std_logic;
data_lsb_out28	: out std_logic;
data_lsb_out29	: out std_logic;


setqsrff	: in std_logic;
setdata 	: in std_logic

	);
end dut_test_code;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behave of dut_test_code is

	-- Declarations (optional)
	signal outReg: std_logic_vector(29 downto 1);
	signal reset: std_logic;
	signal en_data, en_clk, en_sr :std_logic;
	signal data_reg: std_logic_vector(29 downto 1);
	signal data : std_logic_vector(29 downto 1);
	signal clk : std_logic_vector(29 downto 1);
	signal sr : std_logic_vector(36 downto 1);

	signal data1010, data1100, data1k :std_logic;

	signal sys_clk : std_logic;

	signal button_press : std_logic;

	signal fpga_clk_prev: std_logic;

	component ClockDownFPGA_out_clock
	port(sys_clk : out STD_LOGIC;
	     clk : in STD_LOGIC);
	end component;


begin

clkDiv1 : ClockDownFPGA_out_clock
	port map
	(
		clk => osc_50,
		sys_clk => sys_clk
	);

reset <= button(0);

fpga_clk_out <= sys_clk;
fpga_clk_out_1 <= sys_clk;
fpga_clk_out_2 <= sys_clk;

data(	1	) <= data_out1	;
data(	2	) <= data_out2	;
data(	3	) <= data_out3	;
data(	4	) <= data_out4	;
data(	5	) <= data_out5	;
data(	6	) <= data_out6	;
data(	7	) <= data_out7	;
data(	8	) <= data_out8	;
data(	9	) <= data_out9	;
data(	10	) <= data_out10	;
data(	11	) <= data_out11	;
data(	12	) <= data_out12	;
data(	13	) <= data_out13	;
data(	14	) <= data_out14	;
data(	15	) <= data_out15	;
data(	16	) <= data_out16	;
data(	17	) <= data_out17	;
data(	18	) <= data_out18	;
data(	19	) <= data_out19	;
data(	20	) <= data_out20	;
data(	21	) <= data_out21	;

data(	22	) <= data_out22	;
data(	23	) <= data_out23	;
data(	24	) <= data_out24	;
data(	25	) <= data_out25	;
data(	26	) <= data_out26	;

data(	27	) <= data_out27	;
data(	28	) <= data_out28	;
data(	29	) <= data_out29	;


clk(	1	) <= clk_out1	;
clk(	2	) <= clk_out2	;
clk(	3	) <= clk_out3	;
clk(	4	) <= clk_out4	;
clk(	5	) <= clk_out5	;
clk(	6	) <= clk_out6	;
clk(	7	) <= clk_out7	;
clk(	8	) <= clk_out8	;
clk(	9	) <= clk_out9	;
clk(	10	) <= clk_out10	;
clk(	11	) <= clk_out11	;
clk(	12	) <= clk_out12	;
clk(	13	) <= clk_out13	;
clk(	14	) <= clk_out14	;
clk(	15	) <= clk_out15	;
clk(	16	) <= clk_out16	;
clk(	17	) <= clk_out17	;
clk(	18	) <= clk_out18	;
clk(	19	) <= clk_out19	;
clk(	20	) <= clk_out20	;
clk(	21	) <= clk_out21	;

clk(	22	) <= clk_out22	;
clk(	23	) <= clk_out23	;
clk(	24	) <= clk_out24	;
clk(	25	) <= clk_out25	;
clk(	26	) <= clk_out26	;

clk(	27	) <= clk_out27	;
clk(	28	) <= clk_out28	;

sr(	1	) <= sr_out1	;
sr(	2	) <= sr_out2	;
sr(	3	) <= sr_out3	;
sr(	4	) <= sr_out4	;
sr(	5	) <= sr_out5	;
sr(	6	) <= sr_out6	;
sr(	7	) <= sr_out7	;
sr(	8	) <= sr_out8	;
sr(	9	) <= sr_out9	;
sr(	10	) <= sr_out10	;
sr(	11	) <= sr_out11	;
sr(	12	) <= sr_out12	;
sr(	13	) <= sr_out13	;
sr(	14	) <= sr_out14	;
sr(	15	) <= sr_out15	;
sr(	16	) <= sr_out16	;
sr(	17	) <= sr_out17	;
sr(	18	) <= sr_out18	;
sr(	19	) <= sr_out19	;
sr(	20	) <= sr_out20	;
sr(	21	) <= sr_out21	;

sr(	22	) <= sr_out22	;
sr(	23	) <= sr_out23	;
sr(	24	) <= sr_out24	;
sr(	25	) <= sr_out25	;
sr(	26	) <= sr_out26	;

sr(	27	) <= sr_out27	;
sr(	28	) <= sr_out28	;


data_lsb_out1 <= data_out1	;
data_lsb_out2 <= data_out2	;
data_lsb_out3 <= data_out3	;
data_lsb_out4 <= data_out4	;
data_lsb_out5 <= data_out5	;
data_lsb_out6 <= data_out6	;
data_lsb_out7 <= data_out7	;
data_lsb_out8 <= data_out8	;
data_lsb_out9 <= data_out9	;
data_lsb_out10 <= data_out10	;
data_lsb_out11 <= data_out11	;
data_lsb_out12 <= data_out12	;
data_lsb_out13 <= data_out13	;
data_lsb_out14 <= data_out14	;
data_lsb_out15 <= data_out15	;
data_lsb_out16 <= data_out16	;
data_lsb_out17 <= data_out17	;
data_lsb_out18 <= data_out18	;
data_lsb_out19 <= data_out19	;
data_lsb_out20 <= data_out20	;
data_lsb_out21 <= data_out21	;

data_lsb_out22 <= data_out22	;
data_lsb_out23 <= data_out23	;
data_lsb_out24 <= data_out24	;
data_lsb_out25 <= data_out25	;
data_lsb_out26 <= data_out26	;

data_lsb_out27 <= data_out27	;
data_lsb_out28 <= data_out28	;
data_lsb_out29 <= data_out29	;



--data setup
select_data_blue: ledb <= "11111111";
select_data_green: ledg <= "00000000";
select_data_red: ledr(4 downto 0) <= "00000";

--set leds
ledr(5) <= not setqsrff;
ledr(6) <= not setdata;

-- Frequency of RO Setting
process (OSC_50)
variable counter : integer:= 0; -- Counter is equal to 0
begin
	if counter > 800000000 then
		counter := 0; 
	elsif rising_edge(OSC_50) then
		counter := counter + 1; 
	end if; 
	
	if counter < 200000000 then
		-- 00
		pll_sezro <= '0';
		pll_seoro <= '0';
	elsif counter < 400000000 then
		-- 01
		pll_sezro <= '0';
		pll_seoro <= '1';
	elsif counter < 600000000 then
		-- 11
		pll_sezro <= '1';
		pll_seoro <= '1';
	else
		-- 10
		pll_sezro <= '1';
		pll_seoro <= '0';
	end if; 
end process;
-- RO Changes Based on Switch Inputs
-- pll_sezro <= '0'; -- Select 0RO,  pll_sezro_constant
-- pll_seoro <= '0'; -- Select 1RO, pll_seoro_constant

pll_sezDB <= pll_sezDB_constant;
pll_seoDB <= pll_seoDB_constant;

--ext data select
ext_data_to_dut <= ext_data_constant; --INITIALLY NELSON had it as "not ext_data_constant";

ext_data_to_dutpattern <= ext_datapattern_constant;

ledr(7) <=
	not data1010 when ext_data_select=not "0010" else
	not data1100 when ext_data_select=not "0100" else
	not data1k when ext_data_select=not "1000" else
	ext_data_constant;

pll_en_out <= pll_en_in;

--set controls
set_inv_out <= set_inv_in;
set_lbs_out <= set_lbs_in;

--ccrest controls
ccrest_v1_xor1_out <= ccrest_v1_xor1_in;
ccrest_v1_xor2_out <= ccrest_v1_xor2_in;
ccrest_v2_xor1_out <= ccrest_v2_xor1_in;
ccrest_v2_xor2_out <= ccrest_v2_xor2_in;

--ccrest_v2_out <= ccrest_v2_in;

ccrest_lbs_out <= ccrest_lbs_in;
ccrest_clr_out <= ccrest_clr_in;

--pll inputs assignment
pll_od2_out <= pll_od2_in;
pll_od1_out <= pll_od1_in;
pll_od0_out <= pll_od0_in;
pll_r4_out <= pll_r4_in;
pll_r3_out <= pll_r3_in;
pll_r2_out <= pll_r2_in;
pll_r1_out <= pll_r1_in;
pll_r0_out <= pll_r0_in;
pll_f7_out <= pll_f7_in;
pll_f6_out <= pll_f6_in;
pll_f5_out <= pll_f5_in;
pll_f4_out <= pll_f4_in;
pll_f3_out <= pll_f3_in;
pll_f2_out <= pll_f2_in;
pll_f1_out <= pll_f1_in;
pll_f0_out <= pll_f0_in;



ccrest_a0_out <= ccrest_a0_in;
ccrest_a1_out <= ccrest_a1_in;
ccrest_a2_out <= ccrest_a2_in;
ccrest_a3_out <= ccrest_a3_in;

ccrest_b0_out <= ccrest_b0_in;
ccrest_b1_out <= ccrest_b1_in;
ccrest_b2_out <= ccrest_b2_in;
ccrest_b3_out <= ccrest_b3_in;

--global crest and ccrest controls signals
crest_lbs_out <= crest_lbs_in;
crest_clr_out <= crest_clr_in;

--dut address pins
dut_addr0_out <= dut_addr0_in;
dut_addr1_out <= dut_addr1_in; --constant for now
dut_addr2_out <= dut_addr2_in;
dut_addr3_out <= dut_addr3_in;
dut_addr4_out <= dut_addr4_in;
dut_addr5_out <= dut_addr5_in;

--pll controls
pll_fbs2_out <= pll_fbs2_in;
pll_fbs1_out <= pll_fbs1_in;
pll_fbs0_out <= pll_fbs0_in;
pll_os2_out <= pll_os2_in;
pll_os1_out <= pll_os1_in;
pll_os0_out <= pll_os0_in;
--pll_ps4_out <= pll_ps4_in;
--pll_ps3_out <= pll_ps3_in;
--pll_ps2_out <= pll_ps2_in;
--pll_ps1_out <= pll_ps1_in;
--pll_ps0_out <= pll_ps0_in;
--pll_rs1_out <= pll_rs1_in;
--pll_rs0_out <= pll_rs0_in;

--show fpga_clock_out on hex0 decmial point
hex0dp <= not fpga_clk_prev;

--data output process
--keeps track of fpga clk and outputs data according to pattern type
process (fpga_clk_prev, reset)
	variable count1100, count1k : integer;
begin
	if reset = '0' and rising_edge(fpga_clk_prev) then
		data1010 <= '0';
		data1100 <= '0';
		count1100 := 4;
		data1k <= '0';
		count1k := 2046;
	end if;
	if rising_edge(fpga_clk_prev) then
		data1010 <= not data1010;
		count1100 := count1100 - 1;
		count1k := count1k -1;

		if count1100 > 2 then
			data1100 <= '0';
		elsif count1100 < 3 and count1100 >= 1 then
			data1100 <= '1';
		elsif count1100 < 1 then
			count1100 := 4;
			data1100 <= '0';
		end if;

		if count1k >= 1023 then
			data1k <= '0';
		elsif count1k <= 1022 and count1k >1 then
			data1k <= '1';
		elsif count1k <= 1 then
			count1k := 2046;
			data1k <= '0';
		end if;
	end if;
end process;

end behave;
