require 'simplecov'
SimpleCov.start 'rails'
require 'rails_helper'

RSpec.describe Tictactoe, type: :model do
  
  it "users can make moves" do
    game = newtictactoe

    game.place "x", 1
    expect(game.board).to eq "x________"
    game.place "o", 5
    expect(game.board).to eq "x___o____"
    game.place "x", 9
    expect(game.board).to eq "x___o___x"
  end

  it "wont let users place where there is already a move" do
    game = newtictactoe

    game.place "x", 1
    game.place "o", 1
    expect(game.board).to eq "x________"
  end

  it "wont let users try to place outside the board" do
    game = newtictactoe

    game.place "x", 10
    expect(game.board).to eq "_________"
    game.place "x", -20  
    expect(game.board).to eq "_________"
  end

  it "knows when the game is over" do
    game = FactoryGirl.create :tictactoe, board: "xoxxoo_xo"
    
    game.place "x", 7
    expect(game.over?).to eq true
    expect(game.winner?).to eq "x"
  end

  fit "knows who won" do
    user1 = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    game1 = FactoryGirl.create :tictactoe, board: "xoxoxox__", user_id1: user1.id, user_id2: user2.id 

    game1.set_players
    
    expect(game1.over?).to eq true
    expect(game1.winner?).to eq "x"
    expect(game1.winning_player).to eq game1.player1
  end
end
