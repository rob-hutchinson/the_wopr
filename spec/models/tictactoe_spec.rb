require 'rails_helper'

RSpec.describe Tictactoe, type: :model do
  
  it "users can make moves" do
    user1 = FactoryGirl.create :user
    user2 = FactoryGirl.create :user
    game = FactoryGirl.create :tictactoe, user_id1: user1.id, user_id2: user2.id
    
    game.place "x", 1
    expect(game.board).to eq "x________"
    game.place "o", 5
    expect(game.board).to eq "x___o____"
    game.place "x", 9
    expect(game.board).to eq "x___o___x"
  end
end
