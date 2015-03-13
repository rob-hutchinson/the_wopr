require 'rails_helper'

RSpec.describe Tictactoe, type: :model do
  
  it "users can make moves" do
    # user1 = FactoryGirl.create :user
    # user2 = FactoryGirl.create :user
    # game = FactoryGirl.create :tictactoe, user_id1: user1.id, user_id2: user2.id

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
end
