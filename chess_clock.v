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
