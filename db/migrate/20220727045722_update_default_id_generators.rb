class UpdateDefaultIdGenerators < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :id, :bigint
    change_column_default :users, :id, -> { "next_id()" }
    change_column :accounts, :id, :bigint
    change_column :accounts, :user_id, :bigint
    change_column_default :accounts, :id, -> { "next_id()" }
    change_column :queued_games, :id, :bigint
    change_column :queued_games, :account_id, :bigint
    change_column_default :queued_games, :id, -> { "next_id()" }
  end
end
