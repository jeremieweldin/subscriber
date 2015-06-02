class AddIsActiveToSubscriberOrganizations < ActiveRecord::Migration
  def change
    add_column :subscriber_organizations, :is_active, :boolean, default: false
    add_column :subscriber_users, :is_admin, :boolean, default: false
  end
end
