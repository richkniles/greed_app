class RenameDiceToDiceStringInRoll < ActiveRecord::Migration
  def change
    rename_column :rolls, :dice, :dice_string
  end
end
