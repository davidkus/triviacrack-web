class UpdateDefaultIdGenerators < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :id, -> { "next_id()" }
    change_column_default :accounts, :id, -> { "next_id()" }
    change_column_default :queued_games, :id, -> { "next_id()" }
  end
end
