require_relative "lib/game_engine"
require_relative "lib/ui"
require_relative "lib/utility"

word = Utility.select_word
input_fields = Array.new(word.length, "_")
wrong_guesses = Array.new

game = GameEngine.new(word, input_fields, wrong_guesses)
ui = UI.new(game)

ui.start