class Tictactoe < ActiveRecord::Base
  belongs_to :users


  # def boardstate  
  #   return self.board.split("")
  # end
  
  def place sym, space
    # current_board = boardstate
    # if current_board[space-1] == "_" && space < 10 && space > 0
    #   current_board[space - 1] = sym
    # end
    # update(board: current_board.join(""))
    if board[space-1] == "_" && space < 10 && space > 0
      board[space - 1] = sym
    end
    save!
  end

  def over? 
    # if boardstate.exclude?("_") || winner?
    #   true
    # end
    if board.exclude?("_") || winner?
      true
    end
  end

  def value_at space
    # current_board = boardstate
    # current_board[space-1]
    board[space-1]
  end

  def winner?
    lines = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,5,9],
        [3,5,7],
        [1,4,7],
        [2,5,8],
        [3,6,9]
      ]
      lines.each do |line|
        if line.all? { |space| value_at(space) == value_at(line.first) }
          return value_at(line.first)
        end
      end
      nil
  end

end
