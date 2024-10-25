# 1. Computer will choose a word
# 2. Player gets 5 guesses to guess the word
# 3. If player guesses the word correctly >= 5 tries THEN he wins
# 4. If out of tries THEN player loses
class Game
  MAX_TRIES = 5
  TOTAL_WORDS = 9894
  attr_accessor :secret_word

  def initialize
    # set the secret word
  end

  def play
    # Player will call this to play the game
  end

  # ALL PRIVATE METHODS ARE BELOW
  # private

  def display
    # Display the state of board
  end

  def choose_word
    # Choose the secret word from dictionary.txt
    rndm_index = random_index_generation
    fname = 'dictionary.txt'
    if file_exist?(fname)
      array = File.readlines(fname)
      word = array[rndm_index].chomp

      if word.length.between?(5, 12)
        return word
      else
        choose_word
      end

    else
      "File 'dictionary.txt' doesn't exist"
    end
  end

  def file_exist?(fname)
    File.exist?(fname)
  end

  def random_index_generation
    random = Random.new
    random.rand(0..TOTAL_WORDS - 1)
  end

  def guess_word
    # Give player 5 turns to guess the word
  end

  def end_game_message
    # Print winning or losing message
  end
end