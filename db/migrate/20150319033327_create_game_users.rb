class CreateGameUsers < ActiveRecord::Migration
  def change
    create_table :game_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :game, index: true

      t.timestamps null: false
    end
    add_foreign_key :game_users, :users
    add_foreign_key :game_users, :games
  end
end
