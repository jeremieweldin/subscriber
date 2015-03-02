module Subscriber
  class Member < ActiveRecord::Base
    belongs_to :account, :class_name => "Subscriber::Account"
    belongs_to :user, :class_name => "Subscriber::User"
  end
end
