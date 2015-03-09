class AddMetaToUsers < ActiveRecord::Migration
  def change
    add_column :subscriber_users, :meta_id, :integer
    add_column :subscriber_users, :meta_type, :string

    add_index :subscriber_users, [:meta_id, :meta_type]
  end
end
