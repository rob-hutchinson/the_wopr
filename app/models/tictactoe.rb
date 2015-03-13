class Tictactoe < ActiveRecord::Base
  belongs_to :users


  def boardstate  
    return self.board.split("")
  end
  
  def place sym, space
    current_board = boardstate
    unless current_board[space-1] != "_"
      current_board[space - 1] = sym
    end
    update(board: current_board.join(""))
  end
end
