module Subscriber
  class User < ActiveRecord::Base
    has_secure_password
    belongs_to :organization, :class_name => "Subscriber::Organization"
    has_one :member, :class_name => "Subscriber::Member"
    accepts_nested_attributes_for :organization
    
    def send_password_reset
      generate_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      save!
      Subscriber::UserMailer.password_reset(self).deliver
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while Subscriber::User.exists?(column => self[column])
    end
  end
end
