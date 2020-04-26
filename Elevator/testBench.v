`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:19 01/04/2019 
// Design Name: 
// Module Name:    testBench 
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
module testBench(
    );
reg clk, rst;
reg[4:1] keyPadInput;
wire [16:1]pass_out;
wire [4:1]count_out;

wire [8:1] state;
wire warning;
wire canRequestAFloor;

parameter [4:1] zero = 4'b0000, one = 4'b0001, two = 4'b0010, three = 4'b0011, four = 4'b0100, five = 4'b0101, six = 4'b0110;
parameter [4:1] seven = 4'b0111, eight = 4'b1000, nine = 4'b1001, star = 4'b1010, tag = 4'b1011;


reg[3:1] inDoorButtons, outDoorButtons;
wire[3:1] currentFloor;
wire[1:0] motor;
wire doorState;


Elevator elevator(
.clk(clk),
.rst(rst),
.inDoorButtons(inDoorButtons),
.outDoorButtons(outDoorButtons),
.keyPadInput(keyPadInput),
.pass_out(pass_out),
.count_out(count_out),
.admin_out(admin_out),
.lock_out(lock_out),
.state(state),
.warning(warning),
.logined_Can_Request_a_Floor(canRequestAFloor),
.motor(motor),
.doorState(doorState),
.currentFloor(currentFloor)
);


initial
   begin
  	clk <= 1'b0;
	inDoorButtons = 3'b000;
	outDoorButtons = 3'b000;
  	repeat (300)
  	#10 clk <= ~clk;
   end

  initial begin
	rst <= 1;
	#10
	rst <= 0;
	#10
	// 
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = one; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = 4'b1111;
	#20
	keyPadInput = tag;
	#20
	keyPadInput = 4'b1111;
	#20
	keyPadInput = star;
	#25
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	#5
	outDoorButtons[3] = 1;
	#50
	keyPadInput = 4'b1111; //User logined with correct password
	
    
	$finish;
  end 



//This is a test for locking a user by entering wrong password for 3 times


/*
  //Check requesting by a user
initial
   begin
  	clk <= 1'b0;
	inDoorButtons = 3'b000;
	outDoorButtons = 3'b000;
  	repeat (300)
  	#10 clk <= ~clk;
   end

  initial begin
	rst <= 1;
	#10
	rst <= 0;
	#10
	// 
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = one; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = 4'b1111;
	#20
	keyPadInput = tag;
	#20
	keyPadInput = 4'b1111;
	#20
	keyPadInput = star;
	#25
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = two;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	#50
	keyPadInput = 4'b1111; //1st wrong pass attempt commited
	
	
	
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = one; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = 4'b1111;
	#20
	keyPadInput = tag;
	#20
	keyPadInput = 4'b1111;
	#35
	keyPadInput = star;
	#20
	keyPadInput = one;
	#20
	keyPadInput = two;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag; //2nd wrong pass commited
	#50
	keyPadInput = 4'b1111;
	
	
	#50
		keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = one; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = 4'b1111;
	#20
	keyPadInput = tag;
	#20
	keyPadInput = 4'b1111;
	#35
	keyPadInput = star;
	#20
	keyPadInput = one;
	#20
	keyPadInput = two;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	#50
	keyPadInput = 4'b1111; //3rd wrong pass commited
	
	
	
	
		#50
	keyPadInput = 4'b1111;
	
	
	#50
		keyPadInput = star; //now user must be locked, we try to log-in
	#20
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = one; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = 4'b1111;
	#20
	keyPadInput = tag;
	#20
	keyPadInput = 4'b1111;
	#35
	keyPadInput = star;
	#20
	keyPadInput = one;
	#20
	keyPadInput = two;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	#50
	keyPadInput = 4'b1111; 
	
	
	    
	$finish;
  end  */







//This is a test for admin moderation functions


/*
initial
   begin
  	clk <= 1'b0;
	inDoorButtons = 3'b000;
	outDoorButtons = 3'b000;
  	repeat (300)
  	#10 clk <= ~clk;
   end

  initial begin
	rst <= 1;
	#10
	rst <= 0;
	#10
	// First We check adding a new user
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	inDoorButtons[1] = 1'b1;
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = one; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	//Admin is now Logined
	#40
	keyPadInput = 4'b1111; //keypad is unused (Invalid for 40ns)
	#20
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = three;
	#20
	keyPadInput = five; //Username Entered
	#20
	keyPadInput = tag; //Adding new user
	#20 //Entering Password for new user
	keyPadInput = one;
	#20
	keyPadInput = two;
	#20
	keyPadInput = three;
	#20
	keyPadInput = four;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag; //Adding new user with username: 035 and Password: 1234
	#20
	keyPadInput = 4'b1111;
	
	
		//Now we check changing the admin
	#100
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = one; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	//Admin is now Logined
	#40
	keyPadInput = 4'b1111; //keypad is unused (Invalid for 40ns)
	#20
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = 1; //Username Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = one;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	#20
	keyPadInput = 4'b1111;
	#30
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = three;
	#20
	keyPadInput = five; //Username Entered
	#20
	keyPadInput = tag;
	#20
	keyPadInput = tag; //admin changed to 035
	#50
	keyPadInput = 4'b1111;
	
	
	//Now we check deleting a user
	#300
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = three;
	#20
	keyPadInput = five; //UserName Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = one;
	#20
	keyPadInput = two;
	#20
	keyPadInput = three;
	#20
	keyPadInput = four;
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	//Admin is now Logined
	#40
	keyPadInput = 4'b1111; //keypad is unused (Invalid for 40ns)
	#20
	keyPadInput = star;
	#20
	keyPadInput = zero;
	#20
	keyPadInput = three;
	#20
	keyPadInput = five; //Username Entered
	#20
	keyPadInput = star;
	#20
	keyPadInput = tag;
	#30
	keyPadInput = 4'b1111;
	#50
	keyPadInput = star;
	
	
	keyPadInput = 4'b1111; //keypad is unused (Invalid for 40ns)




    
    
	$finish;
  end */





endmodule
