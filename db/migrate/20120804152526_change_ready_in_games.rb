class ChangeReadyInGames < ActiveRecord::Migration
  def change
    change_column :games, :ready, :boolean, default:false
  end
end
