///////////////////////////////////////////////////////////////////////////////
// File downloaded from http://www.nandland.com
///////////////////////////////////////////////////////////////////////////////
// This module is used to debounce any switch or button coming into the FPGA.
// Does not allow the output of the switch to change unless the switch is
// steady for enough time (not toggling).
///////////////////////////////////////////////////////////////////////////////
module Debounce_Switch (input i_Clk, input i_Switch1, input i_Switch2, output o_Switch1, output o_Switch2);
 
  parameter c_DEBOUNCE_LIMIT = 250000;  // 10 ms at 25 MHz
   
  reg [17:0] r_Count1 = 0;
  reg [17:0] r_Count2 = 0;
  reg r_State1 = 1'b0;
  reg r_State2 = 1'b0;
 
  always @(posedge i_Clk)
  begin
    // Switch input is different than internal switch value, so an input is
    // changing.  Increase the counter until it is stable for enough time.  
    if (i_Switch1 !== r_State1 && r_Count1 < c_DEBOUNCE_LIMIT)
      r_Count1 <= r_Count1 + 1;
 
    // End of counter reached, switch is stable, register it, reset counter
    else if (r_Count1 == c_DEBOUNCE_LIMIT)
    begin
      r_State1 <= i_Switch1;
      r_Count1 <= 0;
    end 
 
    // Switches are the same state, reset the counter
    else
      r_Count1 <= 0;
  end
  
    always @(posedge i_Clk)
  begin
    // Switch input is different than internal switch value, so an input is
    // changing.  Increase the counter until it is stable for enough time.  
    if (i_Switch2 !== r_State2 && r_Count2 < c_DEBOUNCE_LIMIT)
      r_Count2 <= r_Count2 + 1;
 
    // End of counter reached, switch is stable, register it, reset counter
    else if (r_Count2 == c_DEBOUNCE_LIMIT)
    begin
      r_State2 <= i_Switch2;
      r_Count2 <= 0;
    end 
 
    // Switches are the same state, reset the counter
    else
      r_Count2 <= 0;
  end

 
  // Assign internal register to output (debounced!)
  assign o_Switch1 = r_State1;
  assign o_Switch2 = r_State2;
 
endmodule