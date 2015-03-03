class CreateSubscriberOrganizations < ActiveRecord::Migration
  def change
    create_table :subscriber_organizations do |t|
      t.string :org_type
      t.string :name

      t.timestamps null: false
    end
    add_index :subscriber_organizations, :org_type
  end
end
