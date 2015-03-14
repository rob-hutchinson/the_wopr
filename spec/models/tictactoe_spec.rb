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
end
