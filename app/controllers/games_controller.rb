require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    # raise
    @letters = params[:token].split('')
    @answer = params[:answer].upcase

    if !in_the_grid?
      @result = :not_in_the_grid
    elsif english_word?
      @result = :not_an_english_word
    else
      @result = :congrats
    end
  end

  private

  def in_the_grid?
    @array_answer = @answer.split('')
    @suppr_array = @letters
    @array_answer.all? do |letter|
      @array_answer.count(letter) <= @letters.count(letter)
    end
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer].upcase}"
    @serialized_word = open(url).read
    @parse_word = JSON.parse(@serialized_word)
    return @parse_word['found'] == true
  end
end

