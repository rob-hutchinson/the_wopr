class TictactoesController < ApplicationController

  def show
    @game = Tictactoe.saved_game params[:id]
    if current_user.id == @game.currentplayer
      render :play # view for player, has form for making next move, unless the game is over
    else
      render :spectate # view for spectators, has no form
    end
  end
 
  def move
    game = Tictactoe.saved_game params[:id]
    if game.over?
      flash[:danger] = "This game is already over!"
    elsif current_user.id == game.currentplayer
      game.place params[:selected_space]
    else
      flash[:danger] = "It's not your turn to play!"
    end
    redirect_to tictacto_path(game)
  end
 
  def create
    game = Tictactoe.start_game current_user params[:opponent]
    redirect_to tictacto_path(game)
  end

  def index
  end
end
