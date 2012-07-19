class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :which_player
      t.timestamps
    end
  end
end
