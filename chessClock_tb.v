`timescale 1ns / 1ps

module test_bench;
    reg clk;
    reg reset;
    reg start;
    reg pause;
    reg player1_add_time;
    reg player2_add_time;
    wire [15:0] player1_time;
    wire [15:0] player2_time;
    wire player1_flag;
    wire player2_flag;

    // Instantiate the chess clock module
    chess_clock uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .pause(pause),
        .player1_add_time(player1_add_time),
        .player2_add_time(player2_add_time),
        .player1_time(player1_time),
        .player2_time(player2_time),
        .player1_flag(player1_flag),
        .player2_flag(player2_flag)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        start = 0;
        pause = 0;
        player1_add_time = 0;
        player2_add_time = 0;

        // Reset the clock
        reset = 1;
        #10 reset = 0;

        // Start the clock
        start = 1;

        // Simulate some clock cycles
        #100;

        // Pause the clock
        pause = 1;

        // Add time to player 1
        player1_add_time = 1;
        #50;
        player1_add_time = 0;

        // Resume the clock
        pause = 0;

        // Simulate some more clock cycles
        #100;

        // Stop the clock
        start = 0;

        // Simulate some more clock cycles
        #50;

        // End simulation
        $finish;
    end
endmodule
