# Welcome to Xavis Adventure
This is a community project created on my [Twitch channel](https://twitch.tv/novas1r1). Please feel free to contribute to the project, join the stream, fix bugs, add features... whatever you want :)! I'm doing this as a learning project for getting to know [Flame-Engine](https://flame-engine.org/) a little bit better. Go check them out!

The game is based of a game I created in university together with my sister in 2012 using Microsoft XNA. It's called "XAVIS ADVENTURE" because of the main character called Xavi. It's inspired by bomberman and similiar 2D games.

## Contributors
- Thanks to the Flame team for answering questions and providing this cool engine <3!
- Thanks to my sister for the graphics <3!
- Thanks to the contributors and stream attendees <3!
    - @dumazy (https://github.com/dumazy)

# TODO
## General
- Moving through all the screens
## Screens
### Home Screen
#### Functionality
- Menu
    - Buttons: 
        - Start: GameScreen LVL1
        - Highscore: HighScoreScreen
        - Exit: Close the game

#### Graphics
- Background
- Buttons: Start, HighScore, Exit
- Buttons with different States (Active, Hover, Inactive)

### Introduction Screen
#### Functionality
- should only be visible the first time || on button click

### Game Screen
#### 1. Step
- going back to Menu
- generating map
- player 
    - moving with WASD
    - shooting with space
    - collision detection with walls
#### 2. Step
- player: set moving area
- enemies
    - collision detection with walls
    - collision detection with player
        -> kills player
    - collision detection with gun
- traps
    - collision detection with player

## Prepare
- using Tiled map (https://thorbjorn.itch.io/tiled)
- player: set moving area

## Questions
- Web or Mobile first?
## Todo later
- Highscore
- collision detection with traps
## Ideas Future
- Multiplayer
- Procedural Generation

## Issues
- glitching while walking



