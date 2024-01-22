require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = ["A", "P", "E", "P", "L", "H", "B", "C", "D", "Z"]
    # 10.times { @letters << ("A".."Z").to_a.sample }
  end

  def score
    # get input from form
    @input = params[:new]

    # algo to calculate score
    # - is the word an english word?
    is_english?

    # - is the word included in letters?
    p is_included?
  end

  private

  def is_english?
    # fetch API with input
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    attempt_serialized = URI.open(url).read
    attempt = JSON.parse(attempt_serialized)

    attempt["found"]
  end

  def is_included?
    grid = params[:letters]
    @input.upcase.chars.all? { |letter|
      # p letter
      # p @input
      # checks how often the current letter is in the input and the grid.
      @input.upcase.count(letter) <= grid.count(letter)
    }
    # debugger
    # raise
  end
end
