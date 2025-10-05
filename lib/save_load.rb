require "yaml"
require_relative "game_engine"
require_relative "utility"

class SaveLoad

  def save_game_state(game)
    string = to_yaml(game)
    game_file = File.new("save.yaml", "w")
    game_file.write(string)
    game_file.close
  end
 
  def load_state(new_or_saved)
    return new_state if new_or_saved == 1

    return load_existing_state if new_or_saved == 2
  end

  # PRIVATE METHODS
  private

  def to_yaml(game)
    YAML.dump(game)
  end

  def new_state
    word = Utility.select_word
    input_fields = Array.new(word.length, "_")
    wrong_guesses = Array.new

    GameEngine.new(word, input_fields, wrong_guesses)
  end

  def load_existing_state
    YAML.load_file("save.yaml", permitted_classes: [GameEngine])
  end
end