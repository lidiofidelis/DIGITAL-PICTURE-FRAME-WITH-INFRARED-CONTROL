module SEG_HEX1
	(	 
		data,data_ready,							
		oHEX_D		
	);
input [7:0] data;	
input data_ready;			
output	  [3:0]	  oHEX_D;   
reg	  [3:0]	  oHEX_D;	

always @(data_ready) 

	begin	
		if (data_ready)
		begin
					case (data) 
					8'h12: oHEX_D <= 4'd0;
					8'h0: oHEX_D <= 4'd10;
					8'h1: oHEX_D <= 4'd1;
					8'h2: oHEX_D <= 4'd2;
					8'h3: oHEX_D <= 4'd3;
					8'h4: oHEX_D <= 4'd4;
					8'h5: oHEX_D <= 4'd5;
					8'h6: oHEX_D <= 4'd6;
					8'h7: oHEX_D <= 4'd7;
					8'h8: oHEX_D <= 4'd8;
					8'h9: oHEX_D <= 4'd9;
					8'h16: oHEX_D <= 4'd11;
					default: oHEX_D <= 4'd15;
					endcase	
		end
	end
endmodule	