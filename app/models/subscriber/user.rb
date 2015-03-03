module Subscriber
  class User < ActiveRecord::Base
    has_secure_password
    belongs_to :organization, :class_name => "Subscriber::Organization"
    accepts_nested_attributes_for :organization
  end
end
