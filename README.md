# lifecounter
My family enjoys playing Magic:The Gathering over dinner while we are out to eat in restaurants. We need an app to help track each player's "life total" during the game.

# The basics
For those unfamiliar with the game, each player starts with 20 "life"; various actions in the game will add or remove from that total. Usually, it's one point at a time, but sometimes it can be in larger groupings. When a player's life reaches 0, they are dead and out of the game; a player's life can (easily) go above 20, and there is no upper limit, though totals grater than 999 are exceedingly rare. (You can assume it'll never go above 999.)

# Stories:
As a user, when I launch the application, it should show me controls for two players. Each player (named Player 1 and Player 2, respectively) should have a label for their name (Player 1 or Player 2), life total, and four pushbuttons ("+", "-","+5","-5").

As a user, when I push the "+" pushbutton for player 1, it should increment player 1's life total by 1. "-" should reduce the life total by 1, "+5" should increment by 5, and "-5" should decrement by 5.

As a user, when a player's life total drops to 0 or less, it should display a label at the bottom of the app saying "Player X LOSES!"

As a user, when I rotate the device (landscape to portrait mode or vice versa), it should resize itself evenly.

As a user, when I run the app on different devices, it should seem "equally balanced" on each device, regardless of orientation. Players' life total labels should be proportional, buttons proportional, and so on.

# Grading (5 pts)
repo should be called 'lifecounter'

1 pt for each satisfied story

-------------------------------------------------
# Life Counter v2 – Homework Assignment

## 📋 Description

After presenting the LifeCounter app, the client has provided additional requirements. These updates will be implemented in a new branch called `v2` of the original `lifecounter` project.

---

## 📌 Stories (Required)

### ✅ Story 1 (1 pt)
> _"I often want to add/remove life in chunks other than 5 at a time."_  
Change the `+5` / `-5` buttons into:
- A numeric input field (accepts only numbers),
- Paired with `+Custom` / `-Custom` buttons,
- To allow for flexible life adjustments.

---

### ✅ Story 2 (2 pts)
> _"When I launch the application, it should show me four 'players', but allow for a flexible number of players in total, from 2 to 8."_  
Requirements:
- App starts with **4 players**, each with 20 life.
- An **"Add Player"** button allows adding more players (up to 8).
- Once any player's life changes (game has started), disable the Add Player button until game is reset.

---

### ✅ Story 3 (2 pts)
> _"I often want to look back at the history of the game."_  
Create a **"History" screen** that:
- Opens when user taps a **"History"** button,
- Displays a list of all game actions, such as:  
  - `"Player 1 lost one life."`  
  - `"Player 3 lost four life."`

---

## 🌟 Bonus Features (1 pt each)

### ⭐ Bonus 1
> _"When all but one player has lost (life totals to less than zero), it should display 'Game over!' and an OK button."_  
- On game over:
  - Show a dialog with "Game over!" and an OK button,
  - Pressing OK resets the app back to its original state (4 players, all at 20 life),
  - History is also cleared.
- Also add a **"Reset"** button on the main screen that does the same reset manually.

---

### ⭐ Bonus 2
> _"I want to add names to the players."_  
- Tapping on the player name label opens a **name-editing dialog**, allowing the user to enter a custom name for the player.

---

## 🛠️ Implementation Notes

- All new functionality should be implemented in the `v2` branch.
- Use UIKit and Storyboard as before.
- Use `hidden` and `isHidden` techniques where appropriate to support showing/hiding player views.

---

## ✅ Grading Rubric (Total: 5 pts + bonus)

| Feature | Points |
|--------|--------|
| Custom add/subtract amount input | 1 pt |
| Dynamic players (2–8) and Add Player lock | 2 pts |
| History screen and action log | 2 pts |
| Bonus: Game over dialog and reset button | +1 pt |
| Bonus: Editable player names | +1 pt |

---




