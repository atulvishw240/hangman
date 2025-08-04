class UI
  MAX_TRIES = 10
  attr_accessor :game, :save_or_load

  def initialize(save_or_load)
    @save_or_load = save_or_load
  end

  def start
    choice = new_or_saved
    game_state = save_or_load.load_state(choice)
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

    return choice if choice == 1 || choice == 2

    new_or_saved
  end

  def play
    display

    while game.lives > 0
      guess = make_guess
  
      if guess == "save"
        save_or_load.save_game_state(game)
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

    return guess if valid?(guess)

    make_guess
  end

  def valid?(guess)
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