module Subscriber
  class User < ActiveRecord::Base
    has_secure_password
    belongs_to :organization, :class_name => "Subscriber::Organization"
    delegate :org_type, :org_name, :industry, :employees, :org_location, :description, :org_owner_id, :avatar, to: :organization, allow_nil: true
    has_one :member, :class_name => "Subscriber::Member"
    accepts_nested_attributes_for :organization
    validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates_confirmation_of :password
    validates :password, 
      :format => {:with => /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).{6,}.+\z/, 
        message: "must be at least 7 characters and include one capital and lowercase letter, one number, and one special character."},
          :on => :create
    validates :password, 
      :format => {:with => /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).{6,}.+\z/, 
        message: "must be at least 7 characters and include one capital and lowercase letter, one number, and one special character."},
          :on => :update,
            :allow_blank => true
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
