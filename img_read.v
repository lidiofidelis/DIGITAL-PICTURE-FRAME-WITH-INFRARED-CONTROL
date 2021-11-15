module img_read(
	DATA,
	ADDR,
	clock);

	input  [8:0]  DATA;
	output [22:0] ADDR;
	input clock;
	
	
	reg [16:0] tmpData;
	reg [22:0] fl_cont;
	

always@(posedge clock)
begin
		if(FLASH_Cont < FLASH_DATA_NUM-1 )
		FLASH_Cont	<=	FLASH_Cont+1;
		else
		FLASH_Cont	<=	0;
	end
end
assign	oFLASH_ADDR	=	FLASH_Cont;
//////////////////////////////////////////////////
//////////	  FLASH DATA Reorder	//////////////
always@(posedge LRCK_4X or negedge iRST_N)
begin
	if(!iRST_N)
	FLASH_Out_Tmp	<=	0;
	else
	begin
		if(FLASH_Cont[0])
		FLASH_Out_Tmp[15:8]	<=	iFLASH_DATA;
		else
		FLASH_Out_Tmp[7:0]	<=	iFLASH_DATA;		
	end
end
always@(negedge LRCK_2X	or negedge iRST_N)
begin
	if(!iRST_N)
	FLASH_Out	<=	0;
	else
	FLASH_Out	<=	FLASH_Out_Tmp;
end
	
endmodule
	