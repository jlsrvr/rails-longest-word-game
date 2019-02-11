require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    counter = 0
    @letters = []
    alphabet = ('A'..'Z').to_a
    until counter >= 10
      @letters << alphabet.sample(1)
      counter += 1
    end
    @letters
  end

  def score
    grid = params[:letters].split(//)
    @attempt = params[:proposition]
    attempts = @attempt.upcase.split(//)
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt.downcase}"
    result_serialized = open(url).read
    result = JSON.parse(result_serialized)
    english_word = result['found']
    if attempts.all? { |letter| attempts.count(letter) <= grid.count(letter) } && english_word == true
      @message = "Congratulations! #{@attempt.upcase} is a valid english word."
    elsif attempts.all? { |letter| attempts.count(letter) <= grid.count(letter) } && english_word == false
      @message = "Sorry but #{@attempt.upcase} does not seem to be an english word"
    else
      @message = "Sorry but #{@attempt.upcase} can't be built from #{letters}"
    end
  end
end
