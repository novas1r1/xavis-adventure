# xavis-adventure
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
- glitching while walking (multiple idle animation)
# Contributors




