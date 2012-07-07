class AddIndexToPlayersPlayerName < ActiveRecord::Migration
  def change
    add_index :players, :player_name, unique: true
    add_index :players, :email, unique: true
  end
end
