class AddOwnerIdToSubsrciberOrganizations < ActiveRecord::Migration
  def change
    add_column :subscriber_organizations, :owner_id, :integer
    add_index :subscriber_organizations, :owner_id
  end
end
