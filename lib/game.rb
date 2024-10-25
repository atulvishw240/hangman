# 1. Computer will choose a word
# 2. Player gets 5 guesses to guess the word
# 3. If player guesses the word correctly >= 5 tries THEN he wins
# 4. If out of tries THEN player loses
class Game
  MAX_TRIES = 5
  TOTAL_WORDS = 9894
  attr_accessor :secret_word, :input_fields

  def initialize
    @secret_word = select_word
    @input_fields = Array.new(secret_word.length, "_")
  end

  def play
    counter = 1
    while counter <= MAX_TRIES
      guess = take_player_guess
      update_input_fields_with_player_guess(guess)
      end_game_message(counter)

      counter += 1
    end
  end

  # ALL PRIVATE METHODS ARE BELOW
  # private
  def select_word
    fname = 'dictionary.txt'
    if file_exist?(fname)
      word = select_random_word(fname)
      return word if is_word_between_5_to_12_chars?(word)

      select_word
    else
      "File 'dictionary.txt' doesn't exist"
    end
  end

  def file_exist?(fname)
    File.exist?(fname)
  end

  def select_random_word(fname)
    rndm_index = random_index_generation
    words_array = File.readlines(fname)
    words_array[rndm_index].chomp
  end

  def random_index_generation
    random = Random.new
    random.rand(0..TOTAL_WORDS - 1)
  end

  def is_word_between_5_to_12_chars?(word)
    word.length.between?(5, 12)
  end

  def take_player_guess
    add_space_between_chars(input_fields)
    one_line_space
    print "Enter your guess: "
    gets[0].downcase.chomp
  end

  # Display 'owl' as o w l
  def add_space_between_chars(array)
    puts array.join(' ')
  end

  def one_line_space
    puts ""
  end

  def update_input_fields_with_player_guess(guess)
    if secret_word.include?(guess)
      secret_word.split('').each_with_index do |char, index|
        input_fields[index] = guess if char == guess
      end
    end
  end

  def end_game_message(counter)
    try_or_tries = counter == 1 ? "try" : "tries"
    if has_player_won?
      puts "Congrats!! You won the game in #{counter} #{try_or_tries}"
    elsif counter == 5
      puts "You lost the game!!. The secret word was #{secret_word}."
    end
  end

  def has_player_won?
    input_fields == secret_word
  end
end