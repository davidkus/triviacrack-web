class AddEmailToAccounts < ActiveRecord::Migration[4.2]
  def change
    add_column :accounts, :email, :string
  end
end
