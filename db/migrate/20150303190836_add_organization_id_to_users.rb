class AddOrganizationIdToUsers < ActiveRecord::Migration
  def change
    add_column :subscriber_users, :organization_id, :integer
    add_index :subscriber_users, :organization_id
  end
end
