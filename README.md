# The Chess Clock 

<img width="288" alt="image" src="https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/41624ebf-6478-464a-af2c-60554d1f6497">


Chess, a timeless strategy game, has long relied on analog chess clocks for timed play. As the game evolves in the digital age, there is a growing need for a modern, versatile, and user-friendly digital chess clock system.

## Table of Contents

- [Team Members](#team-members)
- [Abstract](#abstract)
- [Description](#description)
- [Working And Features](#working-and-features)
- [Operation Mode](#Operation-mode)

## Team Members

- Abhyuday Rayala

- Pramod Chaitanya Dandu

- Manohar Rohit Vijay

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

￼	"
￼"<img width="409" alt="image" src="https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/a00d2c42-5b74-440f-bfe8-9fd8c55fa7e8">

### Surrender logic

When surrender pin is set to 1, It is in connection with start button, finally resulting in stoppage of the timer and declaring the winner with green light.

### Logisim Part
-**Clock IC**

![image](https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/3c5d2d32-0f81-4e6a-9b3e-c3cf6f94c04f)


![image](https://github.com/rohitmanohar2108/The-Chess-Clock/assets/122254093/27e9c48e-943e-4fc2-9de1-2eb405021699)

### Refrences

https://sweetcode.io/logisim-software-digital-clock/

https://en.wikipedia.org/wiki/Chess_clock

https://digitalgametechnology.com/products/chess-clocks/dgt2010-official-fide-chess-clock

https://ro.farnell.com/

https://github.com/Ruben304/LogicDesign/blob/main/FINAL/digital_clk_12hr.v
https://github.com/cadewey/Simple-Chess-Clock/tree/master/simplechessclock

