# Contains Game Logic
class GameEngine
  attr_accessor :word, :input_fields, :wrong_guesses, :lives

  def initialize(word, input_fields, wrong_guesses, lives)
    @word = word
    @input_fields = input_fields
    @wrong_guesses = wrong_guesses
    @lives = lives
  end

  def update(letter)
    if word.include?(letter)
      update_input_fields(letter)
    else
      wrong_guesses << letter
    end
  end

  def update_input_fields(letter)
    word.chars.each_with_index do |char, index|
      input_fields[index] = letter if char == letter
    end
  end

  def won?
    word.chars == input_fields
  end
end