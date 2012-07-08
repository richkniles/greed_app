class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user1
      t.integer :user2

      t.timestamps
    end
  end
end
