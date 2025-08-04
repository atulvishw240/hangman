class UI
  attr_reader :game

  def initialize(game)
    @game = game
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

    raise "You have made an incorrect guess, Try again!!"
    
    make_guess
  end

  def valid?(guess)
    /[a-z]/.match?(guess) && guess.length == 1 && !game.input_fields.include?(guess) &&
    !game.wrong_guesses.include?(guess)
  end
end