class AddGameIdToTurn < ActiveRecord::Migration
  def change
    add_column :turns, :game_id, :integer
  end
end
