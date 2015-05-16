module Subscriber
  class Organization < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true
    belongs_to :owner, :class_name => "Subscriber::User"
    has_many :users, :class_name => "Subscriber::User"
    
    def send_signup_email
      #to-do: put this in a background job
      p "*******************************"
      p self
      if self.org_type == "Agency"
        Subscriber::UserMailer.sign_up_agency_success(self.owner).deliver
      else
        Subscriber::UserMailer.sign_up_client_success(self.owner).deliver
      end
    end

    def org_name
      name
    end

    def org_location
      return nil unless city && state
      "#{city}, #{state}"
    end

    def org_owner_id
      owner_id
    end
  end
end
