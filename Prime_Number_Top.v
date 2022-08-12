module Prime_Number_Top
  (input i_Clk,
   input i_Switch_1,  
   input i_Switch_2,
   output o_LED_1,
   output o_LED_2,
   output o_Segment1_A,
   output o_Segment1_B,
   output o_Segment1_C,
   output o_Segment1_D,
   output o_Segment1_E,
   output o_Segment1_F,
   output o_Segment1_G,
   output o_Segment2_A,
   output o_Segment2_B,
   output o_Segment2_C,
   output o_Segment2_D,
   output o_Segment2_E,
   output o_Segment2_F,
   output o_Segment2_G);
   
   
  reg [24:0] count1;
  reg [25:0] count2;
  reg [1:0]  clk_slow;
  reg [3:0]  countPrime = 4'b0000; 
  reg [3:0]  digi1 = 4'b0000;
  reg [3:0]  digi2 = 4'b0000;
  reg [1:0]  pause = 1'b0;
  
  
  wire w_Segment1_A;
  wire w_Segment1_B;
  wire w_Segment1_C;
  wire w_Segment1_D;
  wire w_Segment1_E;
  wire w_Segment1_F;
  wire w_Segment1_G;
  wire w_Segment2_A;
  wire w_Segment2_B;
  wire w_Segment2_C;
  wire w_Segment2_D;
  wire w_Segment2_E;
  wire w_Segment2_F;
  wire w_Segment2_G;
  
  wire w_Switch_1;
  wire w_Switch_2;
  reg  r_Switch_1 = 1'b0;
  reg  r_Switch_2 = 1'b0;

  assign o_LED_1 = ~clk_slow;
  
  
	 
  always @(posedge i_Clk) begin
     r_Switch_1 <= w_Switch_1;
     r_Switch_2 <= w_Switch_2;
     if (w_Switch_2 == 1'b1 && r_Switch_2 == 1'b0) begin
        pause = ~pause; 
        end 
     if (~pause) begin
        if (w_Switch_1 == 1'b1 && r_Switch_1 == 1'b0) begin
           count1 <= 0;
           count2 <= 0;
           digi1 <= 0;
           digi2 <= 0;
           countPrime <= 0;
	       end
        count1    <= count1 + 1;
        count2    <= count2 + 1;
        if (count1 == 25000000) begin 
           count1 <= 0;
           clk_slow = ~clk_slow; 
	    end
        if (count2 == 50000000)begin 
	       count2 <= 0;
	    if (countPrime == 4'd1) begin 
	       countPrime <= countPrime + 1;
	       digi1 <= 0;
	       digi2 <= 2;
	    end else if (countPrime == 4'd2) begin
	       countPrime <= countPrime + 1;
	       digi1 <= 0;
	       digi2 <= 3;
	    end else if (countPrime == 4'd4) begin
	       countPrime <= countPrime + 1;
	       digi1 <= 0;
	       digi2 <= 5;
	    end else if (countPrime == 4'd6) begin
	       countPrime <= countPrime + 1;
	       digi1 <= 0;
	       digi2 <= 7;
	    end else if (countPrime == 4'd10) begin
	       countPrime <= 0;
	       digi1 <= 1;
	       digi2 <= 1;
	    end else begin
	       countPrime <= countPrime + 1;
	       end
	    end
	 end
  end
	
	
  // Instantiate Doubounce Module
  Debounce_Switch Debounce_Switch_Inst
    (.i_Clk(i_Clk),
     .i_Switch1(i_Switch_1),
     .o_Switch1(w_Switch_1),
	 .i_Switch2(i_Switch_2),
     .o_Switch2(w_Switch_2));
 
 
 // Instantiate Binary to 7-Segment Converter (right display)
  Binary_To_7Segment Inst
    (.i_Clk(i_Clk),
     .i_Binary_Num(digi1),
     .o_Segment_A(w_Segment1_A),
     .o_Segment_B(w_Segment1_B),
     .o_Segment_C(w_Segment1_C),
     .o_Segment_D(w_Segment1_D),
     .o_Segment_E(w_Segment1_E),
     .o_Segment_F(w_Segment1_F),
     .o_Segment_G(w_Segment1_G)
     );
	 
  assign o_Segment1_A = ~w_Segment1_A;
  assign o_Segment1_B = ~w_Segment1_B;
  assign o_Segment1_C = ~w_Segment1_C;
  assign o_Segment1_D = ~w_Segment1_D;
  assign o_Segment1_E = ~w_Segment1_E;
  assign o_Segment1_F = ~w_Segment1_F;
  assign o_Segment1_G = ~w_Segment1_G;
  
  // Instantiate Binary to 7-Segment Converter (left display)
  Binary_To_7Segment SevenSeg2_Inst
   (.i_Clk(i_Clk),
    .i_Binary_Num(digi2),
    .o_Segment_A(w_Segment2_A),
    .o_Segment_B(w_Segment2_B),
    .o_Segment_C(w_Segment2_C),
    .o_Segment_D(w_Segment2_D),
    .o_Segment_E(w_Segment2_E),
    .o_Segment_F(w_Segment2_F),
    .o_Segment_G(w_Segment2_G));
   
  assign o_Segment2_A = ~w_Segment2_A;
  assign o_Segment2_B = ~w_Segment2_B;
  assign o_Segment2_C = ~w_Segment2_C;
  assign o_Segment2_D = ~w_Segment2_D;
  assign o_Segment2_E = ~w_Segment2_E;
  assign o_Segment2_F = ~w_Segment2_F;
  assign o_Segment2_G = ~w_Segment2_G;

 
endmodule