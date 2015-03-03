class AddOrganizationIdToMembers < ActiveRecord::Migration
  def change
    add_column :subscriber_members, :organization_id, :integer
    add_index :subscriber_members, :organization_id
  end
end
