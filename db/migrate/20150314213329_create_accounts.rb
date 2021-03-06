class CreateAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :session_id

      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
