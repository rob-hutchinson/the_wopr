class HangmanController < ApplicationController
  
  def show
    @game = Hangman.saved_game params[:id]
    @board = @game.board.split("").join(" ")
    if current_user == @game.game_player
      render :show
    end
  end
 
  def move
    game = Hangman.saved_game params[:id]
    if game.over?
      flash[:danger] = "This game is already over!"
    elsif current_user == game.game_player     
      game.take_move params["/games/hangman/#{params[:id]}"]["selected_letter"]
    else
      flash[:danger] = "It's not your turn to play!"
    end
    redirect_to hangman_show_path(game)
  end
 
  def create
    Hangman.start_game current_user
    redirect_to hangman_show_path(Hangman.last)
  end
end