class ChangeFromToFromPlayerInMessage < ActiveRecord::Migration
  def change
    rename_column :messages, :from, :from_player
    rename_column :messages, :to,   :to_player
  end
end
