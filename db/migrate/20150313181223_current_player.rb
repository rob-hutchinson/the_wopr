class CurrentPlayer < ActiveRecord::Migration
  def change
    add_column :tictactoes, :currentplayer, :integer, default: 1
  end
end
