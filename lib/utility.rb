module Utility
  TOTAL_WORDS = 9894

  def self.select_word
    fname = "dictionary.txt"
    rndm_index = Random.new.rand(0..TOTAL_WORDS - 1)
    words_array = File.readlines(fname)
    word = words_array[rndm_index].chomp

    return word if word.length.between?(5, 12)

    select_word
  end
end