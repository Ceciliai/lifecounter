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



