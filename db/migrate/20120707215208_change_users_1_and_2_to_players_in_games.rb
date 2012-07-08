class ChangeUsers1And2ToPlayersInGames < ActiveRecord::Migration
  def change
    rename_column :games, :user1, :player1
    rename_column :games, :user2, :player2
  end
end
