class AddOwnerIdToSubscriberAccounts < ActiveRecord::Migration
  def change
    add_column :subscriber_accounts, :owner_id, :integer
  end
end
