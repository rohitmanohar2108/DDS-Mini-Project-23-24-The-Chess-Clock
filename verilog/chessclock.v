//verilog and its testbench code 
module chess_clock(
  input wire clk,             // Clock input
  input wire reset,           // Reset signal for timers
  input wire start,           // Start signal for timers
  input wire surrender_player1, // Surrender button for player 1
  input wire surrender_player2, // Surrender button for player 2
  input wire switch_turn,     // Switch turn signal
  output reg [6:0] seg_player1_min1, // 7-segment display for player 1 minutes (tens)
  output reg [6:0] seg_player1_min0, // 7-segment display for player 1 minutes (units)
  output reg [6:0] seg_player1_sec1, // 7-segment display for player 1 seconds (tens)
  output reg [6:0] seg_player1_sec0, // 7-segment display for player 1 seconds (units)
  output reg [6:0] seg_player2_min1, // 7-segment display for player 2 minutes (tens)
  output reg [6:0] seg_player2_min0, // 7-segment display for player 2 minutes (units)
  output reg [6:0] seg_player2_sec1, // 7-segment display for player 2 seconds (tens)
  output reg [6:0] seg_player2_sec0, // 7-segment display for player 2 seconds (units)
  output reg player1_green_led,     // Green LED indicating player 1's victory
  output reg player2_green_led,     // Green LED indicating player 2's victory
  output reg player1_red_led,       // Red LED indicating player 1's loss
  output reg player2_red_led        // Red LED indicating player 2's loss
);

  reg [3:0] min_ones_player1; // 4-bit register for player 1 minutes (units)
  reg [3:0] min_tens_player1; // 4-bit register for player 1 minutes (tens)
  reg [3:0] sec_ones_player1; // 4-bit register for player 1 seconds (units)
  reg [3:0] sec_tens_player1; // 4-bit register for player 1 seconds (tens)

  reg [3:0] min_ones_player2; // 4-bit register for player 2 minutes (units)
  reg [3:0] min_tens_player2; // 4-bit register for player 2 minutes (tens)
  reg [3:0] sec_ones_player2; // 4-bit register for player 2 seconds (units)
  reg [3:0] sec_tens_player2; // 4-bit register for player 2 seconds (tens)

  reg [1:0] player_turn; // 2-bit counter to track player turns (00: Player 1, 01: Player 2)

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      min_ones_player1 <= 4'd0;
      min_tens_player1 <= 4'd0;
      sec_ones_player1 <= 4'd0;
      sec_tens_player1 <= 4'd0;

      min_ones_player2 <= 4'd0;
      min_tens_player2 <= 4'd0;
      sec_ones_player2 <= 4'd0;
      sec_tens_player2 <= 4'd0;

      player_turn <= 2'b00;

      seg_player1_min1 <= 7'b0000000;   // Initialize 7-segment displays to 0
      seg_player1_min0 <= 7'b0000000;
      seg_player1_sec1 <= 7'b0000000;
      seg_player1_sec0 <= 7'b0000000;

      seg_player2_min1 <= 7'b0000000;
      seg_player2_min0 <= 7'b0000000;
      seg_player2_sec1 <= 7'b0000000;
      seg_player2_sec0 <= 7'b0000000;

      player1_green_led <= 1'b0;
      player2_green_led <= 1'b0;
      player1_red_led <= 1'b0;
      player2_red_led <= 1'b0;
    end
    else if (start) begin
      // Timer logic for player 1
      if (player_turn == 2'b00) begin
        if (sec_ones_player1 < 4'd9) begin
          sec_ones_player1 <= sec_ones_player1 + 1;
        end
        else if (sec_tens_player1 < 4'd5) begin
          sec_ones_player1 <= 4'd0;
          sec_tens_player1 <= sec_tens_player1 + 1;
        end
        else if (min_ones_player1 < 4'd9) begin
          sec_tens_player1 <= 4'd0;
          sec_ones_player1 <= 4'd0;
          min_ones_player1 <= min_ones_player1 + 1;
        end
        else if (min_tens_player1 < 4'd5) begin
          sec_tens_player1 <= 4'd0;
          sec_ones_player1 <= 4'd0;
          min_ones_player1 <= 4'd0;
          min_tens_player1 <= min_tens_player1 + 1;
        end
        else begin
          // Player 1 has won, set LEDs accordingly
          player1_green_led <= 1'b1;
          player2_red_led <= 1'b1;
        end
      end
    end
  end
endmodule

//test-bench

module chess_clock_tb();
  reg clk;
  reg reset;
  reg start;
  reg surrender_player1;
  reg surrender_player2;
  reg switch_turn;
  wire [6:0] seg_player1_min1;
  wire [6:0] seg_player1_min0;
  wire [6:0] seg_player1_sec1;
  wire [6:0] seg_player1_sec0;
  wire [6:0] seg_player2_min1;
  wire [6:0] seg_player2_min0;
  wire [6:0] seg_player2_sec1;
  wire [6:0] seg_player2_sec0;
  wire player1_green_led;
  wire player2_green_led;
  wire player1_red_led;
  wire player2_red_led;

  // Instantiate the chess_clock module
  chess_clock clock_inst (
    .clk(clk),
    .reset(reset),
    .start(start),
    .surrender_player1(surrender_player1),
    .surrender_player2(surrender_player2),
    .switch_turn(switch_turn),
    .seg_player1_min1(seg_player1_min1),
    .seg_player1_min0(seg_player1_min0),
    .seg_player1_sec1(seg_player1_sec1),
    .seg_player1_sec0(seg_player1_sec0),
    .seg_player2_min1(seg_player2_min1),
    .seg_player2_min0(seg_player2_min0),
    .seg_player2_sec1(seg_player2_sec1),
    .seg_player2_sec0(seg_player2_sec0),
    .player1_green_led(player1_green_led),
    .player2_green_led(player2_green_led),
    .player1_red_led(player1_red_led),
    .player2_red_led(player2_red_led)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Display lines for test cases
  initial begin
    $display("Starting Test Cases");
    $display("-------------------");

    // Stimulus generation
    clk = 0;
    reset = 1;
    start = 0;
    surrender_player1 = 0;
    surrender_player2 = 0;
    switch_turn = 0;

    // Apply reset and wait for a few clock cycles
    #10 reset = 0;
    $monitor("Time: Player 1 %d%d:%d%d, Player 2 %d%d:%d%d",
      seg_player1_min1, seg_player1_min0, seg_player1_sec1, seg_player1_sec0,
      seg_player2_min1, seg_player2_min0, seg_player2_sec1, seg_player2_sec0);
    $display("Test Case 1: Reset");
    $display("-------------------");

    // Start the timer
    #10 start = 1;

    // Test Case 2: Player 1's turn, player 2 surrenders
    $monitor("Time: Player 1 %d%d:%d%d, Player 2 %d%d:%d%d",
      seg_player1_min1, seg_player1_min0, seg_player1_sec1, seg_player1_sec0,
      seg_player2_min1, seg_player2_min0, seg_player2_sec1, seg_player2_sec0);
    $display("Test Case 2: Player 1's turn, player 2 surrenders");
    $display("-------------------");
    #100 surrender_player2 = 1;
    #100 surrender_player2 = 0;

    // Test Case 3: Switching turns
    $monitor("Time: Player 1 %d%d:%d%d, Player 2 %d%d:%d%d",
      seg_player1_min1, seg_player1_min0, seg_player1_sec1, seg_player1_sec0,
      seg_player2_min1, seg_player2_min0, seg_player2_sec1, seg_player2_sec0);
    $display("Test Case 3: Switching turns");
    $display("-------------------");
    #100 switch_turn = 1;
    #100 switch_turn = 0;

    // Test Case 4: Player 2's turn, player 1 surrenders
    $monitor("Time: Player 1 %d%d:%d%d, Player 2 %d%d:%d%d",
      seg_player1_min1, seg_player1_min0, seg_player1_sec1, seg_player1_sec0,
      seg_player2_min1, seg_player2_min0, seg_player2_sec1, seg_player2_sec0);
    $display("Test Case 4: Player 2's turn, player 1 surrenders");
    $display("-------------------");
    #100 surrender_player1 = 1;
    #100 surrender_player1 = 0;

    // Test Case 5: Player 2's turn, player 2 wins
    $monitor("Time: Player 1 %d%d:%d%d, Player 2 %d%d:%d%d",
      seg_player1_min1, seg_player1_min0, seg_player1_sec1, seg_player1_sec0,
      seg_player2_min1, seg_player2_min0, seg_player2_sec1, seg_player2_sec0);
    $display("Test Case 5: Player 2's turn, player 2 wins");
    $display("-------------------");
    #100 switch_turn = 1;
    #100 switch_turn = 0;
    #100 switch_turn = 1;
    #100 switch_turn = 0;
    #100 switch_turn = 1;
    #100 switch_turn = 0;

    // End simulation
    $display("End of Test Cases");
    $finish;
  end
endmodule
