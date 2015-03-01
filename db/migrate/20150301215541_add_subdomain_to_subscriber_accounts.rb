class AddSubdomainToSubscriberAccounts < ActiveRecord::Migration
  def change
    add_column :subscriber_accounts, :subdomain, :string
    add_index :subscriber_accounts, :subdomain
  end
end
