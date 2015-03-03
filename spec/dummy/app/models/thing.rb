class Thing < ActiveRecord::Base
  extend Subscriber::ScopedTo
end
