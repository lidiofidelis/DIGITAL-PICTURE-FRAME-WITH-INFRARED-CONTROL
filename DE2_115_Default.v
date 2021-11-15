// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2_115_Default
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author              :| Mod. Date :| Changes Made:
//   V1.1 :| HdHuang             :| 05/12/10  :| Initial Revision
//   V2.0 :| Eko       				:| 05/23/12  :| version 11.1
// ============================================================================

module DE2_115_Default(

	//////// CLOCK //////////
	CLOCK_50,
   CLOCK2_50,
   CLOCK3_50,
	ENETCLK_25,

	//////// LED //////////
	LEDG,
	LEDR,

	//////// KEY //////////
	KEY,

	//////// SW //////////
	SW,

	//////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,


	//////// VGA //////////
	VGA_B,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS,


	//////// IR Receiver //////////
	IRDA_RXD,

	//////// SDRAM //////////
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_DQM,
	DRAM_RAS_N,
	DRAM_WE_N,

	//////// SRAM //////////
	SRAM_ADDR,
	SRAM_CE_N,
	SRAM_DQ,
	SRAM_LB_N,
	SRAM_OE_N,
	SRAM_UB_N,
	SRAM_WE_N,

	//////// Flash //////////
	FL_ADDR,
	FL_CE_N,
	FL_DQ,
	FL_OE_N,
	FL_RST_N,
	FL_RY,
	FL_WE_N,
	FL_WP_N,

);


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input		          		CLOCK_50;
input		          		CLOCK2_50;
input		          		CLOCK3_50;
input		          		ENETCLK_25;

//////////// LED //////////
output		   [8:0]		LEDG;
output	      [17:0]	LEDR;

//////////// KEY //////////
input		      [3:0]		KEY;

//////////// SW //////////
input		      [17:0]	SW;

//////////// SEG7 //////////
output		   [6:0]		HEX0;
output		   [6:0]		HEX1;
output		   [6:0]		HEX2;
output		   [6:0]		HEX3;
output		   [6:0]		HEX4;
output		   [6:0]		HEX5;
output		   [6:0]		HEX6;
output		   [6:0]		HEX7;


//////////// VGA //////////
output		   [7:0]		VGA_B;
output		        		VGA_BLANK_N;
output		        		VGA_CLK;
output		   [7:0]		VGA_G;
output	          		VGA_HS;
output	      [7:0]		VGA_R;
output	         		VGA_SYNC_N;
output	          		VGA_VS;


//////////// IR Receiver //////////
input		          		IRDA_RXD;

//////////// SDRAM //////////
output		  [12:0]		DRAM_ADDR;
output	      [1:0]		DRAM_BA;
output		        		DRAM_CAS_N;
output		        		DRAM_CKE;
output		        		DRAM_CLK;
output		        		DRAM_CS_N;
inout		     [31:0]		DRAM_DQ;
output		   [3:0]		DRAM_DQM;
output		        		DRAM_RAS_N;
output		        		DRAM_WE_N;

//////////// SRAM //////////
output		  [19:0]		SRAM_ADDR;
output		        		SRAM_CE_N;
inout		     [15:0]		SRAM_DQ;
output		        		SRAM_LB_N;
output		        		SRAM_OE_N;
output		        		SRAM_UB_N;
output		        		SRAM_WE_N = 1'b1;

//////////// Flash //////////
output	     [22:0]		FL_ADDR;
output		        		FL_CE_N;
inout		      [7:0]		FL_DQ;
output		        		FL_OE_N;
output		        		FL_RST_N = 1'b1;
input		          		FL_RY;
output		        		FL_WE_N = 1'b1;
output		        		FL_WP_N;


///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================


//	For Audio CODEC
wire		   AUD_CTRL_CLK;	//	For Audio Controller

wire [31:0]	mSEG7_DIG;
reg  [31:0]	Cont;
wire		   VGA_CTRL_CLK;
wire  [9:0]	mVGA_R;
wire  [9:0]	mVGA_G;
wire  [9:0]	mVGA_B;
//wire  [19:0]mVGA_ADDR;
wire		   DLY_RST;

//	For VGA Controller
wire			mVGA_CLK;
wire	[9:0]	mRed;
wire	[9:0]	mGreen;
wire	[9:0]	mBlue;
wire			VGA_Read;	//	VGA data request
wire   [18:0]	mVGA_ADDR;

wire  [9:0] recon_VGA_R;
wire  [9:0] recon_VGA_G;
wire  [9:0] recon_VGA_B;

//	For Down Sample
wire	[3:0]	Remain;
wire	[9:0]	Quotient;


//album
reg [21:0] FLASH_Cont;
reg [31:0]  count,count2;
reg		  clk;
reg [2:0] state;

parameter s0=0, s1=1, s2=2, s3=3, s4=4;
parameter data_max = 307200, index_max = 256; //FLASH
//parameter data_max = 307200, index_max = 256, img_addr = 19'h180;

reg [7:0] blue_index[0:2560-1];
reg [7:0] green_index[0:2560-1];
reg [7:0] red_index[0:2560-1];
reg [3:0] img_cont, count_play = 4'd1;

reg [7:0] index_cont;
reg [1:0] rgb_cont;

wire data_ready;
wire [7:0] ir_data;

reg  [19:0] SRAM_Cont;
reg  [7:0]  data_buffer;
reg  [11:0] index_init_flash;
reg  [23:0] data_init;
reg  [7:0]  red_buffer;
reg  [7:0]  blue_buffer;
reg  [7:0]  green_buffer;
reg  [11:0] index_init;
wire [3:0] ir_img;
reg reset;
//=============================================================================
// Structural coding
//=============================================================================
// initial //
//
			

//	All inout port turn to tri-state
assign	DRAM_DQ		=	32'hzzzzzzzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	SD_DAT		=	4'bz;
assign	FL_DQ			=  8'hzz;




always @(posedge CLOCK_50) begin //100ns
   count <= count + 1;
   if(count == 5)
   begin
      count<=0;
      clk <= ~clk;
   end
end

always@(posedge CLOCK_50) begin
	if (count2<50000000)
		count2<=count2+1;
	else
	begin
		count2 <= 0;
		if (count_play < 10)
			count_play <= count_play +1;
		else
			count_play <= 1;
	end
end

always @(posedge clk) begin
	case (ir_img)
		4'd1:
		begin
			index_init_flash <= 12'h0;
			data_init  <= 24'h1e00;
			index_init <= 12'h0;
			img_cont   <= 4'd1;
			reset <= 1'b0;
		end
		4'd2:
		begin
			index_init_flash <= 12'h300;
			data_init  <= 24'h4ce00;
			index_init <= 12'h200;
			img_cont   <= 4'd2;
			reset <= 1'b0;
		end
		4'd3:
		begin
			index_init_flash <= 12'h600;
			data_init  <= 24'h97e00;
			index_init <= 12'h400;
			img_cont   <= 4'd3;
			reset <= 1'b0;
		end
		4'd4:
		begin
			index_init_flash <= 12'h900;
			data_init  <= 24'he2e00;
			index_init <= 12'h600;
			img_cont   <= 4'd4;
			reset <= 1'b0;
		end
		4'd5:
		begin
			index_init_flash <= 12'hc00;
			data_init  <= 24'h12de00;
			index_init <= 12'h800;
			img_cont   <= 4'd5;
			reset <= 1'b0;
		end
		4'd6:
		begin
			index_init_flash <= 12'hf00;
			data_init  <= 24'h178e00;
			index_init <= 12'ha00;
			img_cont   <= 4'd6;
			reset <= 1'b0;
		end
		4'd7:
		begin
			index_init_flash <=12'h1200;
			data_init  <= 24'h1c3e00;
			index_init <= 12'hc00;
			img_cont   <= 4'd7;
			reset <= 1'b0;
		end
		4'd8:
		begin
			index_init_flash <= 12'h1500;
			data_init  <= 24'h20ee00;
			index_init <= 12'he00;
			img_cont   <= 4'd8;
			reset <= 1'b0;
		end
		4'd9:
		begin
			index_init_flash <= 12'h1800;
			data_init  <= 24'h259e00;
			index_init <= 12'h1000;
			img_cont   <= 4'd9;
			reset <= 1'b0;
		end
		4'd10:
		begin
			index_init_flash <= 12'h1b00;
			data_init  <= 24'h2a4e00;
			index_init <= 12'h1200;
			img_cont   <= 4'd10;
			reset <= 1'b0;
		end
		4'd0:
		begin
			reset <= 1'b1;
			data_buffer <= 8'd0;
		end
		4'd11:
		begin
			img_cont <= count_play;
			reset <= 1'b0;
		end
	endcase
end

//assign LEDR(0) = (~reset);

always@(posedge clk) 
begin

	case(state)
		s0:
		begin
				
				state <= s1;
				FLASH_Cont <= index_init_flash;
		end
		s1:
		begin
			if (index_cont < index_max-1)
			begin
				if (rgb_cont == 0)
				begin
					blue_index[index_init + index_cont]	<=	FL_DQ;
					rgb_cont <= rgb_cont+1;
					FLASH_Cont	<=	FLASH_Cont+1;
				end
				else if (rgb_cont == 1)
				begin
					green_index[index_init + index_cont]	<=	FL_DQ;
					rgb_cont <= rgb_cont+1;
					FLASH_Cont	<=	FLASH_Cont+1;
				end
				
				else
				begin
					red_index[index_init + index_cont]	<=	FL_DQ;
					rgb_cont <=0;
					index_cont <= index_cont +1;
					FLASH_Cont	<=	FLASH_Cont+1;
				end
			end
			else
			begin
			index_cont <= 0;
			state <= s2;
			end
		end
		s2:
		begin
			if (~reset)
				begin
				FLASH_Cont <= data_init;
				state <= s3;
				end
			else
			begin
				green_buffer <= data_buffer;
				blue_buffer  <= data_buffer;
				red_buffer   <= data_buffer;
			end
		end
		s3:
		begin
			if(mVGA_ADDR < data_max-1) begin
				
				FLASH_Cont <= data_init + mVGA_ADDR;
				//data_buffer <= FL_DQ;
				red_buffer <= red_index[index_init+FL_DQ];
				green_buffer <= green_index[index_init+FL_DQ];
				blue_buffer <= blue_index[index_init+FL_DQ];
			end
			else
				state <= s2;
			end
		endcase
end
assign	FL_ADDR	=	FLASH_Cont;


//	7 segment LUT
//SEG7_LUT_8 			u0	(	.oSEG0(HEX0),
//							.oSEG1(HEX1),
//							.oSEG2(HEX2),
//							.oSEG3(HEX3),
//							.oSEG4(HEX4),
//							.oSEG5(HEX5),
//							.oSEG6(HEX6),
//							.oSEG7(HEX7),
//							.iDIG(mSEG7_DIG) );

//	Reset Delay Timer
Reset_Delay			r0	(	.iCLK(CLOCK_50),.oRESET(DLY_RST)	);

VGA_Audio_PLL 		p1	(	.areset(~DLY_RST),.inclk0(CLOCK2_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(mVGA_CLK)	);

//	VGA Controller
//assign VGA_BLANK_N = !cDEN;
assign VGA_CLK = VGA_CTRL_CLK;
vga_controller vga_ins(.iRST_n(DLY_RST),
							 .iBlue(blue_buffer),
							 .iGreen(green_buffer),
							 .iRed(red_buffer),
                      .iVGA_CLK(VGA_CTRL_CLK),
							 .oADDR(mVGA_ADDR),
                      .oBLANK_n(VGA_BLANK_N),
                      .oHS(VGA_HS),
                      .oVS(VGA_VS),
                      .b_data(VGA_B),
                      .g_data(VGA_G),
                      .r_data(VGA_R));
					

IR_RECEIVE ir(
					///clk 50MHz////
					.iCLK(clk50), 
					//reset          
					.iRST_n(1'b1),        
					//IRDA code input
					.iIRDA(IRDA_RXD), 
					//read command      
					//.iREAD(data_read),
					//data ready      					
					.oDATA_READY(data_ready),
					//decoded data 32bit
					.oDATA(ir_data)        
					);
SEG7_LUT	(
	.iDIG(ir_img),
	.oSEG(HEX0));
SEG7_LUT	(
	.iDIG(count_play),
	.oSEG(HEX1));

// SEG_HEX1
//	(	 
//		.data(ir_data),
//		.data_ready(data_ready),
//		.oHEX_D(ir_img)		
//	);				
	
					
endmodule
