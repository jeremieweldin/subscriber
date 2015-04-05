module Subscriber
  class ApplicationController < ::ApplicationController
    skip_before_filter :authenticate_user!
    layout false
  end
end
