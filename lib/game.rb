class Game
  MAX_TRIES = 12
  TOTAL_WORDS = 9894
  attr_accessor :secret_word, :input_fields, :wrong_guesses

  def initialize
    @secret_word = select_word
    @input_fields = Array.new(secret_word.length, "_")
    @wrong_guesses = Array.new
  end

  def play
    puts secret_word
    counter = 1
    display(input_fields)

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
      counter += 1
    end
  end

  # ALL PRIVATE METHODS ARE BELOW
  private

  def select_word
    fname = 'dictionary.txt'
    if file_exist?(fname)
      word = select_random_word(fname)
      return word if word_is_between_5_to_12_chars?(word)

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

  def word_is_between_5_to_12_chars?(word)
    word.length.between?(5, 12)
  end

  def play_one_set(counter)
    guess = take_player_guess
    update_input_fields_with_player_guess(guess)
    display(input_fields)
    display_wrong_guesses(guess)
    one_line_space
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
end