## Demo Video

Video:
https://drive.google.com/file/d/1jZy2ZyH5dAbM2AyaXYYSpXWa6h94CVfk/view?usp=sharing

# IOS Card Game Project

## Description

This project is an iOS card game developed using Swift, UIKit and Storyboard.

The application allows the user to enter a name, get the current location, determine the player's side (East Side or West Side), and play a card game against the computer.

The game consists of 10 rounds. At the end of the game, the winner and final score are displayed.

---

## Features

- Save player name using UserDefaults
- Get user location using CoreLocation
- Determine player side according to longitude
- East Side / West Side logic
- Automatic card game with random cards
- 10 game rounds
- Score calculation
- Countdown timer between rounds
- Result screen with winner and score
- Back to main menu button
- Background music
- Card sound effects
- Victory sound effect
- Game over sound effect
- Dark Mode support
- Portrait and Landscape support

---

## Game Rules

1. The player enters a name.
2. The application gets the user's location.
3. The player's side is determined:
   - East Side
   - West Side
4. The game starts automatically.
5. Each round both the player and the PC receive a random card.
6. The card with the higher value wins the round.
7. The winner receives one point.
8. After 10 rounds the game ends.
9. The result screen displays the winner and final score.

---

## Location Logic

The application uses CoreLocation.

Middle longitude:

34.817549168324334

If the user's longitude is greater than the middle longitude:

- East Side

Otherwise:

- West Side

---

## Screens

### Main Screen

- Enter player name
- Display player side
- Start button

### Game Screen

- Player score
- PC score
- Timer
- Random cards
- Background music

### Result Screen

- Winner display
- Final score
- Back to menu button

---

## Technologies

- Swift
- UIKit
- Storyboard
- CoreLocation
- AVFoundation
- UserDefaults

---

## How To Run

1. Open the project in Xcode.
2. Select an iPhone simulator.
3. Run the application.
4. Allow location permission.
5. Enter a player name.
6. Press START.

---

## Author

May Shabat

Computer Science Student

Afeka College of Engineering
