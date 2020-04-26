`timescale 1ns / 1ps
module ram_usage(clk, rst, keyPadInput, pass_out, count_out, admin_out, lock_out, state , warning , logined_Can_Request_a_Floor);

input clk, rst;
input [4:1] keyPadInput;
output [16:1]pass_out;
output [4:1] count_out;
output admin_out, lock_out;
output state;
output warning;
output logined_Can_Request_a_Floor;

reg cs, pass_rw, admin_rw, lock_rw, count_rw, ram_rst;
reg [12:1]addr;
reg [16:1]pass_in;
reg [4:1]count_in;
reg admin_in, lock_in, warning;
reg logined_Can_Request_a_Floor;


wire [16:1]pass_out;
wire [4:1]count_out;
wire admin_out, lock_out;


parameter [4:1] zero = 4'b0000, one = 4'b0001, two = 4'b0010, three = 4'b0011, four = 4'b0100, five = 4'b0101, six = 4'b0110;
parameter [4:1] seven = 4'b0111, eight = 4'b1000, nine = 4'b1001, star = 4'b1010, tag = 4'b1011;
parameter [8:1] start = 0, S1 = 1, S2 = 2, S3 = 3, S4=4, S5=5, SA6=6, SA7=7, SA8=8, SA9=9, SA10=10, adminLoginCheck=11, adminLogined=12, SA13=13;
parameter [8:1] SA14=14, SA15=15, SA16=16, SA17=17,SA18=18,SA19=19,SA20=20,SA21=21,SA22=22,SA23=23,SA24=24,SA25=25,SA26=26,SA27=27,SA28=28, SA29=29, SA_Change_Admin = 30, SA_Remove_Prev_Admin = 31, check_New_Admin = 32;
parameter [8:1] SA_Add = 40, SA_Add1 = 41, SA_Add2=42,SA_Add3=43,SA_Add4=44,SA_Add5=45,SA_Add6=46 , check_Added_Member = 100 , SA_Remove = 110, Check_Removed_User = 111;
parameter [8:1] Check_Locked_User = 69 , SU0 = 70, SU1=71 , SU2 = 72 , SU3 = 73 , SU4 = 74 , SU5 = 75 , SU6 = 76 , SU7 = 77;

reg [4:1] userName1, userName2, userName3, pass1, pass2, pass3, pass4;
reg [4:1] adminUser1, adminUser2, adminUser3;

reg [8:1] state, nextState;

reg passCheck;
 
       
       
SYNCSRAM DUT(
          .clk(clk), 
          .rst(ram_rst),
          .cs(cs),  //chip select
// read/write control   // read=0/write=1
          .pass_rw(pass_rw), 
          .admin_rw(admin_rw),
          .lock_rw(lock_rw),
          .count_rw(count_rw),
// address
          .addr(addr),// address
//input data
          .pass_in(pass_in),
          .count_in(count_in),
          .admin_in(admin_in),
          .lock_in(lock_in),
// output data
          .pass_out(pass_out), // data
          .count_out(count_out), // user try count
          .admin_out(admin_out),
          .lock_out(lock_out));
			 
initial begin
  ram_rst = 1;
  cs = 0;
  warning <= 0;
  logined_Can_Request_a_Floor <= 0;
end

always @(nextState)
state <= nextState;

always @(negedge clk or rst) begin
	

	if(rst)
	begin
	ram_rst <= 1;
	state <= start;
	nextState <= start;
	warning <= 0;
	logined_Can_Request_a_Floor <= 0;
	end
	
	
	else
	begin
  ram_rst <= 0;
  
  case(state)
  start:
  begin
  cs = 0;
  warning <= 0;
  logined_Can_Request_a_Floor <= 0;
  if(keyPadInput == star) nextState <= S1;
  end
  
  //Get digits for userName
  S1:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName1 = keyPadInput;
  nextState = S2;
  end
  end
  
  S2:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName2 = keyPadInput;
  nextState = S3;
  end
  end
  
  S3:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName3 = keyPadInput;
  nextState = S4;
  end
  end
  
  S4: 
  begin
   if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
	begin
  if(keyPadInput == star) nextState = S5;
  else nextState = start;
  end
  end
  
  S5: //determine whether it's a user login attempt or admin login attmept
  begin
  if(keyPadInput == tag) //user login attempt
  begin
  nextState = Check_Locked_User;
  end
  else
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass1 = keyPadInput;
  nextState = SA6;
  
  end
  
  end
  
  end
  
  SA6:
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass2 = keyPadInput;
  nextState = SA7;
  
  end
  
  end
    
  SA7:
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass3 = keyPadInput;
  nextState = SA8;
  
  end
  
  end
  
  SA8:
   begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass4 = keyPadInput;
  nextState = SA9;
  
  end
  
  end
  
  SA9: //Admin login requested. Must be ended with '*'
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  if(keyPadInput == star) nextState = SA10;
  else nextState = start;
  end
  end
  
  SA10: //Admin login requested. Must be ended with "#"
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  if(keyPadInput == tag) nextState = adminLoginCheck;
  else nextState = start;
  end
  end
  
  adminLoginCheck:
  begin
  
        if(!cs) begin
        addr = {userName1,userName2,userName3};
        pass_rw = 0;
		  admin_rw = 0;
        cs = 1;
      end
		
      else begin
        if((pass_out == {pass1,pass2,pass3,pass4}) &&(admin_out == 1))
		  begin
		  nextState = adminLogined;
		  end
		  
		  else
		  begin
		  nextState = start;
		  end
        cs = 0;
  end
  end
  
  adminLogined: //Get Username
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  
  if(keyPadInput == star)
  nextState = SA13;
  else
  begin
  nextState = start;
  warning <= 1;
  end
  
  end
  end
  
  //Get digits for userName
  SA13:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName1 = keyPadInput;
  nextState = SA14;
  end
  end
  
  SA14:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName2 = keyPadInput;
  nextState = SA15;
  end
  end
  
  SA15:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName3 = keyPadInput;
  nextState = SA16;
  end
  end
  
  SA16: //username entered, it must end with '*' or '#'
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  
  if(keyPadInput == star)
  nextState = SA17;
  else if(keyPadInput == tag)
  nextState = SA_Add;
  else
  begin
  nextState = start;
  warning = 1;
  end
  
  end
  
  end
  

  SA_Add:
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass1 = keyPadInput;
  nextState = SA_Add1;
  
  end
  
  end
    
  SA_Add1:
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass2 = keyPadInput;
  nextState = SA_Add2;
  
  end
  
  end
  
  SA_Add2:
   begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass3 = keyPadInput;
  nextState = SA_Add3;
  
  end
  
  end
  
   SA_Add3:
   begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass4 = keyPadInput;
  nextState = SA_Add4;
  
  end
  
  end
  

  SA_Add4: //Admin login requested. Must be ended with '*'
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  if(keyPadInput == star) nextState = SA_Add5;
  else nextState = start;
  end
  end
  
  SA_Add5: //Admin login requested. Must be ended with "#"
  begin
    if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
	 begin
  if(keyPadInput == tag) nextState = SA_Add6;
  else nextState = start;
  end
  end
  
  SA_Add6:
  begin
  
        if(!cs) begin
		  addr = {userName1,userName2,userName3};
        pass_rw = 1;
		  lock_rw = 1;
		  count_rw = 1;
		  admin_rw = 1;
		  pass_in = {pass1,pass2,pass3,pass4};
		  lock_in = 0;
		  count_in = 0;
		  admin_in = 0;
		  cs = 1;

      end
		
      else begin
		  nextState = check_Added_Member;
		  cs = 0;
		  
  end
  end
  
  check_Added_Member: 
        if (!cs)
        begin
          cs = 1;
          pass_rw = 0;
          lock_rw = 0;
			 count_rw = 0;
			 admin_rw = 0;
        end
        else
          begin
            cs = 0;
            state = start;
          end
			 
  SA17: 
  begin
    if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
	 begin
	 if(keyPadInput == tag)
	 nextState = SA_Remove;
	 else
	 begin
	 pass1 = keyPadInput;
	 nextState = SA18; //new Admin state
	 end
	 
	 end
  
  
  end
  
  SA_Remove: //Remove selected user by locking him
  begin
  
        if(!cs) begin
		  addr = {userName1,userName2,userName3};
		  lock_rw = 1;
		  count_rw = 1;
		  lock_in = 1;
		  count_in = 3;
		  cs = 1;

      end
		
      else begin
		  nextState = Check_Removed_User;
		  cs = 0;
		  
  end
  end
  
  Check_Removed_User:
   if (!cs)
        begin
          pass_rw = 0;
          lock_rw = 0;
			 count_rw = 0;
			 admin_rw = 0;
			 cs = 1;
        end
        else
          begin
            cs = 0;
            state = start;
          end
			 
  SA18:
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass2 = keyPadInput;
  nextState = SA19;
  
  end
  
  end
    
  SA19:
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass3 = keyPadInput;
  nextState = SA20;
  
  end
  
  end
  
  SA20:
   begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass4 = keyPadInput;
  nextState = SA21;
  
  end
  
  end
  
    SA21: //Admin login requested. Must be ended with '*'
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  if(keyPadInput == star) nextState = SA22;
  else nextState = start;
  end
  end
  
  SA22: //Admin login requested. Must be ended with "#"
  begin
    if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
	 begin
  if(keyPadInput == tag) nextState = SA23;
  else nextState = start;
  end
  end
  
  
  SA23: //We should verify current Admin's username And password
  begin
  
        if(!cs) begin
        addr = {userName1,userName2,userName3};
        pass_rw = 0;
		  admin_rw = 0;
        cs = 1;
      end
		
      else begin
        if((pass_out == {pass1,pass2,pass3,pass4}) &&(admin_out == 1))
		  begin
		  nextState = SA24;
		  end
		  
		  else
		  begin
		  nextState = start;
		  end
        cs = 0;
  end
  end
  
  SA24: //current Admin verified, now it should enter '*'
   begin
	adminUser1 = userName1;
	adminUser2 = userName2;
	adminUser3 = userName3;
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  if(keyPadInput == star) nextState = SA25;
  else nextState = start;
  end
  end
  
  SA25: //Now we should get new admin's username
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName1 = keyPadInput;
  nextState = SA26;
  end
  end
  
  SA26:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName2 = keyPadInput;
  nextState = SA27;
  end
  end
  
  SA27:
  begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  userName3 = keyPadInput;
  nextState = SA28;
  end
  end
  
  
  SA28: //it must end with ##
    begin
    if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
	 begin
  if(keyPadInput == tag) nextState = SA29;
  else nextState = start;
  end
  end
  
  SA29:
    begin
    if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
	 begin
  if(keyPadInput == tag) nextState = SA_Change_Admin;
  else nextState = start;
  end
  end
  
  SA_Change_Admin: //Current admin should demote to a user and selected user should become the new admin
  begin
        if(!cs) begin
        addr = {userName1,userName2,userName3};
		  admin_in = 1;
		  admin_rw = 1;
        cs = 1;
      end
		
      else begin
        nextState = SA_Remove_Prev_Admin;
        cs = 0;
  end
  end
	
  SA_Remove_Prev_Admin:
    begin
        if(!cs) begin
        addr = {adminUser1,adminUser2,adminUser3};
		  admin_in = 0;
		  admin_rw = 1;
        cs = 1;
      end
		
      else begin
        nextState = check_New_Admin;
        cs = 0;
  end
  end
  
  check_New_Admin:
          if (!cs)
        begin
		  addr = {userName1,userName2,userName3};
          cs = 1;
          pass_rw = 0;
          lock_rw = 0;
			 count_rw = 0;
			 admin_rw = 0;
        end
        else
          begin
            cs = 0;
            state = start;
          end
			 
	Check_Locked_User:
	  begin
        if(!cs) begin
        addr = {userName1,userName2,userName3};
        lock_rw = 0;
        cs = 1;
      end
		
      else begin
        if(lock_out == 1)
		  begin
		  nextState = start;
		  end
		  
		  else
		  begin
		  nextState = SU0;
		  end
        cs = 0;
  end
  end

		
			 
	SU0: //user must enter '*' 
	begin
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  if(keyPadInput == star) nextState = SU1;
  else nextState = start;
  end
  end
  
  SU1: //user must enter the password
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass1 = keyPadInput;
  nextState = SU2;
  
  end
  
  end
    
  SU2:
  begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass2 = keyPadInput;
  nextState = SU3;
  
  end
  
  end
  
  SU3:
   begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass3 = keyPadInput;
  nextState = SU4;
  
  end
  
  end
  
   SU4:
   begin
  
  if(!(keyPadInput[4] == 1 && keyPadInput[3]== 1))
  begin
  pass4 = keyPadInput;
  nextState = SU5;
  passCheck = 1;
  
  end
  
  end
  /*
  SU5: //Check user's password
    begin
  
        if(!cs) begin
        addr = {userName1,userName2,userName3};
        pass_rw = 0;
		  count_rw = 0;
		  lock_rw = 0;
        cs = 1;
		  if(passCheck == 0)
		  begin
		  count_rw = 1;
		  lock_rw = 1;
		  end
      end
		
      else begin
        if(pass_out == {pass1,pass2,pass3,pass4})
		  begin
		  passCheck = 1;
		  nextState = SU6;
		  cs = 0;
		  end
		  else if(passCheck == 0)
		  begin
		  count_in = count_in+1;
		  passCheck = 1;
		  nextState = start;
		  if(count_in > 2)
		  lock_in = 1;
		  
		  end
		  
		  else
		  begin
		  passCheck = 0;
		  count_in = count_out;
		  end
  end
  end
  */
  
  SU5: //Check user's password
    begin
  
        if(!cs) begin
        addr = {userName1,userName2,userName3};
        pass_rw = 0;
		  count_rw = 0;
		  lock_rw = 1;
        cs = 1;
	
      end
		
      else begin
        if(pass_out == {pass1,pass2,pass3,pass4})
		  begin
		  passCheck = 1;
		  nextState = SU6;
		  cs = 0;
		  end
		  
		  else
		  begin
		  nextState = SU7;
		  count_in = count_out + 1;
		  if(count_in > 2)
		  lock_in = 1;
		  end
  end
  end 
  
  
  SU6:
  begin
  logined_Can_Request_a_Floor = 1;
  nextState = start;
  end
  
  SU7: //add 1 more to the failed attempts for user
    begin
  
        pass_rw = 0;
		  count_rw = 1;
		  lock_rw = 1;
		  nextState = start;
		  cs = 0;
  end

  
  
  
/*
    CheckUsername: begin
      if(!ram_cs) begin
        ram_addr = {usernameDigitOne,usernameDigitTwo,usernameDigitThree};
        ram_pass_rw = 0;
        ram_cs = 1;
      end
      else begin
        ... ram_pass_out ...
        .
        .
        .
        ram_cs = 0;
      end */
  endcase
end
end


	 
    
endmodule
