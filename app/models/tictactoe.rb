class Tictactoe < ActiveRecord::Base
  belongs_to :users
  
  attr_reader :player1, :player2

  def set_players 
    players = [self.user_id1, self.user_id2]
    @player1 = players.shuffle!.pop
    @player2 = players.first
  end

  def place sym, space
    if board[space-1] == "_" && space < 10 && space > 0
      board[space - 1] = sym
    end
    save!
  end

  def over? 
    if board.exclude?("_") || winner?
      true
    end
  end

  def value_at space
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

  def winning_player
    if winner? == "x"
      @player1
    elsif winner? == "o"
      @player2
    end
  end
end
