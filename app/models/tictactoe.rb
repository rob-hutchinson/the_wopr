class Tictactoe < ActiveRecord::Base
  belongs_to :users


  def boardstate  
    return self.board.split("")
  end
  
  def place sym, space
    current_board = boardstate
    current_board[space - 1] = sym
    update(board: current_board.join(""))
  end
end
