class CreateTictactoes < ActiveRecord::Migration
  def change
    create_table :tictactoes do |t|
      t.string :x
      t.string :o
      t.integer :turn
      t.integer :user_id1
      t.integer :user_id2

      t.timestamps null: false
    end
  end
end
