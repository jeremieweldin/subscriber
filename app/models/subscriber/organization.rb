module Subscriber
  class Organization < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true
    belongs_to :owner, :class_name => "Subscriber::User"
    has_many :users, :class_name => "Subscriber::User"

    def org_name
      name
    end

    def location
      "#{city}, #{state}"
    end
  end
end
