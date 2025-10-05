class UI
  MAX_TRIES = 10
  attr_accessor :game, :serializer

  def initialize(serializer)
    @serializer = serializer
  end

  def start
    choice = new_or_saved
    game_state = serializer.load_state(choice)
    self.game = game_state
    play
  end



  # PRIVATE METHODS
  private

  def new_or_saved
    puts "1) New Game"
    puts "2) Saved Game"
    print "Enter your choice (1 or 2): "
    choice = gets.chomp.to_i

    return choice if choice_valid?(choice)

    new_or_saved
  end

  def choice_valid?(choice)
    choice == 1 || choice == 2
  end

  def play
    display

    while game.lives > 0
      guess = make_guess
  
      if guess == "save"
        serializer.save_game_state(game)
        return
      end

      game.update(guess)

      if game.won?
        puts winning_message
        return
      end

      game.lives = game.lives - 1
      display
    end

    puts losing_message
  end
  
  def display
    puts game.input_fields.join(' ')
    puts "Wrong guesses: #{game.wrong_guesses.join(', ')}"
    puts "You have #{game.lives} guesses left"
  end

  def make_guess
    print "Enter your guess (a-z) or 'save' to save the game: "
    guess = gets.chomp

    return guess if guess_valid?(guess)

    puts "Incorrect guess, Try again!!"
    make_guess
  end

  def guess_valid?(guess)
    (/[a-z]/.match?(guess) && guess.length == 1 && !game.input_fields.include?(guess) &&
    !game.wrong_guesses.include?(guess)) || guess == "save"
  end

  def winning_message
    "Congrats!! You won the game in #{MAX_TRIES - game.lives} tries."
  end

  def losing_message
    "You are out of tries!! Better luck next time. The code was #{game.word}"
  end
end