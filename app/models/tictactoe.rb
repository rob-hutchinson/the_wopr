class Tictactoe < ActiveRecord::Base
  belongs_to :users
  
  attr_reader :player1, :player2

  def self.start_game user1, user2
    players = [user1, user2]
    @player1 = players.shuffle!.pop
    @player2 = players.first
    return Tictactoe.create!(user_id1: @player1.id, user_id2: @player2.id, currentplayer: @player1.id)
  end

  def self.saved_game id
    Tictactoe.find(id)
  end

  def sym
    if currentplayer == user_id1
      "x"
    elsif currentplayer == user_id2
      "o"
    end
  end

  def update_current_player
    if currentplayer == user_id1
      self.update(currentplayer: user_id2)
    elsif currentplayer == user_id2
      self.update(currentplayer: user_id1)
    end
  end

  def place space
    if board[space-1] == "_" && space < 10 && space > 0
      board[space - 1] = sym
      update_current_player
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
      user_id1
    elsif winner? == "o"
      user_id2
    end
  end

end
