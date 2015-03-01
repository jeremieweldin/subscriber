module Subscriber
  class Account < ActiveRecord::Base
    validates :subdomain, :presence => true, :uniqueness => true

    belongs_to :owner, :class_name => "Subscriber::User"
    
    accepts_nested_attributes_for :owner
  end
end
