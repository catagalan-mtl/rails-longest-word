require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alpha = ('A'..'Z').to_a
    @letters = 10.times.map { alpha.sample }
  end

  def score
    # raise
    @word = params[:word]
    grid = params[:token]
    letters = grid.split(", ")
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = JSON.parse(URI.open(url).read)

    if dictionary["found"] == true
      @word.upcase.split("").each do |letter|
        if letters.include?(letter)
          i = letters.find_index(letter)
          letters.delete_at(i)
        else
          @comment = "Sorry but #{@word.upcase} can't be built out of #{grid}"
          return 0
        end
      end
      @comment = "Congratulations! #{@word.upcase} is a valid English word!"
    else
      @comment = "Sorry but #{@word.upcase} does not seeem to be a valid English word..."
    end
  end
end
