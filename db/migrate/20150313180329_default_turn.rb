class DefaultTurn < ActiveRecord::Migration
  def change
    change_column :tictactoes, :turn, :integer, default: 0
  end
end
