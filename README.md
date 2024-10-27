# HANGMAN

## Instructions

This Hangman game selects a word between 5-12 letters long from a text file. On each turn, you can guess one letter. To win, you must find all the letters in the word before using **10** incorrect guesses.

In addition, you may choose to save a game. It will be saved as a `save.yaml` file name. At the beginning of each game, you can choose to load a previously saved game.

To play this game: 
1. Clone this repository using `git clone git@github.com:atulvishw240/hangman.git`
2. Now enter the command `cd hangman/`
3. Run the command `ruby hangman.rb` to play the game.

## Problems that I faced

1. As my class don't take any arguments it was difficult for me to recreate the `game` object (**Unserialize**)
2. The hint *"You can serialize game classes too"* took me off track. If it wasn't for this hint, I would've completed this project sooner.

## Lessons Learned

1. Writing small methods isn't the only thing to look out for if you're trying to write clean code.
2. Although this was a small program but it could be still broken into multiple classes to reduce the coupling, that way if I wanted to change something I could do that easily. Like a separate class for `Player` and **seralization** and **deserialization** functionality could be placed in their own class. A `UserInterface` class could be used to segregate the interface part.
3. **Serialization** is just converting your **data structure** into string using some set of rules and then using these rules in the reverse order to reconstruct your original **data structure**.