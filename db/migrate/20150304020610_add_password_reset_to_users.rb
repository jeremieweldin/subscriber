class AddPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :subscriber_users, :password_reset_token, :string
    add_column :subscriber_users, :password_reset_sent_at, :datetime
  end
end
