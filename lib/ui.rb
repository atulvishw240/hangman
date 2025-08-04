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
end