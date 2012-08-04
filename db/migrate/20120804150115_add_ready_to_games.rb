class AddReadyToGames < ActiveRecord::Migration
  def change
    add_column :games, :ready, :boolean
  end
end
