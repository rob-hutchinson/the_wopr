class GamesController < ApplicationController

  def index
    @games = current_user.games
  end


end