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

 > module chess_clock(
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

</details>
## Abstract

The aim of this mini project, "Development of a Digital Chess Clock System," is to address the shortcomings of traditional chess clocks and provide a solution that enhances the chess playing experience. With the advent of technology, we seek to offer a convenient and feature-rich alternative for chess enthusiasts and tournament organizers. This project introduces a state-of-the-art digital chess clock system that combines precision, usability, and flexibility.

### Key Contributions

- **User-Friendly Interface**: Our system features an intuitive LCD interface with easily accessible control buttons, ensuring straightforward operation for players of all levels.
- **Customizable Time Controls**: Chess players can tailor time settings to suit their preferences, incorporating delay and increment options for added tactical depth.
- **Dual-Clock Mode**: The system supports competitive play with dual clocks, making it ideal for tournament use.
- **Accessibility Features**: To promote inclusivity, we have integrated audio cues, making the system accessible to visually impaired players.
- **Win Probability**: The system predicts the winning probability based on the time gap between two players, considering individual ratings.

This project not only modernizes the traditional chess clock but also serves as a potential solution for other strategy-based board games. It offers a comprehensive and innovative tool that caters to the evolving needs of the chess community and paves the way for the integration of digital technology into traditional board gaming.

## Description

A digital clock designed for chess games. It mainly consists of two timers which cannot count at the same time. The source clock is alternatively transmitted between the two down counters using a switcher.

<img width="282" alt="image" src="https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/d0a97024-e9a4-41c7-b000-1cc7a1639809">

The following is a schematic diagram of the idea behind the implementation of this clock

(https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/5af7991d-348a-4264-8eae-59d4eaee5f95)


## 7 segment IC

<img width="504" alt="image" src="https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/fe66d630-3f61-4bce-b158-c81edef7b981">


## Working And Features

### Game Start

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

### Logisim Part
-**Clock IC**

![image](https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/3c5d2d32-0f81-4e6a-9b3e-c3cf6f94c04f)


![image](https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/27e9c48e-943e-4fc2-9de1-2eb405021699)

