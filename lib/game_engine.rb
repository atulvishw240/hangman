# Contains Game Logic
class GameEngine
  attr_accessor :word, :correct_guesses, :wrong_guesses

  def initialize(word, correct_guesses, wrong_guesses)
    @word = word
    @correct_guesses = correct_guesses
    @wrong_guesses = wrong_guesses
  end

  def update(letter)
    if word.include?(letter)
      correct_guesses << letter
    else
      wrong_guesses << letter
    end
  end
end