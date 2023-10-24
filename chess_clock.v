module chess_clock (
    input wire clk,
    input wire reset,
    input wire start,
    input wire pause,
    input wire player1_add_time,
    input wire player2_add_time,
    output wire [15:0] player1_time,
    output wire [15:0] player2_time,
    output wire player1_flag,
    output wire player2_flag
);

reg [15:0] player1_time;
reg [15:0] player2_time;
reg player1_flag;
reg player2_flag;
reg [1:0] state;
reg [15:0] player1_delay;
reg [15:0] player2_delay;

parameter COUNT_MAX = 16'd50000; // Adjust this value for different clock speeds
parameter DELAY_MAX = 16'd1000; // Maximum delay time

always @(posedge clk or posedge reset) begin
    if (reset) begin
        player1_time <= 16'b0000_0000_0000_0000;
        player2_time <= 16'b0000_0000_0000_0000;
        player1_flag <= 1'b1;
        player2_flag <= 1'b0;
        state <= 2'b00;
    end else if (start) begin
        case (state)
            2'b00: begin // Player 1's turn
                if (player1_time < COUNT_MAX) begin
                    player1_time <= player1_time + 1;
                end else begin
                    player1_time <= 16'b0000_0000_0000_0000;
                    player1_flag <= 1'b0;
                    state <= 2'b01;
                end
            end
            2'b01: begin // Player 2's turn
                if (player2_time < COUNT_MAX) begin
                    player2_time <= player2_time + 1;
                end else begin
                    player2_time <= 16'b0000_0000_0000_0000;
                    player2_flag <= 1'b0;
                    state <= 2'b00;
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (start && !pause) begin
        if (player1_flag) begin
            player1_time <= player1_time - 1;
        end else begin
            player2_time <= player2_time - 1;
        end
    end
end

always @(posedge clk) begin
    if (player1_add_time && player1_time + player1_delay < COUNT_MAX) begin
        player1_delay <= player1_delay + 1;
    end else if (!player1_add_time) begin
        player1_delay <= 16'b0000_0000_0000_0000;
    end
    if (player2_add_time && player2_time + player2_delay < COUNT_MAX) begin
        player2_delay <= player2_delay + 1;
    end else if (!player2_add_time) begin
        player2_delay <= 16'b0000_0000_0000_0000;
    end
end

always @(posedge clk) begin
    if (start) begin
        case (state)
            2'b00: player1_flag <= 1'b1;
            2'b01: player2_flag <= 1'b1;
        endcase
    end
end

endmodule
