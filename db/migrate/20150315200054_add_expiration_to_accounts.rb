class AddExpirationToAccounts < ActiveRecord::Migration[4.2]
  def change
    add_column :accounts, :expiration, :datetime
  end
end
