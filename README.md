# The Chess Clock 

<!-- Team Details -->

## Team Members

<details>
  <summary>Detail</summary>

  > Semister: 3rd Sem B.Tech CSE

  > Section: S2

  > Memeber-1: Abhyuday Rayala, 221CS239, rayalaabhyuday.221cs239@nitk.edu.in

  > Member-2: Pramod Chaitanya Dandu, 221CS235, pramodchaitanya.221cs235@nitk.edu.in

  > Member-3: Manohar Rohit Vijay, 221CS230, rohitvijaymanohar.221cs230@nit.edu.in
  
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>

  ![Uploading image.png…]()

  
  > The aim of this mini project, "Development of a Digital Chess Clock System," is to address the shortcomings of traditional chess clocks and provide a solution that enhances the chess playing experience. With the advent of technology, we seek to offer a convenient and feature-rich alternative for chess enthusiasts and tournament organizers. This project introduces a state-of-the-art digital chess clock system that combines precision, usability, and flexibility.

</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

  >### Timer Logic

-**7-seg Display**

￼	<img width="409" alt="image" src="https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/a00d2c42-5b74-440f-bfe8-9fd8c55fa7e8">

  > ### Game Start

- When the 'start' button is pressed, the clock transitions to player 1's turn. Their timer starts counting down, and the other player's timer is paused.

### Player Turn

- During each player's turn, their timer counts down while the opponent's timer remains paused. Players can switch the timers by pressing the 'switch' button. This feature is useful in games where players take turns alternately.

### Surrender

- If a player decides to surrender by pressing the 'surrender' button, their timer stops, and their opponent is declared the winner. The losing player's timer displays a red light, while the winning player's timer displays a green light, signaling the game outcome.

### Reset

- This option resets the timer of both the players. To start a new match or to end up the match, this can be used.

This digital chess clock ensures fair play by limiting the time available for each move and provides a visual indication of the game's progress, making it a valuable tool for competitive chess matches.
## Operation Mode

<img width="370" alt="image" src="https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/0bc80849-1793-41c8-8144-ee98b1b21d97">

### Functioning

- **Clock Logic**: The main clock feeds both timers with pulses periodically. It is designed in such a way that if any one of the players surrenders, then it stops giving pulses to the timers.

- **Reset Logic**: Moving to the next state by passing only one pulse. Must push on 0 first.

- **Stop/Start Logic**:
  - **Stop**: When Stop/Start pin is set to 0, which is connected to surrender and clock to simulate the required timer.
  - **Start**: When Stop/Start pin is set to 1, Clock gate gets supplied by null voltage, hence activation of one of the timers.

This digital chess clock ensures fair play by limiting the time available for each move and provides a visual indication of the game's progress, making it a valuable tool for competitive chess matches.

### Timer Logic

-**7-seg Display**

￼	<img width="409" alt="image" src="https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/a00d2c42-5b74-440f-bfe8-9fd8c55fa7e8">

### Surrender logic

When surrender pin is set to 1, It is in connection with start button, finally resulting in stoppage of the timer and declaring the winner with green light.
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  > -**Clock IC**

![image](https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/3c5d2d32-0f81-4e6a-9b3e-c3cf6f94c04f)


![image](https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/27e9c48e-943e-4fc2-9de1-2eb405021699)

</details>

## Verilog Code
<details>
  <summary>Detail</summary>

### Chess_clock.v
 
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

## ChessClock_tb.v

>module chess_clock_tb();
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

</details>
