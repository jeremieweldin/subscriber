module Subscriber
  class Organization < ActiveRecord::Base
    validates :name, :presence => true, :uniqueness => true

    has_many :users, :class_name => "Subscriber::User"
  end
end
