class GamesController < ApplicationController

  def index
    binding.pry
    @games = Game.where()
  end


end