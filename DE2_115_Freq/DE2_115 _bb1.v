
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE2_115(

	//////////// CLOCK //////////
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,

	//////////// RS232 //////////
	UART_CTS,
	UART_RTS,
	UART_RXD,
	UART_TXD,

	//////////// I2C for HSMC  //////////
	I2C_SCLK,
	I2C_SDAT,

	//////////// GPIO, GPIO connect to GPIO Default - 1.8V //////////
	GPIO,

	//////////// HSMC, HSMC connect to HSMC Default - 1.8V //////////
	HSMC_CLKIN_N1,
	HSMC_CLKIN_N2,
	HSMC_CLKIN_P1,
	HSMC_CLKIN_P2,
	HSMC_CLKIN0,
	HSMC_CLKOUT_N1,
	HSMC_CLKOUT_N2,
	HSMC_CLKOUT_P1,
	HSMC_CLKOUT_P2,
	HSMC_CLKOUT0,
	HSMC_D,
	HSMC_RX_D_N,
	HSMC_RX_D_P,
	HSMC_TX_D_N,
	HSMC_TX_D_P
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;
input 		          		CLOCK2_50;
input 		          		CLOCK3_50;

//////////// LED //////////
output		     [8:0]		LEDG;
output		    [17:0]		LEDR;

//////////// KEY //////////
input 		     [3:0]		KEY;

//////////// SW //////////
input 		    [17:0]		SW;

//////////// SEG7 //////////
output		     [6:0]		HEX0;
output		     [6:0]		HEX1;
output		     [6:0]		HEX2;
output		     [6:0]		HEX3;
output		     [6:0]		HEX4;
output		     [6:0]		HEX5;
output		     [6:0]		HEX6;
output		     [6:0]		HEX7;

//////////// RS232 //////////
output		          		UART_CTS;
input 		          		UART_RTS;
input 		          		UART_RXD;
output		          		UART_TXD;

//////////// I2C for HSMC  //////////
output		          		I2C_SCLK;
inout 		          		I2C_SDAT;

//////////// GPIO, GPIO connect to GPIO Default - 1.8V //////////
inout 		    [35:0]		GPIO;

//////////// HSMC, HSMC connect to HSMC Default - 1.8V //////////
input 		          		HSMC_CLKIN_N1;
input 		          		HSMC_CLKIN_N2;
input 		          		HSMC_CLKIN_P1;
input 		          		HSMC_CLKIN_P2;
input 		          		HSMC_CLKIN0;
output		          		HSMC_CLKOUT_N1;
output		          		HSMC_CLKOUT_N2;
output		          		HSMC_CLKOUT_P1;
output		          		HSMC_CLKOUT_P2;
output		          		HSMC_CLKOUT0;
inout 		     [3:0]		HSMC_D;
inout 		    [16:0]		HSMC_RX_D_N;
inout 		    [16:0]		HSMC_RX_D_P;
inout 		    [16:0]		HSMC_TX_D_N;
inout 		    [16:0]		HSMC_TX_D_P;


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [28:0] counter;//needs to be modified each time
wire data_in;
wire sr1;

assign  HSMC_TX_D_N[1] = data_in;



//=======================================================
//  Structural coding
//=======================================================

dut_test_code inst_dut_test //dut_test_code maps pins from the fpga to the DUT
(
//.dip_sw(SW[3:1]), //these switches determine which outputs show on the LEDs
.button(KEY[0]), //only use button 0 for reset
//.ledb(LEDG),
//.ledr(LEDR),
//.ledg(LEDG),

.fpga_clk_out(HSMC_RX_D_P[0]),   //Counter clock
.fpga_clk_out_1(HSMC_TX_D_N[2]),  //CREST counter clock in
//.fpga_clk_out_2(GPIO[21]), // PLL FIN


.pll_en_in(SW[1]),
.pll_en_out(HSMC_TX_D_P[2]),  //PLL BP HIGH

.pll_sezro(HSMC_TX_D_P[1]),
.pll_sezro_constant(SW[2]),

.pll_seoro(HSMC_TX_D_P[0]),
.pll_seoro_constant(SW[3]),

.pll_sezDB(HSMC_TX_D_N[11]),
.pll_sezDB_constant(1'b0),

.pll_seoDB(HSMC_RX_D_N[9]),
.pll_seoDB_constant(1'b1),

.ext_data_to_dut(data_in), //connect to DUT CREST data pin to control either 1 or 0 input to shift registers
.ext_data_constant(SW[6]), //SW0 controls the external data input to the DUT
//.ext_data_select(4'b0000), //these switches are no longer used.

.ext_data_to_dutpattern(HSMC_TX_D_N[0]),
.ext_datapattern_constant(SW[7]),

//.hex0dp(HEX0_DP), //not used

.osc_50(CLOCK_50), //system clock to dut_test_code. do not change unless necessary


//.set_lbs_in(1'b1), //connect to switch to test later
//.set_lbs_out(HSMC_TX_D_P[4]),

//.set_inv_in(1'b1), //connect to switch later to test SETs
//.set_inv_out(HSMC_CLKOUT_P1),

//------------------------------
//these are the INPUTS to CCRESTs circuits

//.ccrest_lbs_in(1'b1), //load=0, shift=1. this selects whether to load the values in the data & clk counters or to serially shift out the values in the counters
//.ccrest_lbs_out(HSMC_TX_D_P[6]),

//.ccrest_clr_in(KEY[1]), //clear the value stored in the data and clk counters
//.ccrest_clr_out(HSMC_TX_D_N[6]),




//v1 is called v3 in Thiago's nomenclature
//.ccrest_v1_xor1_in(SW[2]),
//.ccrest_v1_xor2_in(SW[3]),
//.ccrest_v1_xor1_out(HSMC_RX_D_P[5]),
//.ccrest_v1_xor2_out(HSMC_TX_D_N[5]),

//v2 is called v6 in Thiago's nomenclature
//.ccrest_v2_xor1_in(SW[4]),
//.ccrest_v2_xor2_in(SW[5]),
//.ccrest_v2_xor1_out(HSMC_RX_D_P[4]),
//.ccrest_v2_xor2_out(HSMC_CLKOUT_N1),

//PLL inputs
//.pll_od2_in(1'b1),
//.pll_od1_in(1'b1),
.pll_od0_in(1'b1),
.pll_r4_in(1'b1),
.pll_r3_in(1'b1),
.pll_r2_in(1'b1),
.pll_r1_in(1'b1),
.pll_r0_in(1'b1),
.pll_f7_in(1'b1),
.pll_f6_in(1'b1),
.pll_f5_in(1'b1),
.pll_f4_in(1'b1),
.pll_f3_in(1'b1),
.pll_f2_in(1'b1),
.pll_f1_in(1'b1),
.pll_f0_in(1'b1),

//.pll_od2_out(GPIO[1]),
//.pll_od1_out(GPIO[2]),
//.pll_od0_out(GPIO[3]),
//.pll_r4_out(GPIO[5]),
//.pll_r3_out(GPIO[6]),
//.pll_r2_out(GPIO[7]),
//.pll_r1_out(GPIO[8]),
//.pll_r0_out(GPIO[9]),
//.pll_f7_out(GPIO[10]),
//.pll_f6_out(GPIO[11]),
//.pll_f5_out(GPIO[12]),
//.pll_f4_out(GPIO[13]),
//.pll_f3_out(GPIO[14]),
//.pll_f2_out(GPIO[15]),
//.pll_f1_out(GPIO[16]),
//.pll_f0_out(GPIO[19]),


//these are the COMMMON inputs to BOTH CCREST circuits---
//.ccrest_a0_in(SW[6]),
//.ccrest_a1_in(SW[7]),
//.ccrest_a2_in(SW[8]),
//.ccrest_a3_in(SW[9]),

//.ccrest_a0_out(HSMC_CLKIN_N1),
//.ccrest_a1_out(HSMC_RX_D_N[7]),
//.ccrest_a2_out(HSMC_CLKIN_P1),
//.ccrest_a3_out(HSMC_RX_D_P[7]),

//.ccrest_b0_in(SW[10]),
//.ccrest_b1_in(SW[11]),
//.ccrest_b2_in(SW[12]),
//.ccrest_b3_in(SW[13]),

//.ccrest_b0_out(HSMC_TX_D_N[7]),
//.ccrest_b1_out(HSMC_RX_D_N[6]),
//.ccrest_b2_out(HSMC_TX_D_P[7]),
//.ccrest_b3_out(HSMC_RX_D_P[6]),

// THE OUTPUTS are called sr27 s28 data27 and data28 and so on.
//----------------------------------------------------------



.crest_lbs_in(1'b0), //load=0, shift=1. this selects whether to load the values in the data & clk counters or to serially shift out the values in the counters
.crest_lbs_out(HSMC_RX_D_P[1]),


.crest_clr_in(1'b0), //clear the value stored in the data and clk counters
.crest_clr_out(HSMC_RX_D_N[0]),

//dut address bits. when doing alpha, heavy-ion, or laser testing, the address does not need to change since you can only test
//one chip at a time-----------------------
.dut_addr0_in(1'b0),
.dut_addr1_in(1'b0),
.dut_addr2_in(1'b0),
.dut_addr3_in(1'b0),
.dut_addr4_in(1'b0),
.dut_addr5_in(1'b0),

.dut_addr0_out(HSMC_TX_D_P[11]),
.dut_addr1_out(HSMC_RX_D_P[9]),
.dut_addr2_out(HSMC_TX_D_N[10]),
.dut_addr3_out(HSMC_TX_D_N[9]),
.dut_addr4_out(HSMC_TX_D_P[10]),
.dut_addr5_out(HSMC_TX_D_P[9]),
//------------------------------------------

//pll control inputs------------------------
///.pll_fbs2_in(~DIP_SW[5]),//010
///.pll_fbs1_in(~DIP_SW[6]), //bypass mode os2 = os1  = os0 = 1
///.pll_fbs0_in(~DIP_SW[7]),
///.pll_os2_in(~DIP_SW[0]),
///.pll_os1_in(~DIP_SW[1]),
///.pll_os0_in(~DIP_SW[2]),
//.pll_os0_in(1'b0),

//.pll_ps4_in(1'b1),
//.pll_ps3_in(1'b1),
//.pll_ps2_in(1'b0),
//.pll_ps1_in(1'b0),
//.pll_ps0_in(1'b1),
//.pll_rs1_in(1'b1),
//.pll_rs0_in(1'b0),
//rs1 and rs0 are the mux controls to select the clk that goes to the shift regs
//rs1 | rs0
// 0  |  0  pll0
// 0  |  1  pll1
// 1  |  0  tmr
// 1  |  1  external clk

///.pll_fbs2_out(HSTCC_RX_n[24]),
///.pll_fbs1_out(HSTCC_RX_p[24]), //bypass mode rs0 = rs1 = 1
///.pll_fbs0_out(HSTCC_RX_n[26]),
///.pll_os2_out(HSTCC_RX_p[16]),
///.pll_os1_out(HSTCC_TX_n[16]),
//.pll_os0_out(HSTCC_TX_p[16]),
//.pll_ps4_out(HSTCC_TX_p[16]),
//.pll_ps3_out(HSTCC_TX_n[16]),
//.pll_ps2_out(HSTCC_RX_p[16]),
//.pll_ps1_out(HSTCC_RX_n[16]),
//.pll_ps0_out(HSTCC_RX_p[15]),
//.pll_rs1_out(HSTCC_RX_n[15]),
//.pll_rs0_out(HSTCC_RX_p[14]),
//------------------------------------


//these are the outputs from the DUT
//data counter serial output pin
//
.data_out1(HSMC_CLKIN_N2),
.data_out2(HSMC_RX_D_N[16]),
.data_out3(HSMC_CLKIN_P2),
.data_out4(HSMC_RX_D_P[16]),
.data_out5(HSMC_TX_D_N[16]),
.data_out6(HSMC_RX_D_N[15]),
.data_out7(HSMC_TX_D_P[16]),
.data_out8(HSMC_RX_D_P[15]),
.data_out9(HSMC_TX_D_N[15]),
.data_out10(HSMC_RX_D_N[14]),
.data_out11(HSMC_RX_D_N[10]),
.data_out12(HSMC_TX_D_P[12]),
.data_out13(HSMC_TX_D_P[15]),
.data_out14(HSMC_RX_D_P[14]),
.data_out15(HSMC_TX_D_N[14]),
.data_out16(HSMC_RX_D_N[13]),
.data_out17(HSMC_TX_D_P[14]),
.data_out18(HSMC_RX_D_P[13]),
.data_out19(HSMC_CLKOUT_N2),
.data_out20(HSMC_RX_D_N[12]),
.data_out21(HSMC_CLKOUT_P2),

.data_out22(HSMC_RX_D_P[12]),
.data_out23(HSMC_TX_D_N[13]),
.data_out24(HSMC_RX_D_N[11]),
.data_out25(HSMC_TX_D_P[13]),
.data_out26(HSMC_RX_D_P[11]),

.data_out27(HSMC_TX_D_N[12]),
//.data_out28(HSMC_RX_D_N[5]),
//.data_out29(HSMC_TX_D_P[5]),


//

//clk counter serial output pins
//.clk_out1(HSTCC_TX_p[21]),
//.clk_out2(HSTCC_TX_p[3]),
//.clk_out3(HSTCC_RX_p[5]),
//.clk_out4(HSTCC_TX_n[4]),
//.clk_out5(HSTCC_RX_n[6]),
//.clk_out6(HSTCC_TX_p[4]),
//.clk_out7(HSTCC_RX_p[6]),
//.clk_out8(HSTCC_TX_n[5]),
//.clk_out9(HSTCC_RX_n[7]),
//.clk_out10(HSTCC_TX_p[5]),
//.clk_out11(HSTCC_RX_p[7]),
//.clk_out12(HSTCC_TX_n[6]),
//.clk_out13(HSTCC_TX_n[7]),
//.clk_out14(HSTCC_TX_p[6]),
//.clk_out15(HSTCC_TX_p[7]),
//.clk_out16(HSTCC_TX_p[11]),
//.clk_out17(HSTCC_RX_p[12]),
//.clk_out18(HSTCC_CLKOUT_n[1]), //die1 clk18 to 21. die2 clk18 to 21 = set1 to 4
//.clk_out19(HSTCC_RX_n[13]),
//.clk_out20(HSTCC_CLKOUT_p[1]),
//.clk_out21(HSTCC_RX_p[13]),

//shift register direct outputs
//.sr_out1(sr1),
//.sr_out2(HSTCC_TX_p[12]),
//.sr_out3(HSTCC_TX_n[13]),
//.sr_out4(HSTCC_TX_p[13]),
//.sr_out5(HSTCC_TX_n[14]),
//.sr_out6(HSTCC_TX_p[14]),
//.sr_out7(HSTCC_TX_n[15]),
//.sr_out8(HSTCC_TX_p[15]),
//.sr_out9(HSTCC_RX_p[21]),
//.sr_out10(HSTCC_TX_n[22]),
//.sr_out11(HSTCC_RX_n[22]),
//.sr_out12(HSTCC_TX_p[22]),
//.sr_out13(HSTCC_RX_p[22]),
//.sr_out14(HSTCC_TX_n[23]),
//.sr_out15(HSTCC_RX_n[23]),
//.sr_out16(HSTCC_TX_p[23]),
//.sr_out17(HSTCC_RX_p[23]),
//.sr_out18(HSTCC_TX_n[24]),
//.sr_out19(HSTCC_TX_p[24]),
//.sr_out20(HSTCC_TX_n[25]),
//.sr_out21(HSTCC_TX_p[25]),


//
///.sr_out1(HSTCC_TX_p[26]),
///.sr_out2(HSTCC_TX_n[26]),
///.sr_out3(HSTCC_TX_p[25]),
///.sr_out4(HSTCC_TX_n[25]),
///.sr_out5(HSTCC_TX_p[24]),
///.sr_out6(HSTCC_TX_n[24]),
///.sr_out7(HSTCC_RX_p[23]),
///.sr_out8(HSTCC_TX_p[23]),
///.sr_out9(HSTCC_RX_n[23]),
///.sr_out10(HSTCC_TX_n[23]),
///.sr_out11(HSTCC_RX_p[22]),
///.sr_out12(HSTCC_TX_p[22]),
///.sr_out13(HSTCC_RX_n[22]),
///.sr_out14(HSTCC_TX_n[22]),
///.sr_out15(HSTCC_RX_p[21]),
///.sr_out16(HSTCC_TX_p[15]),
///.sr_out17(HSTCC_TX_n[15]),
///.sr_out18(HSTCC_TX_p[14]),
///.sr_out19(HSTCC_TX_n[14]),
///.sr_out20(HSTCC_TX_p[13]),
///.sr_out21(HSTCC_TX_n[13]),

///.sr_out22(HSTCC_TX_p[12]),
///.sr_out23(HSTCC_TX_n[12]),
///.sr_out24(HSTCC_RX_p[13]),
///.sr_out25(HSTCC_CLKOUT_p[1]),
///.sr_out26(HSTCC_RX_n[13]),

///.sr_out27(HSTCC_RX_p[12]),
///.sr_out28(HSTCC_TX_p[7]),

//
//these are the pins that are directed to the FPGA on board counters
.data_lsb_out1(counter[0]),
.data_lsb_out2(counter[1]),
.data_lsb_out3(counter[2]),
.data_lsb_out4(counter[3]),
.data_lsb_out5(counter[4]),
.data_lsb_out6(counter[5]),
.data_lsb_out7(counter[6]),
.data_lsb_out8(counter[7]),
.data_lsb_out9(counter[8]),
.data_lsb_out10(counter[9]),
.data_lsb_out11(counter[10]),
.data_lsb_out12(counter[11]),
.data_lsb_out13(counter[12]),
.data_lsb_out14(counter[13]),
.data_lsb_out15(counter[14]),
.data_lsb_out16(counter[15]),
.data_lsb_out17(counter[16]),
.data_lsb_out18(counter[17]),
.data_lsb_out19(counter[18]),
.data_lsb_out20(counter[19]),
.data_lsb_out21(counter[20]),

.data_lsb_out22(counter[21]),
.data_lsb_out23(counter[22]),
.data_lsb_out24(counter[23]),
.data_lsb_out25(counter[24]),
.data_lsb_out26(counter[25]),

.data_lsb_out27(counter[26]),
.data_lsb_out28(counter[27]),
.data_lsb_out29(counter[28]),

//.setqsrff(HSMC_TX_D_N[4]),
//.setdata(HSMC_RX_D_P[3])

);
//this controls all counting. do not change anything here unless absolutely necessary

wire internal_reset; //internal reset signal that reset set and data counters

lsb_main lsb_main_test
(

.reset(KEY[0]),
.sys_clk(CLOCK_50),
.counter_in0(counter[0]),
.counter_in1(counter[1]),
.counter_in2(counter[2]),
.counter_in3(counter[3]),
.counter_in4(counter[4]),
.counter_in5(counter[5]),
.counter_in6(counter[6]),
.counter_in7(counter[7]),
.counter_in8(counter[8]),
.counter_in9(counter[9]),
.counter_in10(counter[10]),
.counter_in11(counter[11]),
.counter_in12(counter[12]),
.counter_in13(counter[13]),
.counter_in14(counter[14]),
.counter_in15(counter[15]),
.counter_in16(counter[16]),
.counter_in17(counter[17]),
.counter_in18(counter[18]),
.counter_in19(counter[19]),
.counter_in20(counter[20]),

.counter_in21(counter[21]),
.counter_in22(counter[22]),
.counter_in23(counter[23]),
.counter_in24(counter[24]),
.counter_in25(counter[25]),

.counter_in26(counter[26]),
.counter_in27(counter[27]),
//.counter_in28(counter[28]),

//serial ports
.serial_in(UART_RXD),
.serial_out(UART_TXD)




);//end lsb_main test
endmodule
