require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @array = []
    10.times do
      source = ('A'..'Z').to_a
      @array << source.sample
    end
  end

  def score
    @word = params[:name].upcase
    @array = params[:range].split('')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = open(url).read
    thing = JSON.parse(word_serialized)
    @exist = thing["found"]
    if (@word.chars - @array).present? || @word == ''
      @answer = "Sorry, but #{@word} can't be build out of #{@array.join(', ')}"
    elsif @exist == false
      @answer = "Sorry, but #{@word} does not seem to be an English valid word"
    else
      @answer = "Congratulations ! #{@word} is a valid English word !"
    end
  end
end

