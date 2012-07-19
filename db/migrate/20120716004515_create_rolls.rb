class CreateRolls < ActiveRecord::Migration
  def change
    create_table :rolls do |t|
      t.string :dice

      t.timestamps
    end
  end
end
