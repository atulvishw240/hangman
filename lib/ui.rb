class UI
  MAX_TRIES = 10
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def start
    display

    while game.lives > 0
      guess = make_guess
      game.update(guess)
      display

      if game.won?
        puts winning_message
        return
      end

      game.lives = game.lives - 1
    end

    puts losing_message
  end

  def display
    puts game.input_fields.join(' ')
    puts "Wrong guesses: #{game.wrong_guesses.join(', ')}"
    puts "You have #{game.lives} guesses left"
  end

  def make_guess
    print "Enter your guess: "
    guess = gets.chomp

    return guess if valid?(guess)

    make_guess
  end

  def valid?(guess)
    /[a-z]/.match?(guess) && guess.length == 1 && !game.input_fields.include?(guess) &&
    !game.wrong_guesses.include?(guess)
  end

  def winning_message
    "Congrats!! You won the game in #{MAX_TRIES - game.lives} tries."
  end

  def losing_message
    "You are out of tries!! Better luck next time. The code was #{game.word}"
  end
end