class Hangman < Game

  Words = File.
    read("/usr/share/dict/words").
    split("\n").
    select { |w| w.length < 8 && w.length > 1 }.
    map { |w| w.chomp }
 
  def self.start_game user1
    game = Hangman.create!({
      current_player: user1.id,
      state: {
        :answer => Words.sample,
        :guessed_letters => [], 
        :guesses_left => 6
      }
    })
   game.players.push user1
   game
  end

  def board
    result = ""
    
    answer.split("").each do |letter|
      if guessed_letters.include? letter
        result += letter
      else
        result += "_"
      end
    end
    result
  end

  def guessed_letters
    self.state["guessed_letters"]
  end

  def answer
    self.state["answer"].downcase
  end

  def guesses_left
    self.state["guesses_left"]
  end
 
  def take_move guess 
    unless self.guessed_letters.include? guess
      self.guessed_letters << guess
    end
    unless answer.include? guess.downcase
      self.state["guesses_left"] -= 1
    end
    self.save!
  end
 
  def lost?
    guesses_left == 0
  end

  def won?
    board == answer
  end

  def over?
    if self.lost? || self.won?
      true
    end
  end

  def game_player
    User.find(current_player)
  end
  
  def self.saved_game id
    Hangman.find(id)
  end
end