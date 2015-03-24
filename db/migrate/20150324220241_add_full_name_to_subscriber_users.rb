class AddFullNameToSubscriberUsers < ActiveRecord::Migration
  def change
    add_column :subscriber_users, :full_name, :string
  end
end
