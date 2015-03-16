require 'simplecov'
SimpleCov.start 'rails'
require 'rails_helper'

RSpec.describe Tictactoe, type: :model do
  
  it "can generate a new game" do
    user1 = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    Tictactoe.start_game user1, user2
  end

  it "can find previously generated games" do
    new_game = FactoryGirl.create :tictactoe, board: "xxo______"

    loaded_game = Tictactoe.saved_game 1
    expect(loaded_game.board).to eq "xxo______"
  end

  it "allows users to make moves" do
    game = newtictactoe

    game.place 1
    expect(game.board).to eq "x________"
    game.place 5
    expect(game.board).to eq "x___o____"
    game.place 9
    expect(game.board).to eq "x___o___x"
  end

  it "wont let users place where there is already a move" do
    game = newtictactoe

    game.place  1
    game.place  1
    expect(game.board).to eq "x________"
  end

  it "wont let users try to place outside the board" do
    game = newtictactoe

    game.place 10
    expect(game.board).to eq "_________"
    game.place -20  
    expect(game.board).to eq "_________"
  end

  it "knows when the game is over" do
    game = FactoryGirl.create :tictactoe, board: "xoxxoo_xo"
    
    game.place 7
    expect(game.over?).to eq true
    expect(game.winner?).to eq "x"
  end

  it "knows who won" do
    user1 = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    game1 = FactoryGirl.create :tictactoe, board: "xoxoxox__", user_id1: user1.id, user_id2: user2.id 
  
    expect(game1.over?).to eq true
    expect(game1.winner?).to eq "x"  
    expect(game1.winning_player).to eq game1.user_id1

    game2 = FactoryGirl.create :tictactoe, board: "ox_ox_o_x", user_id1: user1.id, user_id2: user2.id

    expect(game2.over?).to eq true
    expect(game2.winner?).to eq "o"
    expect(game2.winning_player).to eq game2.user_id2
  
  end
end
