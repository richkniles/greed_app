class AddTurnIdToRoll < ActiveRecord::Migration
  def change
    add_column :rolls, :turn_id, :integer
  end
end
