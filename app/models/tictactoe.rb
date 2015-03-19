class Tictactoe < Game

  def self.start_game user1, user2
    game = Tictactoe.create!({
      current_player: 0,
      state: {
        :board => [nil]*9
      }
    })
    game.players.push user1
    game.players.push user2
    game
  end

  def board
    self.state["board"]
  end

  def self.saved_game id
    Tictactoe.find(id)
  end

  def take_turn space  
    place current_sym, space
    update_current_player
    save!
  end
  
  def current_sym
    if current_player.zero?
      return "X"
    else
      return "O"
    end
  end

  def update_current_player
    if current_player.zero?
      self.update current_player: 1
    else
      self.update current_player: 0
    end
  end

  def place symbol, space
    if board[space-1] == nil && space < 10 && space > 0
      board[space - 1] = symbol
    end
  end

  def over? 
    if board.exclude?(nil) || winner?
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
    if winner? == "X"   
      players.first.id
    elsif winner? == "O"
      players.last.id
    end
  end

end
