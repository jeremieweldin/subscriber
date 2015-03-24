module Subscriber
  class Organization < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true
    belongs_to :owner, :class_name => "Subscriber::User"
    has_many :users, :class_name => "Subscriber::User"

    def org_name
      name
    end

    def org_location
      "#{city}, #{state}"
    end

    def org_owner_id
      owner_id
    end
  end
end
