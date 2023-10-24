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
