class ChangeBoard < ActiveRecord::Migration
  def change
    remove_column :tictactoes, :x
    remove_column :tictactoes, :o
    add_column :tictactoes, :board, :string, default:"_________"  
  end
end
