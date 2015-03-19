require 'simplecov'
SimpleCov.start 'rails'
require 'rails_helper'

RSpec.describe Hangman, type: :model do

  it "can generate a new game" do
    newhangman
    game = Hangman.first

    expect(game.answer).not_to be_nil
    expect(game.guessed_letters).to eq []
    expect(game.guesses_left).to eq 6
  end

  it "can find a game it has generated" do
    newhangman
    game = Hangman.first
    game.update(state: {:answer => "game", :guessed_letters => [], :guesses_left => 6})
    game.take_move "z"

    newhangman
    game2 = Hangman.saved_game 1

    expect(game2.guesses_left).to eq 5
    expect(game2.guessed_letters).to eq ["z"]
  end

  it "knows who is currently playing" do
    user = FactoryGirl.create :user, email: "rob@example.com"
    Hangman.start_game user
    game = Hangman.first
    
    expect(game.game_player.email).to eq "rob@example.com"
  end

  it "allows users to make a guess" do
    newhangman
    game = Hangman.first
    game.update(state: {:answer => "spinach", :guessed_letters => [], :guesses_left => 6})

    game.take_move "s"

    expect(game.guessed_letters).to eq ["s"]
    expect(game.guesses_left).to eq 6
  end

  it "takes away chances for wrong guesses" do
    newhangman
    game = Hangman.first
    game.update(state: {:answer => "fail", :guessed_letters => [], :guesses_left => 6})

    game.take_move "z"

    expect(game.guessed_letters).to eq ["z"]
    expect(game.guesses_left).to eq 5
  end

  it "knows when player has run out of guesses" do
    newhangman
    game = Hangman.first
    game.update(state: {:answer => "lost", :guessed_letters => ["a","b","c","d","e"], :guesses_left => 1})

    game.take_move "f"

    expect(game.over?).to eq true
    expect(game.lost?).to eq true
    expect(game.guesses_left).to eq 0
    expect(game.board).to eq "____"
  end

  it "knows when player has won" do
    newhangman
    game = Hangman.first
    game.update(state: { :answer => "win", :guessed_letters => [], :guesses_left => 6})

    game.take_move "w"
    game.take_move "i"
    
    expect(game.lost?).to eq false
    expect(game.board).to eq "wi_"

    game.take_move "n"
    
    expect(game.over?).to eq true
    expect(game.won?).to eq true
    expect(game.board).to eq "win"
    expect(game.guesses_left).to eq 6
  end

end