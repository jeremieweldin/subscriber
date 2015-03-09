module Subscriber
  class User < ActiveRecord::Base
    has_secure_password
    
    has_one :member, :class_name => "Subscriber::Member"
    belongs_to :meta, polymorphic: true
    belongs_to :organization, :class_name => "Subscriber::Organization"
    accepts_nested_attributes_for :organization

    validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

    after_create :send_signup_email
    
    def send_signup_email
      #to-do: put this in a background job
      Subscriber::UserMailer.sign_up_success(self).deliver
    end
    
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
