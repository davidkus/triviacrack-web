class CreateQueuedGames < ActiveRecord::Migration[4.2]
  def change
    create_table :queued_games do |t|
      t.integer :game_id, limit: 8

      t.belongs_to :account, index: true

      t.timestamps null: false
    end
  end
end
