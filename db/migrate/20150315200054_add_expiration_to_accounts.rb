class AddExpirationToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :expiration, :datetime
  end
end
