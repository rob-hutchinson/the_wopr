require 'simplecov'
SimpleCov.start 'rails'
require 'rails_helper'

RSpec.describe Tictactoe, type: :model do
  
  it "can generate a new game" do
    user1 = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    Tictactoe.start_game user1, user2

    game = Tictactoe.first

    expect(game.state).to eq [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    expect(game.id).to eq 1
  end

  it "allows users to make moves" do
    newtictactoe
    game = Tictactoe.saved_game 1

    game.take_turn 1
    expect(game.state).to eq ["X", nil, nil, nil, nil, nil, nil, nil, nil]
    game.take_turn 5
    expect(game.state).to eq ["X", nil, nil, nil, "O", nil, nil, nil, nil]
    game.take_turn 9
    expect(game.state).to eq ["X", nil, nil, nil, "O", nil, nil, nil, "X"]
  end

  it "can find previously generated games" do
    newtictactoe
    game = Tictactoe.saved_game 1
    
    game.take_turn 1
    game.take_turn 2
    game.take_turn 3

    newtictactoe
    loaded_game = Tictactoe.saved_game 1
    expect(loaded_game.state).to eq ["X", "O", "X", nil, nil, nil, nil, nil, nil]
    loaded_game = Tictactoe.saved_game 2
    expect(loaded_game.state).to eq [nil, nil, nil, nil, nil, nil, nil, nil, nil]
  end

  it "wont let users place where there is already a move" do
    newtictactoe
    game = Tictactoe.saved_game 1

    game.take_turn 1
    game.take_turn 1
    expect(game.state).to eq ["X", nil, nil, nil, nil, nil, nil, nil, nil]
  end

  it "wont let users try to place outside the board" do
    newtictactoe
    game = Tictactoe.saved_game 1

    game.take_turn 10
    expect(game.state).to eq [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    game.take_turn -20  
    expect(game.state).to eq [nil, nil, nil, nil, nil, nil, nil, nil, nil]
  end

  it "knows when the game is over" do
    newtictactoe
    game = Tictactoe.saved_game 1
    game.update state: ["X","O","X","O","O","X",nil,"X","O"]

    game.take_turn 7
    expect(game.over?).to eq true
    expect(game.winner?).to eq nil
  end

  it "knows who won" do
    newtictactoe
    game = Tictactoe.saved_game 1
    game.update state: ["X","O","X","O","X","O","X",nil,nil]

    expect(game.over?).to eq true
    expect(game.winner?).to eq "X"  
    expect(game.winning_player).to eq 1

    game.update state: ["O","X",nil,"O","X",nil,"O",nil,"X"]

    expect(game.over?).to eq true
    expect(game.winner?).to eq "O"
    expect(game.winning_player).to eq 2
  end
end