class DeleteReadyFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :ready
  end
end
