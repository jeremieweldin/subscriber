class CreateSubscriberAccounts < ActiveRecord::Migration
  def change
    create_table :subscriber_accounts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
