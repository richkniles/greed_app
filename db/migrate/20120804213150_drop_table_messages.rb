class DropTableMessages < ActiveRecord::Migration
  def up
    drop_table :messages
  end

  def down
  end
end
