`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:46:29 01/20/2019 
// Design Name: 
// Module Name:    Elevator 
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
module Elevator(clk, rst, inDoorButtons, outDoorButtons, keyPadInput, pass_out, count_out, admin_out, lock_out, state , warning ,
 logined_Can_Request_a_Floor, motor, doorState, currentFloor);
	 
input clk, rst;
input [4:1] keyPadInput;
output [16:1]pass_out;
output [4:1] count_out;
output admin_out, lock_out;
output[8:1] state;
output warning;
output logined_Can_Request_a_Floor;

input[3:1] inDoorButtons,outDoorButtons;
output[1:0] motor;
output doorState;
output[3:1] currentFloor;

wire[3:1] inButtons, outButtons;
assign inButtons[1] = inDoorButtons[1] & logined_Can_Request_a_Floor;
assign inButtons[2] = inDoorButtons[2] & logined_Can_Request_a_Floor;
assign inButtons[3] = inDoorButtons[3] & logined_Can_Request_a_Floor;

assign outButtons[1] = outDoorButtons[1] & logined_Can_Request_a_Floor;
assign outButtons[2] = outDoorButtons[2] & logined_Can_Request_a_Floor;
assign outButtons[3] = outDoorButtons[3] & logined_Can_Request_a_Floor;

E1 movement(
.CLK(clk),
.RST(rst),
.inDoorButtons(inButtons),
.outDoorButtons(outButtons),
.motor(motor),
.doorState(doorState),
.currentFloor(currentFloor)
);

ram_usage ram(
.clk(clk),
.rst(rst),
.keyPadInput(keyPadInput),
.pass_out(pass_out),
.count_out(count_out),
.admin_out(admin_out),
.lock_out(lock_out),
.state(state),
.warning(warning),
.logined_Can_Request_a_Floor(logined_Can_Request_a_Floor));




					


endmodule
