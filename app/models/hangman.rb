class Hangman < Game

  Words = File.
    read("/usr/share/dict/words").
    split("\n").
    select { |w| w.length < 8 && w.length > 1 }.
    map { |w| w.chomp }
 
  def self.start_game user1
    game = Hangman.new
    game.players = [user1.id]
    game.state = [Words.sample, [], 6]
    game.current_player = 1
    game.save!
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
    self.state[1]
  end

  def answer
    self.state[0].downcase
  end

  def guesses_left
    self.state[2]
  end
 
  def take_move guess
    self.guessed_letters << guess
    unless answer.include? guess.downcase
      state << (state.pop - 1)
    end
    self.save!
  end
 
  def lost?
    guesses_left == 0
  end
 
  def won?
    board == answer
  end
  
  def self.saved_game id
    Hangman.find(id)
  end
end