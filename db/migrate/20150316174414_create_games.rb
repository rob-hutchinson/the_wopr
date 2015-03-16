class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :type, null: false
      t.text :players, null: false
      t.text :state, null: false
      t.integer :current_player, null: false

      t.timestamps null: false
    end
  end
end
