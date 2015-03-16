class ChangeCurrentPlayer < ActiveRecord::Migration
  def change
    change_column :tictactoes, :currentplayer, :integer, default: :user_id1
  end
end
