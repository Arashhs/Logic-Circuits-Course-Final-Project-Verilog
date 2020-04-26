`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:	17:36:20 12/23/2018
// Design Name:
// Module Name:	E1
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`define CLOCK_FREQ 1000
`define TIME_DELAY 3


module E1(CLK,RST,inDoorButtons,outDoorButtons,motor,doorState, currentFloor);
input CLK,RST;
input[3:1] inDoorButtons,outDoorButtons;
output[1:0] motor;
output doorState;
output[3:1] currentFloor;
reg[1:0] motor = 2'b00;
reg doorState = 0;
reg[3:1] requests = 3'b000 , currentFloor = 3'b001;
reg [1:0] presentState = 2'b00, nextState = 2'b00;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
parameter motorDown = 2'b11, motorUp = 2'b10, motorOff = 2'b00;
parameter F1 = 3'b001, F2 = 3'b010, F3 = 3'b100;





always @ (posedge CLK)
    	begin
   	 
  	if (RST) begin
   // 	presentState <= S0;  //Initialize to state S0
   // 	doorState <= 0;
	//  	currentFloor <= 3'b001;
    	end
      	else
      	begin
   		 
   		          	if(inDoorButtons[1] == 1 ||outDoorButtons[1] == 1) requests[1] <= 1;
   			 else
        	if(inDoorButtons[2] == 1 ||outDoorButtons[2] == 1) requests[2] <= 1;
   			 else begin end
        	if(inDoorButtons[3] == 1 ||outDoorButtons[3] == 1) requests[3] <= 1;
     	case (presentState)
        	S0:
            	if (requests[2] || requests[3]) begin
            	nextState <= S1; //goes to 2up
            	motor <= motorUp;
            	doorState<=0;
            	end
            	else begin
            	motor <= motorOff;
            	doorState <= 1;
            	end
        	S1: if (requests[3]) begin
            	nextState <= S3; //2up goes to 3rd floor
            	motor <= motorUp;
            	doorState<=0;
            	end
              	else if (requests[1]) begin
                    	nextState <= S0; //2up goes to 1st floor
                    	motor <= motorDown;
                    	doorState<=0;
                    	end
                    	else begin
                    	motor <= motorOff;
                    	doorState <= 1;
                    	end
        	S2: if (requests[1]) begin
            	nextState <= S0; //2down goes to 1st floor
            	motor <= motorDown;
            	doorState<=0;
            	end
                    	else if(requests[3]) begin
                    	nextState <= S3; //2down goes to the 3rd floor
                    	motor <= motorUp;
                    	doorState<=0;
                    	end
                    	else begin
                    	motor <= motorOff;
                    	doorState<=1;
                    	end
        	S3: if (requests[2] || requests[1]) begin
            	nextState <= S2;
            	motor <= motorDown;
            	doorState<=0;
            	end
            	else begin
            	motor <= motorOff;
            	doorState<=1;
            	end
     	endcase
       	 
       	 
        	case(currentFloor)
        	F1:
        	if(requests[1]) begin
        	motor <= motorOff;
        	doorState<=1;
        	requests[1] <= 0;
       	 
        	presentState <= nextState;
       	 
        	end
       	 
       	 
        	F2:
        	if(requests[2]) begin
        	motor <= motorOff;
        	doorState<=1;
        	requests[2] <= 0;
       	 
        	presentState <= nextState;
       	 
        	end
       	 
       	 
        	F3:
        	if(requests[3]) begin
        	motor <= motorOff;
        	doorState<=1;
        	requests[3] <= 0;
       	 
        	presentState <= nextState;
       	 
        	end
       	 
        	endcase
   		 
   		 
      	case(motor)
      	motorDown: begin
      	case(currentFloor)
      	F2: currentFloor <= F1;
      	F3: currentFloor <= F2;
      	endcase
      	end
     	 
    	motorUp: begin
      	case(currentFloor)
      	F1: currentFloor <= F2;
      	F2: currentFloor <= F3;
      	endcase
      	end
     	 
    	motorOff: begin
     	 
      	end
      	endcase
/*  	else begin
    	case(motor)
    	motorDown: doorState = 0;
    	motorUp: doorState = 0;
    	motorOff: begin
    	//open elevator's door
    	doorState = 1;
    	//wait for some seconds
    	if (counter > 0) begin
    	counter <= counter - 1;
  end else begin
      	//close elevator's door
            	doorState = 0;
        	counter <= 50;
   	 
    	end
    	end
    	endcase
    	if(doorState == 0)
    	begin
    	case(currentFloor)
    	F1: presentState = nextState;
    	F2: presentState = nextState;
    	F3: presentState = nextState;

    	endcase
    	end
   	 
    	end */
   	 
      	end
   		 
   		  end
   	 

 /*  	 
always @ (presentState or inDoorButtons or outDoorButtons or currentFloor) 	//Determine next state
        	begin
        	if(inDoorButtons[1] == 1 ||outDoorButtons[1] == 1) requests[1] <= 1;
   			 else
        	if(inDoorButtons[2] == 1 ||outDoorButtons[2] == 1) requests[2] <= 1;
   			 else begin end
        	if(inDoorButtons[3] == 1 ||outDoorButtons[3] == 1) requests[3] <= 1;
     	case (presentState)
        	S0:
            	if (requests[2] || requests[3]) begin
            	nextState <= S1; //goes to 2up
            	motor <= motorUp;
            	doorState<=0;
            	end
            	else begin
            	motor <= motorOff;
            	doorState <= 1;
            	end
        	S1: if (requests[3]) begin
            	nextState <= S3; //2up goes to 3rd floor
            	motor <= motorUp;
            	doorState<=0;
            	end
              	else if (requests[1]) begin
                    	nextState <= S0; //2up goes to 1st floor
                    	motor <= motorDown;
                    	doorState<=0;
                    	end
                    	else begin
                    	motor <= motorOff;
                    	doorState <= 1;
                    	end
        	S2: if (requests[1]) begin
            	nextState <= S0; //2down goes to 1st floor
            	motor <= motorDown;
            	doorState<=0;
            	end
                    	else if(requests[3]) begin
                    	nextState <= S3; //2down goes to the 3rd floor
                    	motor <= motorUp;
                    	doorState<=0;
                    	end
                    	else begin
                    	motor <= motorOff;
                    	doorState<=1;
                    	end
        	S3: if (requests[2] || requests[1]) begin
            	nextState <= S2;
            	motor <= motorDown;
            	doorState<=0;
            	end
            	else begin
            	motor <= motorOff;
            	doorState<=1;
            	end
     	endcase
       	 
       	 
        	case(currentFloor)
        	F1:
        	if(requests[1]) begin
        	motor <= motorOff;
        	doorState<=1;
        	requests[1] <= 0;
       	 
        	presentState <= nextState;
       	 
        	end
       	 
       	 
        	F2:
        	if(requests[2]) begin
        	motor <= motorOff;
        	doorState<=1;
        	requests[2] <= 0;
       	 
        	presentState <= nextState;
       	 
        	end
       	 
       	 
        	F3:
        	if(requests[3]) begin
        	motor <= motorOff;
        	doorState<=1;
        	requests[3] <= 0;
       	 
        	presentState <= nextState;
       	 
        	end
       	 
        	endcase
       	 
        	end */
           	 
 	//       	bcdsevenseg seg(currentFloor , SEG_SEL , SEG_DATA);
       	 
       	 

endmodule
