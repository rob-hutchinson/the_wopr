class UpdateGameModel < ActiveRecord::Migration
  def change
    remove_column :games, :players
  end
end
