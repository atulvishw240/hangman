require 'yaml'

class Game
  MAX_TRIES = 5
  TOTAL_WORDS = 9894
  attr_accessor :secret_word, :input_fields, :wrong_guesses

  def initialize
    @secret_word = select_word
    @input_fields = Array.new(secret_word.length, "_")
    @wrong_guesses = Array.new
  end

  def play
    puts secret_word
    display(input_fields)
    one_line_space
    counter = 1

    while counter <= MAX_TRIES
      play_one_set(counter)
      try_or_tries = counter == 1 ? "try" : "tries"
      if has_player_won?
        puts "Congrats!! You won the game in #{counter} #{try_or_tries}"
        break
      elsif counter == MAX_TRIES
        puts "You lost the game!!. The secret word was #{secret_word}."
      end

      guesses_left(counter)
      one_line_space
      counter += 1
    end
  end

  # ALL PRIVATE METHODS ARE BELOW
  private

  def select_word
    fname = 'dictionary.txt'
    word = select_random_word(fname)
    return word if word_is_between_5_to_12_chars?(word)

    select_word
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

  def word_is_between_5_to_12_chars?(word)
    word.length.between?(5, 12)
  end

  def play_one_set(counter)
    guess = take_player_guess
    update_input_fields_with_player_guess(guess)
    display(input_fields)
    display_wrong_guesses(guess)
  end

  def take_player_guess
    print "Enter your guess: "
    gets[0].downcase.chomp
  end

  def update_input_fields_with_player_guess(guess)
    if secret_word.include?(guess)
      secret_word.split('').each_with_index do |char, index|
        input_fields[index] = guess if char == guess
      end
    end
  end

  # Display 'owl' as o w l
  def display(array)
    puts array.join(' ')
  end

  def display_wrong_guesses(guess)
    wrong_guesses << guess unless secret_word.include?(guess)
    wrong_guesses_string = wrong_guesses.uniq.join(', ')
    puts "Wrong guesses: #{wrong_guesses_string}"
  end

  def guesses_left(counter)
    puts "You have #{MAX_TRIES - counter} guesses left"
  end

  def one_line_space
    puts ""
  end

  def has_player_won?
    input = input_fields.join('')
    input == secret_word
  end

  def play_existing_or_new_game
    print_message("1) Enter '1' to load an existing game")
    print_message("2) Enter '2' to play a new game")
    one_line_space
    print_message("Enter your choice: ")
    gets.chomp.to_i
  end

  def select_game_based_on_choice(choice)
    if choice == 1
      load_existing_game
    elsif choice == 2
      self.play
    end
  end

  def load_existing_game
    data = YAML.load_file("save.yaml")
    @secret_word = data[:secret_word]
    @input_fields = data[:input_fields]
    @wrong_guesses = data[:wrong_guesses]
    puts data.inspect

    counter = wrong_guesses.length + (input_fields.uniq.length - 1)
    puts counter
    
    self.play(counter)
  end

  def to_yaml
    YAML.dump({
      :secret_word => @secret_word,
      :input_fields => @input_fields,
      :wrong_guesses => @wrong_guesses
    })
  end

  def save_game(string)
    game_file = File.new("save.yaml", "w")
    game_file.write(string)
    game_file.close
  end

  def print_message(string)
    puts string
  end
end