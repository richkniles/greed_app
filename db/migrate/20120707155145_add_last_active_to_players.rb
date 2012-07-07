class AddLastActiveToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :last_active, :datetime
  end
end
